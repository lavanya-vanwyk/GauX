import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/access_token.dart';
import '../location/location_service.dart';
import '../network/api_client.dart';
import '../storage/secure_cache.dart';

part 'core_providers.g.dart';

/// Loaded before `runApp` and supplied with an override in `main.dart`.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) => throw UnimplementedError(
  'sharedPreferencesProvider must be overridden in ProviderScope',
);

@Riverpod(keepAlive: true)
http.Client httpClient(Ref ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return client;
}

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) =>
    ApiClient(httpClient: ref.watch(httpClientProvider));

@Riverpod(keepAlive: true)
LocationService locationService(Ref ref) => const GeolocatorLocationService();

/// The current time. Override in tests for deterministic timestamps.
@Riverpod(keepAlive: true)
DateTime Function() clock(Ref ref) => DateTime.now;

@Riverpod(keepAlive: true)
SecureCache secureCache(Ref ref) => const PlatformSecureCache();

/// Bearer token for GauX API calls. Signed-out until the app layer connects
/// it to the session (see `lib/app/app_overrides.dart`).
@Riverpod(keepAlive: true)
AccessTokenSource accessToken(Ref ref) =>
    () async => null;
