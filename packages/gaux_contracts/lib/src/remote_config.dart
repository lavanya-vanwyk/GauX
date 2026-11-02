import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_config.freezed.dart';
part 'remote_config.g.dart';

/// `GET /v1/config`: values the business can change without an app release.
///
/// Every field has a default, so an older app reading a newer document (or
/// the reverse) never fails on a missing key.
@freezed
abstract class RemoteConfig with _$RemoteConfig {
  const factory RemoteConfig({
    /// Bumped whenever the document changes. Clients can log it.
    @Default(1) int version,
    @Default(PricingConfig()) PricingConfig pricing,
    @Default(ServiceAreaConfig()) ServiceAreaConfig serviceArea,
    @Default(FeatureFlags()) FeatureFlags flags,
  }) = _RemoteConfig;

  factory RemoteConfig.fromJson(Map<String, dynamic> json) =>
      _$RemoteConfigFromJson(json);
}

/// Fares in rand. Defaults match the hackathon pricing.
@freezed
abstract class PricingConfig with _$PricingConfig {
  const factory PricingConfig({
    @Default(10.0) double privateBaseFare,
    @Default(12.0) double privatePerKm,
    @Default(25.0) double poolFlatFare,
    @Default(400.0) double averageMetersPerMinute,
  }) = _PricingConfig;

  factory PricingConfig.fromJson(Map<String, dynamic> json) =>
      _$PricingConfigFromJson(json);
}

@freezed
abstract class ServiceAreaConfig with _$ServiceAreaConfig {
  const factory ServiceAreaConfig({
    /// Destinations further than this from the origin station are refused.
    @Default(5000.0) double radiusMeters,
  }) = _ServiceAreaConfig;

  factory ServiceAreaConfig.fromJson(Map<String, dynamic> json) =>
      _$ServiceAreaConfigFromJson(json);
}

/// Kill switches. All on by default, so a missing document never disables
/// anything.
@freezed
abstract class FeatureFlags with _$FeatureFlags {
  const factory FeatureFlags({
    /// When false, riders can't book new rides (e.g. during an incident).
    @Default(true) bool bookingEnabled,
    @Default(true) bool poolEnabled,
    @Default(true) bool sosEnabled,
    @Default(true) bool topUpEnabled,

    /// Shown to riders while [bookingEnabled] is false.
    @Default('') String bookingDisabledMessage,
  }) = _FeatureFlags;

  factory FeatureFlags.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagsFromJson(json);
}
