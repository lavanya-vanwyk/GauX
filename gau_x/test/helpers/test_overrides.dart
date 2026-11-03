import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:gau_x/core/di/core_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Overrides every test container needs: empty in-memory storage (so the
/// remote config falls back to defaults) plus anything test-specific.
Future<ProviderContainer> testContainer({
  List<Override> overrides = const [],
  Map<String, Object> storage = const {},
}) async {
  SharedPreferences.setMockInitialValues(storage);
  final prefs = await SharedPreferences.getInstance();
  return ProviderContainer.test(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      ...overrides,
    ],
  );
}
