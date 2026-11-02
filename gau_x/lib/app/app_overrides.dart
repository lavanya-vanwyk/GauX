import 'package:flutter_riverpod/misc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/di/core_providers.dart';
import '../features/auth/di/auth_providers.dart';
import '../features/auth/presentation/state/auth_controller.dart';
import '../features/booking/di/booking_providers.dart';
import '../features/trip_tracking/di/trip_tracking_providers.dart';
import '../features/wallet/di/wallet_providers.dart';
import 'adapters/api_trip_payments.dart';
import 'adapters/local_trip_payments.dart';

/// Wiring that crosses feature boundaries or needs async setup, applied to
/// the root `ProviderScope`. Tests build their own list.
List<Override> appOverrides({required SharedPreferences prefs}) => [
  sharedPreferencesProvider.overrideWithValue(prefs),

  // Keycloak access tokens, refreshed by the auth repository as needed
  accessTokenProvider.overrideWith(
    (ref) => ref.watch(authRepositoryProvider).accessToken,
  ),
  signOutProvider.overrideWith(
    (ref) => ref.read(authControllerProvider.notifier).signOut,
  ),

  tripPaymentPortProvider.overrideWith((ref) {
    final api = ref.watch(walletApiProvider);
    final apiWallet = ref.watch(apiGoldCardRepositoryProvider);
    if (api != null && apiWallet != null) {
      return ApiTripPayments(api: api, wallet: apiWallet);
    }
    return LocalTripPayments(
      wallet: ref.watch(localGoldCardRepositoryProvider),
      fares: ref.watch(fareCalculatorProvider),
    );
  }),
];
