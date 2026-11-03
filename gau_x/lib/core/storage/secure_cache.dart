import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Small key/value store for data that shouldn't sit in plain
/// SharedPreferences, such as the cached wallet. Backed by the Android
/// Keystore / iOS Keychain.
abstract interface class SecureCache {
  Future<String?> read(String key);

  Future<void> write(String key, String value);

  Future<void> delete(String key);
}

class PlatformSecureCache implements SecureCache {
  const PlatformSecureCache([this._storage = const FlutterSecureStorage()]);

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);
}

/// For tests, and platforms without a secure store.
class InMemorySecureCache implements SecureCache {
  final _values = <String, String>{};

  @override
  Future<String?> read(String key) async => _values[key];

  @override
  Future<void> write(String key, String value) async => _values[key] = value;

  @override
  Future<void> delete(String key) async => _values.remove(key);
}
