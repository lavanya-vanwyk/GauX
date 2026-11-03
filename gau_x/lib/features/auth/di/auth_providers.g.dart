// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The identity provider client, or null when the build has none configured.

@ProviderFor(oidcClient)
final oidcClientProvider = OidcClientProvider._();

/// The identity provider client, or null when the build has none configured.

final class OidcClientProvider
    extends $FunctionalProvider<OidcClient?, OidcClient?, OidcClient?>
    with $Provider<OidcClient?> {
  /// The identity provider client, or null when the build has none configured.
  OidcClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'oidcClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$oidcClientHash();

  @$internal
  @override
  $ProviderElement<OidcClient?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OidcClient? create(Ref ref) {
    return oidcClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OidcClient? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OidcClient?>(value),
    );
  }
}

String _$oidcClientHash() => r'508d48c55ebbfe5127578063aee435f603ab12c6';

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'ea4df186662ec37c22282ab7e30fc6c8adfcdd1c';
