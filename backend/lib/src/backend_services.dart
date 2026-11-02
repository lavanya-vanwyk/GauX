import 'package:gaux_backend/src/data/stations.dart';
import 'package:gaux_backend/src/rate_limit/client_rate_limiter.dart';
import 'package:gaux_backend/src/rate_limit/request_throttle.dart';
import 'package:gaux_backend/src/remote_config_source.dart';
import 'package:gaux_backend/src/server_config.dart';
import 'package:gaux_backend/src/upstream/caching_providers.dart';
import 'package:gaux_backend/src/upstream/geocoding_provider.dart';
import 'package:gaux_backend/src/upstream/routing_provider.dart';
import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:http/http.dart' as http;

/// Everything the routes need, built once per process. Tests construct this
/// with fakes.
class BackendServices {
  BackendServices({
    required this.routing,
    required this.geocoding,
    required this.remoteConfig,
    required this.rateLimiter,
    this.stations = gautrainStations,
  });

  factory BackendServices.fromConfig(ServerConfig config) {
    final client = http.Client();
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
    );
  }

  final RoutingProvider routing;
  final GeocodingProvider geocoding;
  final RemoteConfigSource remoteConfig;
  final ClientRateLimiter rateLimiter;
  final List<StationDto> stations;
}
