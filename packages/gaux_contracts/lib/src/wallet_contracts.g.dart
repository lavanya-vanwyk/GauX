// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_contracts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuoteRequest _$QuoteRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_QuoteRequest', json, ($checkedConvert) {
      final val = _QuoteRequest(
        from: $checkedConvert(
          'from',
          (v) => GeoPoint.fromJson(v as Map<String, dynamic>),
        ),
        to: $checkedConvert(
          'to',
          (v) => GeoPoint.fromJson(v as Map<String, dynamic>),
        ),
        rideType: $checkedConvert(
          'rideType',
          (v) => $enumDecode(_$RideKindEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$QuoteRequestToJson(_QuoteRequest instance) =>
    <String, dynamic>{
      'from': instance.from.toJson(),
      'to': instance.to.toJson(),
      'rideType': _$RideKindEnumMap[instance.rideType]!,
    };

const _$RideKindEnumMap = {RideKind.private: 'private', RideKind.pool: 'pool'};

_QuoteResponse _$QuoteResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_QuoteResponse', json, ($checkedConvert) {
      final val = _QuoteResponse(
        id: $checkedConvert('id', (v) => v as String),
        rideType: $checkedConvert(
          'rideType',
          (v) => $enumDecode(_$RideKindEnumMap, v),
        ),
        distanceMeters: $checkedConvert(
          'distanceMeters',
          (v) => (v as num).toDouble(),
        ),
        fareCents: $checkedConvert('fareCents', (v) => (v as num).toInt()),
        etaMinutes: $checkedConvert('etaMinutes', (v) => (v as num).toInt()),
        expiresAt: $checkedConvert(
          'expiresAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$QuoteResponseToJson(_QuoteResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rideType': _$RideKindEnumMap[instance.rideType]!,
      'distanceMeters': instance.distanceMeters,
      'fareCents': instance.fareCents,
      'etaMinutes': instance.etaMinutes,
      'expiresAt': instance.expiresAt.toIso8601String(),
    };

_ChargeRequest _$ChargeRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ChargeRequest', json, ($checkedConvert) {
      final val = _ChargeRequest(
        quoteId: $checkedConvert('quoteId', (v) => v as String),
        cancelled: $checkedConvert('cancelled', (v) => v as bool? ?? false),
        distanceCoveredMeters: $checkedConvert(
          'distanceCoveredMeters',
          (v) => (v as num?)?.toDouble() ?? 0,
        ),
      );
      return val;
    });

Map<String, dynamic> _$ChargeRequestToJson(_ChargeRequest instance) =>
    <String, dynamic>{
      'quoteId': instance.quoteId,
      'cancelled': instance.cancelled,
      'distanceCoveredMeters': instance.distanceCoveredMeters,
    };

_HoldRequest _$HoldRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_HoldRequest', json, ($checkedConvert) {
      final val = _HoldRequest(
        quoteId: $checkedConvert('quoteId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$HoldRequestToJson(_HoldRequest instance) =>
    <String, dynamic>{'quoteId': instance.quoteId};

_TopUpRequest _$TopUpRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TopUpRequest', json, ($checkedConvert) {
      final val = _TopUpRequest(
        amountCents: $checkedConvert('amountCents', (v) => (v as num).toInt()),
        paymentMethod: $checkedConvert('paymentMethod', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$TopUpRequestToJson(_TopUpRequest instance) =>
    <String, dynamic>{
      'amountCents': instance.amountCents,
      'paymentMethod': instance.paymentMethod,
    };

_WalletEntryDto _$WalletEntryDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_WalletEntryDto', json, ($checkedConvert) {
      final val = _WalletEntryDto(
        id: $checkedConvert('id', (v) => v as String),
        kind: $checkedConvert('kind', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String),
        amountCents: $checkedConvert('amountCents', (v) => (v as num).toInt()),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$WalletEntryDtoToJson(_WalletEntryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': instance.kind,
      'description': instance.description,
      'amountCents': instance.amountCents,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_WalletResponse _$WalletResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_WalletResponse', json, ($checkedConvert) {
  final val = _WalletResponse(
    balanceCents: $checkedConvert('balanceCents', (v) => (v as num).toInt()),
    heldCents: $checkedConvert('heldCents', (v) => (v as num?)?.toInt() ?? 0),
    currency: $checkedConvert('currency', (v) => v as String? ?? 'ZAR'),
    entries: $checkedConvert(
      'entries',
      (v) => (v as List<dynamic>)
          .map((e) => WalletEntryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    entry: $checkedConvert(
      'entry',
      (v) =>
          v == null ? null : WalletEntryDto.fromJson(v as Map<String, dynamic>),
    ),
    chargedCents: $checkedConvert('chargedCents', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$WalletResponseToJson(_WalletResponse instance) =>
    <String, dynamic>{
      'balanceCents': instance.balanceCents,
      'heldCents': instance.heldCents,
      'currency': instance.currency,
      'entries': instance.entries.map((e) => e.toJson()).toList(),
      'entry': instance.entry?.toJson(),
      'chargedCents': instance.chargedCents,
    };
