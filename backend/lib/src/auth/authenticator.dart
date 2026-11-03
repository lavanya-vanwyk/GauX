import 'package:dart_frog/dart_frog.dart';

/// Works out who is calling. Returns the user's stable ID, or null when the
/// request isn't authenticated.
///
/// The Keycloak (OIDC) implementation will verify a signed access token and
/// return its `sub` claim; nothing else changes.
abstract interface class Authenticator {
  Future<String?> userId(Request request);
}

/// Rejects every request. The default until real sign-in is configured.
class DenyAllAuthenticator implements Authenticator {
  const DenyAllAuthenticator();

  @override
  Future<String?> userId(Request request) async => null;
}

/// Trusts `Authorization: Bearer dev:<user-id>`. Anyone can claim any user,
/// so this is for local development and demos only (`DEV_AUTH=true`).
class DevAuthenticator implements Authenticator {
  const DevAuthenticator();

  static final _userId = RegExp(r'^[A-Za-z0-9@._+-]{1,128}$');

  @override
  Future<String?> userId(Request request) async {
    final header = request.headers['authorization'];
    if (header == null || !header.startsWith('Bearer dev:')) return null;
    final id = header.substring('Bearer dev:'.length);
    return _userId.hasMatch(id) ? id : null;
  }
}
