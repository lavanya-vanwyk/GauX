import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/features/wallet/data/datasources/gold_card_local_datasource.dart';
import 'package:gau_x/features/wallet/data/repositories/local_gold_card_repository.dart';
import 'package:gau_x/features/wallet/domain/entities/gold_card.dart';
import 'package:gau_x/features/wallet/domain/usecases/top_up_wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final now = DateTime(2026, 11, 2, 12);
  DateTime clock() => now;

  Future<(LocalGoldCardRepository, SharedPreferences)> setUpRepository([
    Map<String, Object> stored = const {},
  ]) async {
    SharedPreferences.setMockInitialValues(stored);
    final prefs = await SharedPreferences.getInstance();
    final repository = LocalGoldCardRepository(
      local: GoldCardLocalDatasource(prefs),
      clock: clock,
    );
    return (repository, prefs);
  }

  Future<GoldCard> load(LocalGoldCardRepository repo) async =>
      (await repo.load()).valueOrNull!;

  test('first launch creates the demo wallet, in cents', () async {
    final (repository, _) = await setUpRepository();

    final card = await load(repository);

    expect(card.balanceCents, 35000);
    expect(card.ledger.map((e) => (e.description, e.amountCents)), [
      ('Train: Pretoria -> Sandton', -8600),
      ('Train: Sandton -> Rosebank', -3200),
    ]);
    expect(card.ledger.first.timestamp, DateTime(2026, 11, 2, 8, 15));
  });

  test('migrates a hackathon-build wallet, converting rand to cents', () async {
    final (repository, prefs) = await setUpRepository({
      'wallet_balance': 214.5,
      'recent_trips': jsonEncode([
        {'route': 'GauX Private', 'cost': -35.55, 'date': 'Just now'},
        {'route': 'Top Up: Instant EFT', 'cost': 150, 'date': 'Today, 09:00'},
      ]),
    });

    final card = await load(repository);

    expect(card.balanceCents, 21450);
    expect(card.ledger.map((e) => (e.description, e.amountCents)), [
      ('GauX Private', -3555),
      ('Top Up: Instant EFT', 15000),
    ]);
    expect(prefs.containsKey('wallet_balance'), isFalse);
    expect(prefs.containsKey('recent_trips'), isFalse);
  });

  test('migrates a Phase 1 wallet (rand amounts, real dates)', () async {
    final (repository, prefs) = await setUpRepository({
      'gold_card_v1': jsonEncode({
        'balance': 310.4,
        'ledger': [
          {
            'description': 'GauX Private',
            'amount': -39.6,
            'timestamp': '2026-10-30T07:00:00.000Z',
          },
        ],
      }),
    });

    final card = await load(repository);

    expect(card.balanceCents, 31040);
    expect(card.ledger.single.amountCents, -3960);
    expect(card.ledger.single.timestamp.toUtc(), DateTime.utc(2026, 10, 30, 7));
    expect(prefs.containsKey('gold_card_v1'), isFalse);
  });

  test('charges and top-ups are recorded newest first and persist', () async {
    final (repository, prefs) = await setUpRepository();
    await repository.charge(amountCents: 2500, description: 'GauX Pool');
    await TopUpWallet(repository: repository)(
      amountCents: 10000,
      paymentMethod: 'FNB eWallet',
    );

    final reopened = LocalGoldCardRepository(
      local: GoldCardLocalDatasource(prefs),
    );
    final card = await load(reopened);

    expect(card.balanceCents, 42500);
    expect(card.ledger.take(2).map((e) => (e.description, e.amountCents)), [
      ('Top Up: FNB eWallet', 10000),
      ('GauX Pool', -2500),
    ]);
  });

  test('watch emits after every change', () async {
    final (repository, _) = await setUpRepository();
    final emitted = <int>[];
    repository.watch().listen((card) => emitted.add(card.balanceCents));

    await repository.load();
    await repository.charge(amountCents: 2500, description: 'GauX Pool');
    await pumpEventQueue();

    expect(emitted, [35000, 32500]);
  });
}
