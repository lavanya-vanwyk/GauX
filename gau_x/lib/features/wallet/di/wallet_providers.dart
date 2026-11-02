import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/di/core_providers.dart';
import '../data/datasources/gold_card_local_datasource.dart';
import '../data/datasources/wallet_api_datasource.dart';
import '../data/repositories/api_gold_card_repository.dart';
import '../data/repositories/local_gold_card_repository.dart';
import '../domain/entities/gold_card.dart';
import '../domain/repositories/gold_card_repository.dart';
import '../domain/usecases/top_up_wallet.dart';

part 'wallet_providers.g.dart';

/// The GauX API's wallet endpoints, or null for builds without the API.
@Riverpod(keepAlive: true)
WalletApiDatasource? walletApi(Ref ref) => AppConfig.usesGauxApi
    ? WalletApiDatasource(
        client: ref.watch(apiClientProvider),
        baseUrl: AppConfig.gauxApiBaseUrl,
        accessToken: ref.watch(accessTokenProvider),
      )
    : null;

/// The server-ledger wallet, or null for builds without the API.
@Riverpod(keepAlive: true)
ApiGoldCardRepository? apiGoldCardRepository(Ref ref) {
  final api = ref.watch(walletApiProvider);
  if (api == null) return null;
  return ApiGoldCardRepository(api: api, cache: ref.watch(secureCacheProvider));
}

/// The on-device wallet, used when there's no API.
@Riverpod(keepAlive: true)
LocalGoldCardRepository localGoldCardRepository(Ref ref) =>
    LocalGoldCardRepository(
      local: GoldCardLocalDatasource(ref.watch(sharedPreferencesProvider)),
      clock: ref.watch(clockProvider),
    );

@Riverpod(keepAlive: true)
GoldCardRepository goldCardRepository(Ref ref) =>
    ref.watch(apiGoldCardRepositoryProvider) ??
    ref.watch(localGoldCardRepositoryProvider);

@Riverpod(keepAlive: true)
TopUpWallet topUpWallet(Ref ref) =>
    TopUpWallet(repository: ref.watch(goldCardRepositoryProvider));

/// The rider's wallet, updated after every charge and top-up.
@Riverpod(keepAlive: true)
Stream<GoldCard> goldCard(Ref ref) {
  final repository = ref.watch(goldCardRepositoryProvider);
  unawaited(repository.load());
  return repository.watch();
}
