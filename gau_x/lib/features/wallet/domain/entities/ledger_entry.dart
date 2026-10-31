import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_entry.freezed.dart';

/// One wallet transaction. [amount] is negative for charges and positive for
/// top-ups.
@freezed
abstract class LedgerEntry with _$LedgerEntry {
  const LedgerEntry._();

  const factory LedgerEntry({
    required String description,
    required double amount,
    required DateTime timestamp,
  }) = _LedgerEntry;

  bool get isCharge => amount < 0;
}
