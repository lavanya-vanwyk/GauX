import 'dart:io';

/// Settings read from environment variables, with defaults suitable for
/// local development.
class ServerConfig {
  const ServerConfig({
    this.osrmBaseUrl = 'https://router.project-osrm.org',
    this.nominatimBaseUrl = 'https://nominatim.openstreetmap.org/search',
    this.upstreamUserAgent = 'GauX-Backend/0.1 (+https://gaux.co.za)',
    this.remoteConfigPath,
    this.databaseUrl,
    this.migrateOnStart = true,
    this.devAuth = false,
    this.simulatedTopUps = false,
    this.requestsPerMinute = 120,
    this.cacheTtl = const Duration(minutes: 10),
    this.geocodingMinInterval = const Duration(seconds: 1),
  });

  factory ServerConfig.fromEnvironment([Map<String, String>? environment]) {
    final env = environment ?? Platform.environment;
    int? integer(String key) => int.tryParse(env[key] ?? '');
    const defaults = ServerConfig();
    return ServerConfig(
      osrmBaseUrl: env['OSRM_BASE_URL'] ?? defaults.osrmBaseUrl,
      nominatimBaseUrl: env['NOMINATIM_BASE_URL'] ?? defaults.nominatimBaseUrl,
      upstreamUserAgent:
          env['UPSTREAM_USER_AGENT'] ?? defaults.upstreamUserAgent,
      remoteConfigPath: env['REMOTE_CONFIG_PATH'],
      databaseUrl: env['DATABASE_URL'],
      migrateOnStart: env['MIGRATE_ON_START'] != 'false',
      devAuth: env['DEV_AUTH'] == 'true',
      simulatedTopUps: env['SIMULATED_TOPUPS'] == 'true',
      requestsPerMinute:
          integer('RATE_LIMIT_PER_MINUTE') ?? defaults.requestsPerMinute,
      cacheTtl: Duration(
        seconds: integer('CACHE_TTL_SECONDS') ?? defaults.cacheTtl.inSeconds,
      ),
      geocodingMinInterval: Duration(
        milliseconds:
            integer('GEOCODING_MIN_INTERVAL_MS') ??
            defaults.geocodingMinInterval.inMilliseconds,
      ),
    );
  }

  final String osrmBaseUrl;
  final String nominatimBaseUrl;

  /// Sent to OSM services, whose usage policies require an identifying
  /// User-Agent with contact details.
  final String upstreamUserAgent;

  /// Optional JSON file with the remote config document. Defaults are served
  /// when unset.
  final String? remoteConfigPath;

  /// Postgres for the wallet ledger, e.g.
  /// `postgresql://user:pass@host:5432/gaux`. Wallet and quote endpoints
  /// answer 503 when unset.
  final String? databaseUrl;

  /// Apply pending database migrations at startup. Turn off when a separate
  /// release step runs them.
  final bool migrateOnStart;

  /// Accept `Authorization: Bearer dev:<user-id>` as proof of identity.
  /// Local development and demos only: anyone can claim any user.
  final bool devAuth;

  /// Allow top-ups without a payment provider confirming the money.
  final bool simulatedTopUps;

  /// Per client IP, across all `/v1` endpoints.
  final int requestsPerMinute;

  /// How long identical route and place lookups are served from memory.
  final Duration cacheTtl;

  /// Minimum gap between calls to the geocoder. The public Nominatim allows
  /// at most one request per second.
  final Duration geocodingMinInterval;
}
