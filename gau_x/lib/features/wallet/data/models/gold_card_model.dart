import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/gold_card.dart';
import '../../domain/entities/ledger_entry.dart';

part 'gold_card_model.freezed.dart';
part 'gold_card_model.g.dart';

/// Stored and transferred form of a [GoldCard]. Timestamps are UTC ISO-8601.
@freezed
abstract class GoldCardModel with _$GoldCardModel {
  const GoldCardModel._();

  const factory GoldCardModel({
    required double balance,
    @Default(<LedgerEntryModel>[]) List<LedgerEntryModel> ledger,
  }) = _GoldCardModel;

  factory GoldCardModel.fromJson(Map<String, dynamic> json) =>
      _$GoldCardModelFromJson(json);

  factory GoldCardModel.fromEntity(GoldCard card) => GoldCardModel(
    balance: card.balance,
    ledger: card.ledger.map(LedgerEntryModel.fromEntity).toList(),
  );

  GoldCard toEntity() => GoldCard(
    balance: balance,
    ledger: ledger.map((entry) => entry.toEntity()).toList(),
  );
}

@freezed
abstract class LedgerEntryModel with _$LedgerEntryModel {
  const LedgerEntryModel._();

  const factory LedgerEntryModel({
    required String description,
    required double amount,
    required DateTime timestamp,
  }) = _LedgerEntryModel;

  factory LedgerEntryModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerEntryModelFromJson(json);

  factory LedgerEntryModel.fromEntity(LedgerEntry entry) => LedgerEntryModel(
    description: entry.description,
    amount: entry.amount,
    timestamp: entry.timestamp.toUtc(),
  );

  LedgerEntry toEntity() => LedgerEntry(
    description: description,
    amount: amount,
    timestamp: timestamp.toLocal(),
  );
}
