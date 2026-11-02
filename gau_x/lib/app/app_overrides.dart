import 'package:flutter_riverpod/misc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/di/core_providers.dart';
import '../features/trip_tracking/di/trip_tracking_providers.dart';
import '../features/wallet/di/wallet_providers.dart';
import 'adapters/wallet_trip_payment_adapter.dart';

/// Wiring that crosses feature boundaries or needs async setup, applied to
/// the root `ProviderScope`. Tests build their own list.
List<Override> appOverrides({required SharedPreferences prefs}) => [
  sharedPreferencesProvider.overrideWithValue(prefs),
  tripPaymentPortProvider.overrideWith(
    (ref) => WalletTripPaymentAdapter(
      repository: ref.watch(goldCardRepositoryProvider),
      chargeWallet: ref.watch(chargeWalletProvider),
    ),
  ),
];
