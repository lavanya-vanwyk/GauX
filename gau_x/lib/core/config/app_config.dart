/// Build-time configuration, read from `--dart-define` or
/// `--dart-define-from-file=config/<env>.json`.
///
/// Only non-secret values belong here: anything compiled into the app can be
/// extracted from the binary. Secrets stay on the backend.
abstract final class AppConfig {
  static const String environment = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'dev',
  );

  /// The GauX API (see `backend/`). When empty, the app calls OSRM and
  /// Nominatim directly and uses its bundled stations and default config,
  /// which is how local development works without running the backend.
  ///
  /// For local development, `http://localhost:8080` reaches a backend on
  /// your machine once `adb reverse tcp:8080 tcp:8080` is set up.
  static const String gauxApiBaseUrl = String.fromEnvironment(
    'GAUX_API_BASE_URL',
  );

  static bool get usesGauxApi => gauxApiBaseUrl.isNotEmpty;

  static const String nominatimBaseUrl = String.fromEnvironment(
    'NOMINATIM_BASE_URL',
    defaultValue: 'https://nominatim.openstreetmap.org/search',
  );

  static const String osrmBaseUrl = String.fromEnvironment(
    'OSRM_BASE_URL',
    defaultValue: 'https://router.project-osrm.org',
  );

  /// The Keycloak realm riders sign in with, e.g.
  /// `https://auth.gaux.co.za/realms/gaux`. Empty means sign-in isn't
  /// available in this build.
  ///
  /// For local development `http://localhost:8180/realms/gaux` reaches the
  /// dev Keycloak once `adb reverse tcp:8180 tcp:8180` is set up (see the
  /// backend README).
  static const String oidcIssuer = String.fromEnvironment('OIDC_ISSUER');

  static const String oidcClientId = String.fromEnvironment(
    'OIDC_CLIENT_ID',
    defaultValue: 'gaux-app',
  );

  /// Must match the redirect URI registered for [oidcClientId] in Keycloak,
  /// and the scheme in the Android and iOS project settings.
  static const String oidcRedirectUrl = 'za.co.gaux.app:/oauthredirect';
}
