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
  /// From an Android emulator, a backend on your machine is at
  /// `http://10.0.2.2:8080`.
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

  /// Enables the hard-coded demo account used for hackathon judging.
  /// Must be false for any build that real users install.
  static const bool demoLoginEnabled = bool.fromEnvironment(
    'DEMO_LOGIN_ENABLED',
    defaultValue: true,
  );
}
