// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The GauX API's wallet endpoints, or null for builds without the API.

@ProviderFor(walletApi)
final walletApiProvider = WalletApiProvider._();

/// The GauX API's wallet endpoints, or null for builds without the API.

final class WalletApiProvider
    extends
        $FunctionalProvider<
          WalletApiDatasource?,
          WalletApiDatasource?,
          WalletApiDatasource?
        >
    with $Provider<WalletApiDatasource?> {
  /// The GauX API's wallet endpoints, or null for builds without the API.
  WalletApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'walletApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$walletApiHash();

  @$internal
  @override
  $ProviderElement<WalletApiDatasource?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WalletApiDatasource? create(Ref ref) {
    return walletApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WalletApiDatasource? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WalletApiDatasource?>(value),
    );
  }
}

String _$walletApiHash() => r'02e5774962f88dd5597a361d39b00bae0be472a5';

/// The server-ledger wallet, or null for builds without the API.

@ProviderFor(apiGoldCardRepository)
final apiGoldCardRepositoryProvider = ApiGoldCardRepositoryProvider._();

/// The server-ledger wallet, or null for builds without the API.

final class ApiGoldCardRepositoryProvider
    extends
        $FunctionalProvider<
          ApiGoldCardRepository?,
          ApiGoldCardRepository?,
          ApiGoldCardRepository?
        >
    with $Provider<ApiGoldCardRepository?> {
  /// The server-ledger wallet, or null for builds without the API.
  ApiGoldCardRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiGoldCardRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiGoldCardRepositoryHash();

  @$internal
  @override
  $ProviderElement<ApiGoldCardRepository?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ApiGoldCardRepository? create(Ref ref) {
    return apiGoldCardRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiGoldCardRepository? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiGoldCardRepository?>(value),
    );
  }
}

String _$apiGoldCardRepositoryHash() =>
    r'2b08883eea871224f5acb5b2b37d93f4f10aeacf';

/// The on-device wallet, used when there's no API.

@ProviderFor(localGoldCardRepository)
final localGoldCardRepositoryProvider = LocalGoldCardRepositoryProvider._();

/// The on-device wallet, used when there's no API.

final class LocalGoldCardRepositoryProvider
    extends
        $FunctionalProvider<
          LocalGoldCardRepository,
          LocalGoldCardRepository,
          LocalGoldCardRepository
        >
    with $Provider<LocalGoldCardRepository> {
  /// The on-device wallet, used when there's no API.
  LocalGoldCardRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localGoldCardRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localGoldCardRepositoryHash();

  @$internal
  @override
  $ProviderElement<LocalGoldCardRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalGoldCardRepository create(Ref ref) {
    return localGoldCardRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalGoldCardRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalGoldCardRepository>(value),
    );
  }
}

String _$localGoldCardRepositoryHash() =>
    r'a185116e9f253fd4a7ca1c4be544a9f440ad0c2e';

@ProviderFor(goldCardRepository)
final goldCardRepositoryProvider = GoldCardRepositoryProvider._();

final class GoldCardRepositoryProvider
    extends
        $FunctionalProvider<
          GoldCardRepository,
          GoldCardRepository,
          GoldCardRepository
        >
    with $Provider<GoldCardRepository> {
  GoldCardRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goldCardRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goldCardRepositoryHash();

  @$internal
  @override
  $ProviderElement<GoldCardRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GoldCardRepository create(Ref ref) {
    return goldCardRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoldCardRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoldCardRepository>(value),
    );
  }
}

String _$goldCardRepositoryHash() =>
    r'85597e29895bbbb5303843bdee62fafab5354b11';

@ProviderFor(topUpWallet)
final topUpWalletProvider = TopUpWalletProvider._();

final class TopUpWalletProvider
    extends $FunctionalProvider<TopUpWallet, TopUpWallet, TopUpWallet>
    with $Provider<TopUpWallet> {
  TopUpWalletProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'topUpWalletProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$topUpWalletHash();

  @$internal
  @override
  $ProviderElement<TopUpWallet> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TopUpWallet create(Ref ref) {
    return topUpWallet(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TopUpWallet value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TopUpWallet>(value),
    );
  }
}

String _$topUpWalletHash() => r'141f5d2f143eba57543d9e71448e1c66d526bead';

/// The rider's wallet, updated after every charge and top-up.

@ProviderFor(goldCard)
final goldCardProvider = GoldCardProvider._();

/// The rider's wallet, updated after every charge and top-up.

final class GoldCardProvider
    extends
        $FunctionalProvider<AsyncValue<GoldCard>, GoldCard, Stream<GoldCard>>
    with $FutureModifier<GoldCard>, $StreamProvider<GoldCard> {
  /// The rider's wallet, updated after every charge and top-up.
  GoldCardProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goldCardProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goldCardHash();

  @$internal
  @override
  $StreamProviderElement<GoldCard> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<GoldCard> create(Ref ref) {
    return goldCard(ref);
  }
}

String _$goldCardHash() => r'9fe384507ad0dfb01b9ce9e7330bedf3930bf109';
