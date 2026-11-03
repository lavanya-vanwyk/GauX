import 'package:latlong2/latlong.dart';

import '../../../../core/domain/failure.dart';
import '../../../../core/domain/result.dart';
import '../../../booking/domain/entities/ride_quote.dart';

/// The rider can't cover the fare.
final class InsufficientFundsFailure extends Failure {
  const InsufficientFundsFailure(super.message);
}

/// How trip tracking gets paid, without depending on the wallet feature.
/// The app layer supplies an implementation: on-device for builds without
/// the GauX API, server-side ledger otherwise.
abstract interface class TripPaymentPort {
  /// Locks in the price before the ride starts and reserves the fare.
  ///
  /// Returns the quote to charge, which may differ from [quote]: with the
  /// API, the server prices the ride itself and holds the fare in the
  /// rider's wallet until the ride ends. Fails with
  /// [InsufficientFundsFailure] when the balance is short.
  Future<Result<RideQuote>> confirmPrice(
    RideQuote quote, {
    required LatLng from,
    required LatLng to,
  });

  /// Charges the full fare on arrival. Safe to call again for the same quote.
  Future<Result<void>> chargeCompleted(RideQuote quote);

  /// Charges the cancellation fee for [distanceCoveredMeters] and returns
  /// the amount charged, in cents.
  Future<Result<int>> chargeCancelled(
    RideQuote quote, {
    required double distanceCoveredMeters,
  });

  /// Returns anything reserved for [quote]: the ride was cancelled before
  /// pickup.
  Future<Result<void>> release(RideQuote quote);
}
