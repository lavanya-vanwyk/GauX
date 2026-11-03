import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:latlong2/latlong.dart';

import '../../core/domain/failure.dart';
import '../../core/domain/result.dart';
import '../../features/booking/domain/entities/ride_quote.dart';
import '../../features/trip_tracking/domain/ports/trip_payment_port.dart';
import '../../features/wallet/data/datasources/wallet_api_datasource.dart';
import '../../features/wallet/data/repositories/api_gold_card_repository.dart';

/// Pays for trips through the GauX server ledger:
///
/// 1. The server prices the ride (a quote) and holds the fare in the
///    rider's wallet, so it can't be spent elsewhere mid-ride.
/// 2. On arrival or cancellation the server settles the hold: the fee to
///    GauX, the rest back to the rider.
/// 3. Cancelling before pickup releases the hold in full.
///
/// Every request is keyed by the quote, so retries can't double-charge.
class ApiTripPayments implements TripPaymentPort {
  const ApiTripPayments({
    required WalletApiDatasource api,
    required ApiGoldCardRepository wallet,
  }) : _api = api,
       _wallet = wallet;

  final WalletApiDatasource _api;
  final ApiGoldCardRepository _wallet;

  @override
  Future<Result<RideQuote>> confirmPrice(
    RideQuote quote, {
    required LatLng from,
    required LatLng to,
  }) async {
    final QuoteResponse server;
    switch (await _api.createQuote(
      QuoteRequest(
        from: GeoPoint(lat: from.latitude, lng: from.longitude),
        to: GeoPoint(lat: to.latitude, lng: to.longitude),
        rideType: quote.rideType.kind,
      ),
    )) {
      case Err(:final failure):
        return Err(failure);
      case Success(:final value):
        server = value;
    }

    final held = await _api.placeHold(
      HoldRequest(quoteId: server.id),
      idempotencyKey: 'hold:${server.id}',
    );
    switch (held) {
      case Err(failure: ServerFailure(code: ApiErrorCode.insufficientFunds)):
        return const Err(InsufficientFundsFailure('Balance below fare'));
      case Err(:final failure):
        return Err(failure);
      case Success(:final value):
        await _wallet.apply(value);
    }

    return Success(
      quote.copyWith(
        serverQuoteId: server.id,
        fareCents: server.fareCents,
        distanceMeters: server.distanceMeters,
        etaMinutes: server.etaMinutes,
      ),
    );
  }

  @override
  Future<Result<void>> chargeCompleted(RideQuote quote) async {
    return switch (await _charge(quote, cancelled: false)) {
      Success() => const Success(null),
      Err(:final failure) => Err(failure),
    };
  }

  @override
  Future<Result<int>> chargeCancelled(
    RideQuote quote, {
    required double distanceCoveredMeters,
  }) async {
    return switch (await _charge(
      quote,
      cancelled: true,
      distanceCoveredMeters: distanceCoveredMeters,
    )) {
      Success(:final value) => Success(value.chargedCents ?? 0),
      Err(:final failure) => Err(failure),
    };
  }

  @override
  Future<Result<void>> release(RideQuote quote) async {
    final quoteId = quote.serverQuoteId;
    if (quoteId == null) return const Success(null);
    final result = await _api.releaseHold(
      HoldRequest(quoteId: quoteId),
      idempotencyKey: 'release:$quoteId',
    );
    switch (result) {
      case Success(:final value):
        await _wallet.apply(value);
        return const Success(null);
      case Err(:final failure):
        return Err(failure);
    }
  }

  /// One charge per quote, keyed by the quote, so retries can't charge
  /// twice.
  Future<Result<WalletResponse>> _charge(
    RideQuote quote, {
    required bool cancelled,
    double distanceCoveredMeters = 0,
  }) async {
    final quoteId = quote.serverQuoteId;
    if (quoteId == null) {
      return const Err(ParsingFailure('Ride has no server quote to charge'));
    }
    final result = await _api.charge(
      ChargeRequest(
        quoteId: quoteId,
        cancelled: cancelled,
        distanceCoveredMeters: distanceCoveredMeters,
      ),
      idempotencyKey: 'ride:$quoteId',
    );
    if (result case Success(:final value)) await _wallet.apply(value);
    return result;
  }
}
