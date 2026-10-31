import '../entities/gold_card.dart';

/// Storage for the rider's [GoldCard].
///
/// Backed by on-device storage today. In Phase 3 the server becomes the
/// source of truth and this caches its ledger.
abstract interface class GoldCardRepository {
  Future<GoldCard> load();

  Future<void> save(GoldCard card);

  /// Emits the card after every [load] and [save].
  Stream<GoldCard> watch();
}
