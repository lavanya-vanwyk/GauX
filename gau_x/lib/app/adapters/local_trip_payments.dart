import 'package:latlong2/latlong.dart';

import '../../core/domain/result.dart';
import '../../features/booking/domain/entities/ride_quote.dart';
import '../../features/booking/domain/policies/fare_calculator.dart';
import '../../features/trip_tracking/domain/ports/trip_payment_port.dart';
import '../../features/wallet/data/repositories/local_gold_card_repository.dart';

/// Pays for trips from the on-device wallet, for builds without the GauX
/// API. The app's own quote is the price.
class LocalTripPayments implements TripPaymentPort {
  const LocalTripPayments({
    required LocalGoldCardRepository wallet,
    required FareCalculator fares,
  }) : _wallet = wallet,
       _fares = fares;

  final LocalGoldCardRepository _wallet;
  final FareCalculator _fares;

  @override
  Future<Result<RideQuote>> confirmPrice(
    RideQuote quote, {
    required LatLng from,
    required LatLng to,
  }) async {
    final card = (await _wallet.load()).valueOrNull;
    if (card == null || !card.canAfford(quote.fareCents)) {
      return const Err(InsufficientFundsFailure('Balance below fare'));
    }
    return Success(quote);
  }

  @override
  Future<Result<void>> chargeCompleted(RideQuote quote) async {
    await _wallet.charge(
      amountCents: quote.fareCents,
      description: quote.rideType.displayName,
    );
    return const Success(null);
  }

  @override
  Future<Result<int>> chargeCancelled(
    RideQuote quote, {
    required double distanceCoveredMeters,
  }) async {
    final fee = _fares.cancellationCents(
      quote,
      distanceCoveredMeters: distanceCoveredMeters,
    );
    if (fee > 0) {
      await _wallet.charge(
        amountCents: fee,
        description: 'Canceled: ${quote.rideType.displayName}',
      );
    }
    return Success(fee);
  }
}
