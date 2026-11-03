// Checks real Keycloak tokens against the dev realm in
// backend/dev/keycloak (see backend/README.md to start it). Skip with
// `dart test -x keycloak`.
@Tags(['keycloak'])
library;

import 'dart:convert';
import 'dart:io';

import 'package:gaux_backend/gaux_backend.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

final _issuer =
    Platform.environment['TEST_OIDC_ISSUER'] ??
    'http://localhost:8180/realms/gaux';

Future<Map<String, dynamic>> _passwordGrant(String clientId) async {
  final response = await http.post(
    Uri.parse('$_issuer/protocol/openid-connect/token'),
    body: {
      'grant_type': 'password',
      'client_id': clientId,
      'username': 'judge@gaux.co.za',
      'password': 'Hackathon2026!',
      'scope': 'openid',
    },
  );
  return jsonDecode(response.body) as Map<String, dynamic>;
}

void main() {
  final authenticator = OidcAuthenticator(
    issuer: _issuer,
    audience: 'gaux-api',
  );

  test('a real Keycloak access token identifies the judge', () async {
    final tokens = await _passwordGrant('gaux-dev-cli');

    final subject = await authenticator.verify(
      tokens['access_token'] as String,
    );

    expect(subject, isNotNull);
    expect(subject, matches(RegExp(r'^[0-9a-f-]{36}$')));
  });

  test('ID tokens are not accepted as access tokens', () async {
    final tokens = await _passwordGrant('gaux-dev-cli');

    expect(await authenticator.verify(tokens['id_token'] as String), isNull);
  });

  test('the app client cannot use the password grant', () async {
    final response = await _passwordGrant('gaux-app');

    expect(response['error'], 'unauthorized_client');
  });
}
