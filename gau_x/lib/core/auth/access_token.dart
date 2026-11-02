/// Supplies the bearer token for GauX API calls, or null when signed out.
///
/// Features ask for this instead of reading the auth feature directly; the
/// app layer connects it to the Keycloak session.
typedef AccessTokenSource = Future<String?> Function();

/// Signs the rider out. Same idea: features call this without depending on
/// the auth feature.
typedef SignOutAction = Future<void> Function();
