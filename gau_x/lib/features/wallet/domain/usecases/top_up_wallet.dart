import '../entities/gold_card.dart';
import '../entities/ledger_entry.dart';
import '../repositories/gold_card_repository.dart';

/// Adds funds to the wallet from [paymentMethod].
///
/// Simulated: no payment provider is called yet.
class TopUpWallet {
  TopUpWallet({
    required GoldCardRepository repository,
    DateTime Function()? clock,
  }) : _repository = repository,
       _clock = clock ?? DateTime.now;

  final GoldCardRepository _repository;
  final DateTime Function() _clock;

  Future<GoldCard> call({
    required double amount,
    required String paymentMethod,
  }) async {
    assert(amount > 0, 'Top-up amounts are positive; got $amount');
    final card = await _repository.load();
    final updated = card.record(
      LedgerEntry(
        description: 'Top Up: $paymentMethod',
        amount: amount,
        timestamp: _clock(),
      ),
    );
    await _repository.save(updated);
    return updated;
  }
}
