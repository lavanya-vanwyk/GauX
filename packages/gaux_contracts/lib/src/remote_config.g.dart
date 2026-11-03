// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RemoteConfig _$RemoteConfigFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_RemoteConfig', json, ($checkedConvert) {
      final val = _RemoteConfig(
        version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? 1),
        pricing: $checkedConvert(
          'pricing',
          (v) => v == null
              ? const PricingConfig()
              : PricingConfig.fromJson(v as Map<String, dynamic>),
        ),
        serviceArea: $checkedConvert(
          'serviceArea',
          (v) => v == null
              ? const ServiceAreaConfig()
              : ServiceAreaConfig.fromJson(v as Map<String, dynamic>),
        ),
        flags: $checkedConvert(
          'flags',
          (v) => v == null
              ? const FeatureFlags()
              : FeatureFlags.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$RemoteConfigToJson(_RemoteConfig instance) =>
    <String, dynamic>{
      'version': instance.version,
      'pricing': instance.pricing.toJson(),
      'serviceArea': instance.serviceArea.toJson(),
      'flags': instance.flags.toJson(),
    };

_PricingConfig _$PricingConfigFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PricingConfig', json, ($checkedConvert) {
      final val = _PricingConfig(
        privateBaseFare: $checkedConvert(
          'privateBaseFare',
          (v) => (v as num?)?.toDouble() ?? 10.0,
        ),
        privatePerKm: $checkedConvert(
          'privatePerKm',
          (v) => (v as num?)?.toDouble() ?? 12.0,
        ),
        poolFlatFare: $checkedConvert(
          'poolFlatFare',
          (v) => (v as num?)?.toDouble() ?? 25.0,
        ),
        averageMetersPerMinute: $checkedConvert(
          'averageMetersPerMinute',
          (v) => (v as num?)?.toDouble() ?? 400.0,
        ),
      );
      return val;
    });

Map<String, dynamic> _$PricingConfigToJson(_PricingConfig instance) =>
    <String, dynamic>{
      'privateBaseFare': instance.privateBaseFare,
      'privatePerKm': instance.privatePerKm,
      'poolFlatFare': instance.poolFlatFare,
      'averageMetersPerMinute': instance.averageMetersPerMinute,
    };

_ServiceAreaConfig _$ServiceAreaConfigFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ServiceAreaConfig', json, ($checkedConvert) {
      final val = _ServiceAreaConfig(
        radiusMeters: $checkedConvert(
          'radiusMeters',
          (v) => (v as num?)?.toDouble() ?? 5000.0,
        ),
      );
      return val;
    });

Map<String, dynamic> _$ServiceAreaConfigToJson(_ServiceAreaConfig instance) =>
    <String, dynamic>{'radiusMeters': instance.radiusMeters};

_FeatureFlags _$FeatureFlagsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FeatureFlags', json, ($checkedConvert) {
      final val = _FeatureFlags(
        bookingEnabled: $checkedConvert(
          'bookingEnabled',
          (v) => v as bool? ?? true,
        ),
        poolEnabled: $checkedConvert('poolEnabled', (v) => v as bool? ?? true),
        sosEnabled: $checkedConvert('sosEnabled', (v) => v as bool? ?? true),
        topUpEnabled: $checkedConvert(
          'topUpEnabled',
          (v) => v as bool? ?? true,
        ),
        bookingDisabledMessage: $checkedConvert(
          'bookingDisabledMessage',
          (v) => v as String? ?? '',
        ),
      );
      return val;
    });

Map<String, dynamic> _$FeatureFlagsToJson(_FeatureFlags instance) =>
    <String, dynamic>{
      'bookingEnabled': instance.bookingEnabled,
      'poolEnabled': instance.poolEnabled,
      'sosEnabled': instance.sosEnabled,
      'topUpEnabled': instance.topUpEnabled,
      'bookingDisabledMessage': instance.bookingDisabledMessage,
    };
