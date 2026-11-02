import '../../../../core/domain/result.dart';
import '../entities/gold_card.dart';

/// The rider's wallet. Implemented on the device for builds without the
/// GauX API, and by the server-side ledger otherwise.
abstract interface class GoldCardRepository {
  /// Emits the wallet now (if known) and after every change.
  Stream<GoldCard> watch();

  /// Fetches the latest wallet.
  Future<Result<GoldCard>> load();

  /// Adds funds. Retrying with the same [idempotencyKey] never credits twice.
  Future<Result<GoldCard>> topUp({
    required int amountCents,
    required String paymentMethod,
    required String idempotencyKey,
  });
}
