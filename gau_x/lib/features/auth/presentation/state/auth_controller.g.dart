// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The signed-in session, or null when signed out. The router listens to
/// this to guard the wallet. A session saved from the last launch is
/// restored in the background on start-up.

@ProviderFor(AuthController)
final authControllerProvider = AuthControllerProvider._();

/// The signed-in session, or null when signed out. The router listens to
/// this to guard the wallet. A session saved from the last launch is
/// restored in the background on start-up.
final class AuthControllerProvider
    extends $NotifierProvider<AuthController, AuthSession?> {
  /// The signed-in session, or null when signed out. The router listens to
  /// this to guard the wallet. A session saved from the last launch is
  /// restored in the background on start-up.
  AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthSession? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthSession?>(value),
    );
  }
}

String _$authControllerHash() => r'812d149e2d1fe8fc8f5b10c675190b8313fb0d0b';

/// The signed-in session, or null when signed out. The router listens to
/// this to guard the wallet. A session saved from the last launch is
/// restored in the background on start-up.

abstract class _$AuthController extends $Notifier<AuthSession?> {
  AuthSession? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AuthSession?, AuthSession?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthSession?, AuthSession?>,
              AuthSession?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
