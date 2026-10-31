import 'dart:async';

import '../../domain/entities/gold_card.dart';
import '../../domain/entities/ledger_entry.dart';
import '../../domain/repositories/gold_card_repository.dart';
import '../datasources/gold_card_local_datasource.dart';
import '../models/gold_card_model.dart';

class GoldCardRepositoryImpl implements GoldCardRepository {
  GoldCardRepositoryImpl({
    required GoldCardLocalDatasource local,
    DateTime Function()? clock,
  }) : _local = local,
       _clock = clock ?? DateTime.now;

  final GoldCardLocalDatasource _local;
  final DateTime Function() _clock;
  final _changes = StreamController<GoldCard>.broadcast();

  GoldCard? _cache;

  @override
  Future<GoldCard> load() async {
    final card = _cache ?? await _readOrCreate();
    _cache = card;
    _changes.add(card);
    return card;
  }

  @override
  Future<void> save(GoldCard card) async {
    await _local.write(GoldCardModel.fromEntity(card));
    _cache = card;
    _changes.add(card);
  }

  @override
  Stream<GoldCard> watch() async* {
    if (_cache case final card?) yield card;
    yield* _changes.stream;
  }

  Future<GoldCard> _readOrCreate() async {
    if (_local.read() case final stored?) return stored.toEntity();

    final now = _clock();
    if (_local.readLegacy(migratedAt: now) case final legacy?) {
      final card = legacy.toEntity();
      await _local.write(legacy);
      await _local.clearLegacy();
      return card;
    }

    final card = _demoCard(now);
    await _local.write(GoldCardModel.fromEntity(card));
    return card;
  }

  /// Starting balance and history shown to first-time demo users.
  static GoldCard _demoCard(DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    return GoldCard(
      balance: 350.00,
      ledger: [
        LedgerEntry(
          description: 'Train: Pretoria -> Sandton',
          amount: -86.00,
          timestamp: today.add(const Duration(hours: 8, minutes: 15)),
        ),
        LedgerEntry(
          description: 'Train: Sandton -> Rosebank',
          amount: -32.00,
          timestamp: today.subtract(const Duration(hours: 6, minutes: 30)),
        ),
      ],
    );
  }
}
