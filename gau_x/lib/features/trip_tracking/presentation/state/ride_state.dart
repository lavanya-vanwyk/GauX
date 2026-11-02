import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

import '../../../booking/domain/entities/ride_quote.dart';
import '../../domain/entities/driver_location.dart';

part 'ride_state.freezed.dart';

enum RidePhase { idle, matching, searching, arriving, inTransit, arrived }

/// Where a ride is in its lifecycle. Each phase carries only the data that
/// exists in that phase, so e.g. a driver position can't exist before the
/// ride is in transit.
///
/// idle → (pool only) matching → searching → arriving → inTransit → arrived
/// Any phase before arrival can be cancelled back to idle.
@freezed
sealed class RideState with _$RideState {
  const RideState._();

  const factory RideState.idle() = RideIdle;

  /// Pool only: finding other commuters to share with.
  const factory RideState.matching({
    required RideQuote quote,
    required List<LatLng> route,
  }) = RideMatching;

  const factory RideState.searching({
    required RideQuote quote,
    required List<LatLng> route,
  }) = RideSearching;

  const factory RideState.arriving({
    required RideQuote quote,
    required List<LatLng> route,
  }) = RideArriving;

  const factory RideState.inTransit({
    required RideQuote quote,
    required List<LatLng> route,
    DriverLocation? driver,
  }) = RideInTransit;

  /// The fare has been charged.
  const factory RideState.arrived({required RideQuote quote}) = RideArrived;

  RidePhase get phase => switch (this) {
    RideIdle() => RidePhase.idle,
    RideMatching() => RidePhase.matching,
    RideSearching() => RidePhase.searching,
    RideArriving() => RidePhase.arriving,
    RideInTransit() => RidePhase.inTransit,
    RideArrived() => RidePhase.arrived,
  };

  RideQuote? get activeQuote => switch (this) {
    RideIdle() => null,
    RideMatching(:final quote) ||
    RideSearching(:final quote) ||
    RideArriving(:final quote) ||
    RideInTransit(:final quote) ||
    RideArrived(:final quote) => quote,
  };

  DriverLocation? get driver => switch (this) {
    RideInTransit(:final driver) => driver,
    _ => null,
  };

  bool get isIdle => this is RideIdle;
}
