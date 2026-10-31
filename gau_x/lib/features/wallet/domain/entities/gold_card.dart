import 'package:freezed_annotation/freezed_annotation.dart';

import 'ledger_entry.dart';

part 'gold_card.freezed.dart';

/// The rider's GauX wallet: its balance and transaction history.
///
/// Future fields: linked user account and supported payment rails.
@freezed
abstract class GoldCard with _$GoldCard {
  const GoldCard._();

  const factory GoldCard({
    required double balance,

    /// Newest first.
    @Default(<LedgerEntry>[]) List<LedgerEntry> ledger,
  }) = _GoldCard;

  bool canAfford(double amount) => balance >= amount;

  /// A copy with [entry] applied to the balance and added to the ledger.
  GoldCard record(LedgerEntry entry) =>
      copyWith(balance: balance + entry.amount, ledger: [entry, ...ledger]);
}
