import 'package:freezed_annotation/freezed_annotation.dart';

import 'ledger_entry.dart';

part 'gold_card.freezed.dart';

/// The rider's GauX wallet: its balance and recent history, in cents.
@freezed
abstract class GoldCard with _$GoldCard {
  const GoldCard._();

  const factory GoldCard({
    required int balanceCents,

    /// Newest first.
    @Default(<LedgerEntry>[]) List<LedgerEntry> ledger,
  }) = _GoldCard;

  bool canAfford(int amountCents) => balanceCents >= amountCents;

  /// A copy with [entry] applied to the balance and added to the history.
  /// Used by the on-device wallet; the server ledger does this itself.
  GoldCard record(LedgerEntry entry) => copyWith(
    balanceCents: balanceCents + entry.amountCents,
    ledger: [entry, ...ledger],
  );
}
