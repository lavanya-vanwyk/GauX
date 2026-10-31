import '../entities/gold_card.dart';
import '../entities/ledger_entry.dart';
import '../repositories/gold_card_repository.dart';

/// Deducts [amount] from the wallet and records it in the ledger.
class ChargeWallet {
  ChargeWallet({
    required GoldCardRepository repository,
    DateTime Function()? clock,
  }) : _repository = repository,
       _clock = clock ?? DateTime.now;

  final GoldCardRepository _repository;
  final DateTime Function() _clock;

  Future<GoldCard> call({
    required double amount,
    required String description,
  }) async {
    assert(amount >= 0, 'Charge amounts are positive; got $amount');
    final card = await _repository.load();
    final updated = card.record(
      LedgerEntry(
        description: description,
        amount: -amount,
        timestamp: _clock(),
      ),
    );
    await _repository.save(updated);
    return updated;
  }
}
