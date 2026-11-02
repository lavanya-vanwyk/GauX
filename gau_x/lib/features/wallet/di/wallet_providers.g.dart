// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
    r'c7d8699ab7a8e7060ad965cb1a9e8da2a4143f89';

@ProviderFor(chargeWallet)
final chargeWalletProvider = ChargeWalletProvider._();

final class ChargeWalletProvider
    extends $FunctionalProvider<ChargeWallet, ChargeWallet, ChargeWallet>
    with $Provider<ChargeWallet> {
  ChargeWalletProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chargeWalletProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chargeWalletHash();

  @$internal
  @override
  $ProviderElement<ChargeWallet> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ChargeWallet create(Ref ref) {
    return chargeWallet(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChargeWallet value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChargeWallet>(value),
    );
  }
}

String _$chargeWalletHash() => r'b0b6d3b35251a6b01a4dcaf921881559e41f8666';

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

String _$topUpWalletHash() => r'e874e398e0cea73808963de8169b81360864f943';

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
