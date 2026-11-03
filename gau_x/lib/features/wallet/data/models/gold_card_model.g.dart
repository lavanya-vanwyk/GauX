// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gold_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoldCardModel _$GoldCardModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_GoldCardModel', json, ($checkedConvert) {
  final val = _GoldCardModel(
    balanceCents: $checkedConvert('balanceCents', (v) => (v as num).toInt()),
    ledger: $checkedConvert(
      'ledger',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => LedgerEntryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <LedgerEntryModel>[],
    ),
  );
  return val;
});

Map<String, dynamic> _$GoldCardModelToJson(_GoldCardModel instance) =>
    <String, dynamic>{
      'balanceCents': instance.balanceCents,
      'ledger': instance.ledger.map((e) => e.toJson()).toList(),
    };

_LedgerEntryModel _$LedgerEntryModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_LedgerEntryModel', json, ($checkedConvert) {
      final val = _LedgerEntryModel(
        description: $checkedConvert('description', (v) => v as String),
        amountCents: $checkedConvert('amountCents', (v) => (v as num).toInt()),
        timestamp: $checkedConvert(
          'timestamp',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$LedgerEntryModelToJson(_LedgerEntryModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'amountCents': instance.amountCents,
      'timestamp': instance.timestamp.toIso8601String(),
    };
