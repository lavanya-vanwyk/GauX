import 'package:gaux_backend/src/auth/authenticator.dart';
import 'package:gaux_backend/src/auth/oidc_authenticator.dart';
import 'package:gaux_backend/src/data/stations.dart';
import 'package:gaux_backend/src/db/migrator.dart';
import 'package:gaux_backend/src/ledger/ledger_service.dart';
import 'package:gaux_backend/src/rate_limit/client_rate_limiter.dart';
import 'package:gaux_backend/src/rate_limit/request_throttle.dart';
import 'package:gaux_backend/src/remote_config_source.dart';
import 'package:gaux_backend/src/server_config.dart';
import 'package:gaux_backend/src/upstream/caching_providers.dart';
import 'package:gaux_backend/src/upstream/geocoding_provider.dart';
import 'package:gaux_backend/src/upstream/routing_provider.dart';
import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:http/http.dart' as http;
import 'package:postgres/postgres.dart';

/// Everything the routes need, built once per process. Tests construct this
/// with fakes.
class BackendServices {
  BackendServices({
    required this.routing,
    required this.geocoding,
    required this.remoteConfig,
    required this.rateLimiter,
    this.stations = gautrainStations,
    this.ledger,
    this.authenticator = const DenyAllAuthenticator(),
    this.simulatedTopUps = false,
    Pool<void>? database,
  }) : _database = database;

  factory BackendServices.fromConfig(ServerConfig config) {
    final client = http.Client();
    final databaseUrl = config.databaseUrl;
    final database = databaseUrl == null
        ? null
        : Pool<void>.withUrl(databaseUrl);
    return BackendServices(
      routing: CachingRoutingProvider(
        OsrmRoutingProvider(
          client: client,
          baseUrl: config.osrmBaseUrl,
          userAgent: config.upstreamUserAgent,
        ),
        ttl: config.cacheTtl,
      ),
      geocoding: ThrottledGeocodingProvider(
        NominatimGeocodingProvider(
          client: client,
          baseUrl: config.nominatimBaseUrl,
          userAgent: config.upstreamUserAgent,
        ),
        ttl: config.cacheTtl,
        throttle: RequestThrottle(minInterval: config.geocodingMinInterval),
      ),
      remoteConfig: RemoteConfigSource.load(config.remoteConfigPath),
      rateLimiter: ClientRateLimiter(capacity: config.requestsPerMinute),
      database: database,
      ledger: database == null ? null : LedgerService(database),
      authenticator: _authenticatorFor(config, client),
      simulatedTopUps: config.simulatedTopUps,
    );
  }

  final RoutingProvider routing;
  final GeocodingProvider geocoding;
  final RemoteConfigSource remoteConfig;
  final ClientRateLimiter rateLimiter;
  final List<StationDto> stations;

  static Authenticator _authenticatorFor(
    ServerConfig config,
    http.Client client,
  ) {
    final issuer = config.oidcIssuer;
    final jwks = config.oidcJwksUrl;
    return FirstOfAuthenticator([
      if (issuer != null)
        OidcAuthenticator(
          issuer: issuer,
          audience: config.oidcAudience,
          jwksUrl: jwks == null ? null : Uri.parse(jwks),
          httpClient: client,
        ),
      if (config.devAuth) const DevAuthenticator(),
    ]);
  }

  /// Null when no database is configured; wallet endpoints then answer 503.
  final LedgerService? ledger;
  final Authenticator authenticator;
  final bool simulatedTopUps;
  final Pool<void>? _database;

  /// Applies pending database migrations, if there is a database.
  Future<void> migrate() async {
    final database = _database;
    if (database != null) await Migrator(database).migrate();
  }
}
