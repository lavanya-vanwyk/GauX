// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Destination, route and quote for the ride being booked.

@ProviderFor(BookingController)
final bookingControllerProvider = BookingControllerProvider._();

/// Destination, route and quote for the ride being booked.
final class BookingControllerProvider
    extends $NotifierProvider<BookingController, BookingState> {
  /// Destination, route and quote for the ride being booked.
  BookingControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookingControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookingControllerHash();

  @$internal
  @override
  BookingController create() => BookingController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookingState>(value),
    );
  }
}

String _$bookingControllerHash() => r'bdff1afb60d39483e07e0bd9a8670e0c2bfa40c3';

/// Destination, route and quote for the ride being booked.

abstract class _$BookingController extends $Notifier<BookingState> {
  BookingState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<BookingState, BookingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BookingState, BookingState>,
              BookingState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
