import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/di/core_providers.dart';
import '../data/datasources/gold_card_local_datasource.dart';
import '../data/repositories/gold_card_repository_impl.dart';
import '../domain/entities/gold_card.dart';
import '../domain/repositories/gold_card_repository.dart';
import '../domain/usecases/charge_wallet.dart';
import '../domain/usecases/top_up_wallet.dart';

part 'wallet_providers.g.dart';

@Riverpod(keepAlive: true)
GoldCardRepository goldCardRepository(Ref ref) => GoldCardRepositoryImpl(
  local: GoldCardLocalDatasource(ref.watch(sharedPreferencesProvider)),
  clock: ref.watch(clockProvider),
);

@Riverpod(keepAlive: true)
ChargeWallet chargeWallet(Ref ref) => ChargeWallet(
  repository: ref.watch(goldCardRepositoryProvider),
  clock: ref.watch(clockProvider),
);

@Riverpod(keepAlive: true)
TopUpWallet topUpWallet(Ref ref) => TopUpWallet(
  repository: ref.watch(goldCardRepositoryProvider),
  clock: ref.watch(clockProvider),
);

/// The rider's wallet, updated after every charge and top-up.
@Riverpod(keepAlive: true)
Stream<GoldCard> goldCard(Ref ref) {
  final repository = ref.watch(goldCardRepositoryProvider);
  unawaited(repository.load());
  return repository.watch();
}
