/// Supplies the bearer token for GauX API calls, or null when signed out.
///
/// Features ask for this instead of reading the auth feature directly; the
/// app layer connects it to the signed-in session. Today the token is the
/// development form `dev:<email>`; Keycloak access tokens replace it later.
typedef AccessTokenSource = Future<String?> Function();
