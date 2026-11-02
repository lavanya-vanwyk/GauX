import 'package:uuid/uuid.dart';

import '../../../../core/domain/result.dart';
import '../entities/gold_card.dart';
import '../repositories/gold_card_repository.dart';

/// Adds funds to the wallet from [paymentMethod].
///
/// Simulated: no payment provider is called yet.
class TopUpWallet {
  TopUpWallet({
    required GoldCardRepository repository,
    String Function()? newKey,
  }) : _repository = repository,
       _newKey = newKey ?? const Uuid().v4;

  final GoldCardRepository _repository;
  final String Function() _newKey;

  /// Each call is a new top-up, so each gets a fresh idempotency key; a
  /// network retry inside the repository reuses it.
  Future<Result<GoldCard>> call({
    required int amountCents,
    required String paymentMethod,
  }) {
    assert(amountCents > 0, 'Top-up amounts are positive; got $amountCents');
    return _repository.topUp(
      amountCents: amountCents,
      paymentMethod: paymentMethod,
      idempotencyKey: _newKey(),
    );
  }
}
