import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/domain/failure.dart';
import '../../../../core/domain/result.dart';
import '../../../../core/domain/ride_type.dart';
import '../../../../core/remote_config/remote_config_providers.dart';
import '../../di/booking_providers.dart';
import '../../domain/entities/driving_route.dart';
import '../../domain/entities/place_suggestion.dart';
import '../../domain/entities/ride_quote.dart';
import '../../domain/policies/geofence_policy.dart';
import 'station_controller.dart';

part 'booking_controller.freezed.dart';
part 'booking_controller.g.dart';

enum BookingResult { success, notFound, outsideGeofence, routeUnavailable }

@freezed
abstract class BookingState with _$BookingState {
  const BookingState._();

  const factory BookingState({
    LatLng? destination,
    DrivingRoute? route,

    /// Null until a route is loaded.
    RideQuote? quote,
    @Default(RideType.private) RideType rideType,
    @Default(false) bool isLoadingRoute,
    @Default(false) bool isSearchingAddress,
  }) = _BookingState;

  List<LatLng> get routePoints => route?.points ?? const [];
}

/// Destination, route and quote for the ride being booked.
@Riverpod(keepAlive: true)
class BookingController extends _$BookingController {
  // Ignores route responses that arrive after a newer request
  int _request = 0;

  @override
  BookingState build() {
    // A different origin invalidates the destination and its route
    ref.listen(originStationProvider, (previous, next) {
      if (previous != null && previous != next) clearDestination();
    });
    // Pool switched off remotely: move anyone who'd picked it to Private
    ref.listen(featureFlagsProvider.select((f) => f.poolEnabled), (_, enabled) {
      if (!enabled && state.rideType == RideType.pool) {
        setRideType(RideType.private);
      }
    });
    return const BookingState();
  }

  /// Autocomplete suggestions. Empty on any failure, so typing never shows
  /// an error; the rider can still submit the search.
  Future<List<PlaceSuggestion>> suggestPlaces(String query) async {
    final result = await ref.read(searchPlacesProvider)(query);
    if (result case Err(:final failure)) debugPrint('Autocomplete: $failure');
    return result.valueOrNull ?? const [];
  }

  /// Geocodes [address] and, if found, sets it as the destination.
  Future<BookingResult> searchAndSetDestination(String address) async {
    state = state.copyWith(isSearchingAddress: true);
    final result = await ref.read(searchPlacesProvider).bestMatch(address);
    if (!ref.mounted) return BookingResult.routeUnavailable;
    state = state.copyWith(isSearchingAddress: false);

    switch (result) {
      case Success(:final value):
        return setDestination(value.location);
      case Err(failure: NotFoundFailure()):
        return BookingResult.notFound;
      case Err(:final failure):
        debugPrint('Address search: $failure');
        return BookingResult.routeUnavailable;
    }
  }

  Future<BookingResult> setDestination(LatLng destination) async {
    final request = ++_request;
    final previousDestination = state.destination;
    state = state.copyWith(destination: destination, isLoadingRoute: true);

    final result = await ref.read(planRouteProvider)(
      origin: ref.read(originStationProvider),
      destination: destination,
    );
    if (!ref.mounted || request != _request) {
      return BookingResult.routeUnavailable;
    }

    switch (result) {
      case Success(:final value):
        state = state.copyWith(
          route: value,
          quote: _quoteFor(value, state.rideType),
          isLoadingRoute: false,
        );
        return BookingResult.success;
      case Err(failure: OutsideServiceAreaFailure()):
        // Rejected destinations leave any existing booking in place
        state = state.copyWith(
          destination: previousDestination,
          isLoadingRoute: false,
        );
        return BookingResult.outsideGeofence;
      case Err(:final failure):
        debugPrint('Route planning: $failure');
        state = BookingState(rideType: state.rideType);
        return BookingResult.routeUnavailable;
    }
  }

  void setRideType(RideType type) {
    final route = state.route;
    state = state.copyWith(
      rideType: type,
      quote: route == null ? null : _quoteFor(route, type),
    );
  }

  void clearDestination() {
    _request++;
    state = const BookingState();
  }

  RideQuote _quoteFor(DrivingRoute route, RideType type) => ref
      .read(fareCalculatorProvider)
      .quote(rideType: type, distanceMeters: route.distanceMeters);
}
