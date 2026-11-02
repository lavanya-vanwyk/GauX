import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_entry.freezed.dart';

/// One wallet transaction. [amountCents] is negative for charges and
/// positive for top-ups and credits.
@freezed
abstract class LedgerEntry with _$LedgerEntry {
  const LedgerEntry._();

  const factory LedgerEntry({
    required String description,
    required int amountCents,
    required DateTime timestamp,
  }) = _LedgerEntry;

  bool get isCharge => amountCents < 0;
}
