import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../booking/di/booking_providers.dart';
import '../data/repositories/tracking_repository_impl.dart';
import '../domain/ports/trip_payment_port.dart';
import '../domain/repositories/tracking_repository.dart';
import '../domain/usecases/cancel_trip.dart';
import '../domain/usecases/complete_trip.dart';

part 'trip_tracking_providers.g.dart';

@Riverpod(keepAlive: true)
TrackingRepository trackingRepository(Ref ref) =>
    const SimulatedTrackingRepository();

/// Supplied by the app layer (see `lib/app/app_overrides.dart`), which
/// connects it to the wallet.
@Riverpod(keepAlive: true)
TripPaymentPort tripPaymentPort(Ref ref) => throw UnimplementedError(
  'tripPaymentPortProvider must be overridden in ProviderScope',
);

@Riverpod(keepAlive: true)
CompleteTrip completeTrip(Ref ref) =>
    CompleteTrip(payments: ref.watch(tripPaymentPortProvider));

@Riverpod(keepAlive: true)
CancelTrip cancelTrip(Ref ref) => CancelTrip(
  payments: ref.watch(tripPaymentPortProvider),
  fares: ref.watch(fareCalculatorProvider),
);
