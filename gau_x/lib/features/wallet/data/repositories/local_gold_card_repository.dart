import 'dart:async';

import '../../../../core/domain/result.dart';
import '../../domain/entities/gold_card.dart';
import '../../domain/entities/ledger_entry.dart';
import '../../domain/repositories/gold_card_repository.dart';
import '../datasources/gold_card_local_datasource.dart';
import '../models/gold_card_model.dart';

/// The wallet kept on the device, for builds without the GauX API.
class LocalGoldCardRepository implements GoldCardRepository {
  LocalGoldCardRepository({
    required GoldCardLocalDatasource local,
    DateTime Function()? clock,
  }) : _local = local,
       _clock = clock ?? DateTime.now;

  final GoldCardLocalDatasource _local;
  final DateTime Function() _clock;
  final _changes = StreamController<GoldCard>.broadcast();

  GoldCard? _cache;

  @override
  Stream<GoldCard> watch() async* {
    if (_cache case final card?) yield card;
    yield* _changes.stream;
  }

  @override
  Future<Result<GoldCard>> load() async {
    final card = _cache ?? await _readOrCreate();
    _cache = card;
    _changes.add(card);
    return Success(card);
  }

  @override
  Future<Result<GoldCard>> topUp({
    required int amountCents,
    required String paymentMethod,
    required String idempotencyKey,
  }) => _record(
    LedgerEntry(
      description: 'Top Up: $paymentMethod',
      amountCents: amountCents,
      timestamp: _clock(),
    ),
  );

  /// Deducts [amountCents] for a ride. Only the on-device trip payments use
  /// this; with the API, the server ledger charges quotes itself.
  Future<Result<GoldCard>> charge({
    required int amountCents,
    required String description,
  }) => _record(
    LedgerEntry(
      description: description,
      amountCents: -amountCents,
      timestamp: _clock(),
    ),
  );

  Future<Result<GoldCard>> _record(LedgerEntry entry) async {
    final card = (_cache ?? await _readOrCreate()).record(entry);
    await _local.write(GoldCardModel.fromEntity(card));
    _cache = card;
    _changes.add(card);
    return Success(card);
  }

  Future<GoldCard> _readOrCreate() async {
    if (_local.read() case final stored?) return stored.toEntity();

    final now = _clock();
    if (_local.readOlderFormat(migratedAt: now) case final older?) {
      await _local.write(older);
      await _local.clearOlderFormats();
      return older.toEntity();
    }

    final card = _demoCard(now);
    await _local.write(GoldCardModel.fromEntity(card));
    return card;
  }

  /// Starting balance and history shown to first-time demo users.
  static GoldCard _demoCard(DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    return GoldCard(
      balanceCents: 35000,
      ledger: [
        LedgerEntry(
          description: 'Train: Pretoria -> Sandton',
          amountCents: -8600,
          timestamp: today.add(const Duration(hours: 8, minutes: 15)),
        ),
        LedgerEntry(
          description: 'Train: Sandton -> Rosebank',
          amountCents: -3200,
          timestamp: today.subtract(const Duration(hours: 6, minutes: 30)),
        ),
      ],
    );
  }
}
