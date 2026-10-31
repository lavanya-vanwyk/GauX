import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/features/wallet/data/datasources/gold_card_local_datasource.dart';
import 'package:gau_x/features/wallet/data/repositories/gold_card_repository_impl.dart';
import 'package:gau_x/features/wallet/domain/entities/gold_card.dart';
import 'package:gau_x/features/wallet/domain/usecases/charge_wallet.dart';
import 'package:gau_x/features/wallet/domain/usecases/top_up_wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final now = DateTime(2026, 10, 31, 12);
  DateTime clock() => now;

  Future<(GoldCardRepositoryImpl, SharedPreferences)> setUpRepository([
    Map<String, Object> stored = const {},
  ]) async {
    SharedPreferences.setMockInitialValues(stored);
    final prefs = await SharedPreferences.getInstance();
    final repository = GoldCardRepositoryImpl(
      local: GoldCardLocalDatasource(prefs),
      clock: clock,
    );
    return (repository, prefs);
  }

  test('first launch creates the demo wallet', () async {
    final (repository, _) = await setUpRepository();

    final card = await repository.load();

    expect(card.balance, 350.0);
    expect(card.ledger.map((e) => e.description), [
      'Train: Pretoria -> Sandton',
      'Train: Sandton -> Rosebank',
    ]);
    expect(card.ledger.first.timestamp, DateTime(2026, 10, 31, 8, 15));
  });

  test('migrates a wallet saved by the hackathon build', () async {
    final (repository, prefs) = await setUpRepository({
      'wallet_balance': 214.5,
      'recent_trips': jsonEncode([
        {'route': 'GauX Private', 'cost': -35.5, 'date': 'Just now'},
        {'route': 'Top Up: Instant EFT', 'cost': 150, 'date': 'Today, 09:00'},
      ]),
    });

    final card = await repository.load();

    expect(card.balance, 214.5);
    expect(card.ledger.map((e) => (e.description, e.amount)), [
      ('GauX Private', -35.5),
      ('Top Up: Instant EFT', 150.0),
    ]);
    expect(prefs.containsKey('wallet_balance'), isFalse);
    expect(prefs.containsKey('recent_trips'), isFalse);
  });

  test('saved cards survive a restart', () async {
    final (repository, prefs) = await setUpRepository();
    await ChargeWallet(repository: repository, clock: clock)(
      amount: 40,
      description: 'GauX Private',
    );

    final reopened = GoldCardRepositoryImpl(
      local: GoldCardLocalDatasource(prefs),
    );
    final card = await reopened.load();

    expect(card.balance, 310.0);
    expect(card.ledger.first.description, 'GauX Private');
    expect(card.ledger.first.timestamp, now);
  });

  test('charges and top-ups are recorded newest first', () async {
    final (repository, _) = await setUpRepository();
    final emitted = <GoldCard>[];
    repository.watch().listen(emitted.add);

    await ChargeWallet(repository: repository, clock: clock)(
      amount: 25,
      description: 'GauX Pool',
    );
    final card = await TopUpWallet(repository: repository, clock: clock)(
      amount: 100,
      paymentMethod: 'FNB eWallet',
    );

    expect(card.balance, 425.0);
    expect(card.ledger.take(2).map((e) => (e.description, e.amount)), [
      ('Top Up: FNB eWallet', 100.0),
      ('GauX Pool', -25.0),
    ]);
    await pumpEventQueue();
    expect(emitted.last, card);
  });
}
