import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/gold_card.dart';
import '../../domain/entities/ledger_entry.dart';

part 'gold_card_model.freezed.dart';
part 'gold_card_model.g.dart';

/// Stored form of a [GoldCard]: integer cents, UTC ISO-8601 timestamps.
@freezed
abstract class GoldCardModel with _$GoldCardModel {
  const GoldCardModel._();

  const factory GoldCardModel({
    required int balanceCents,
    @Default(<LedgerEntryModel>[]) List<LedgerEntryModel> ledger,
  }) = _GoldCardModel;

  factory GoldCardModel.fromJson(Map<String, dynamic> json) =>
      _$GoldCardModelFromJson(json);

  factory GoldCardModel.fromEntity(GoldCard card) => GoldCardModel(
    balanceCents: card.balanceCents,
    ledger: card.ledger.map(LedgerEntryModel.fromEntity).toList(),
  );

  GoldCard toEntity() => GoldCard(
    balanceCents: balanceCents,
    ledger: ledger.map((entry) => entry.toEntity()).toList(),
  );
}

@freezed
abstract class LedgerEntryModel with _$LedgerEntryModel {
  const LedgerEntryModel._();

  const factory LedgerEntryModel({
    required String description,
    required int amountCents,
    required DateTime timestamp,
  }) = _LedgerEntryModel;

  factory LedgerEntryModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerEntryModelFromJson(json);

  factory LedgerEntryModel.fromEntity(LedgerEntry entry) => LedgerEntryModel(
    description: entry.description,
    amountCents: entry.amountCents,
    timestamp: entry.timestamp.toUtc(),
  );

  LedgerEntry toEntity() => LedgerEntry(
    description: description,
    amountCents: amountCents,
    timestamp: timestamp.toLocal(),
  );
}
