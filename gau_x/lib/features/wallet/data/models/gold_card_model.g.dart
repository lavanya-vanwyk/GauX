// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gold_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoldCardModel _$GoldCardModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_GoldCardModel', json, ($checkedConvert) {
      final val = _GoldCardModel(
        balance: $checkedConvert('balance', (v) => (v as num).toDouble()),
        ledger: $checkedConvert(
          'ledger',
          (v) =>
              (v as List<dynamic>?)
                  ?.map(
                    (e) => LedgerEntryModel.fromJson(e as Map<String, dynamic>),
                  )
                  .toList() ??
              const <LedgerEntryModel>[],
        ),
      );
      return val;
    });

Map<String, dynamic> _$GoldCardModelToJson(_GoldCardModel instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'ledger': instance.ledger.map((e) => e.toJson()).toList(),
    };

_LedgerEntryModel _$LedgerEntryModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_LedgerEntryModel', json, ($checkedConvert) {
      final val = _LedgerEntryModel(
        description: $checkedConvert('description', (v) => v as String),
        amount: $checkedConvert('amount', (v) => (v as num).toDouble()),
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
      'amount': instance.amount,
      'timestamp': instance.timestamp.toIso8601String(),
    };
