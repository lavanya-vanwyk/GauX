import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:latlong2/latlong.dart';

import '../../core/domain/failure.dart';
import '../../core/domain/result.dart';
import '../../features/booking/domain/entities/ride_quote.dart';
import '../../features/trip_tracking/domain/ports/trip_payment_port.dart';
import '../../features/wallet/data/datasources/wallet_api_datasource.dart';
import '../../features/wallet/data/repositories/api_gold_card_repository.dart';

/// Pays for trips through the GauX server ledger. The server prices the
/// ride itself, and charges refer to its quote, so the app never names an
/// amount.
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

    // The server checks again when charging; this stops a ride the rider
    // clearly can't pay for
    switch (await _wallet.load()) {
      case Err(:final failure):
        return Err(failure);
      case Success(:final value) when !value.canAfford(server.fareCents):
        return const Err(InsufficientFundsFailure('Balance below fare'));
      case Success():
        break;
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
      // No entry means the fee came to nothing
      Success(:final value) => Success(-(value.entry?.amountCents ?? 0)),
      Err(:final failure) => Err(failure),
    };
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
