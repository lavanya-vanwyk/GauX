import 'package:gaux_backend/src/cache/ttl_cache.dart';
import 'package:gaux_backend/src/rate_limit/request_throttle.dart';
import 'package:gaux_backend/src/upstream/geocoding_provider.dart';
import 'package:gaux_backend/src/upstream/routing_provider.dart';
import 'package:gaux_contracts/gaux_contracts.dart';

/// Serves repeated route lookups from memory.
class CachingRoutingProvider implements RoutingProvider {
  CachingRoutingProvider(this._inner, {required Duration ttl})
    : _cache = TtlCache(ttl: ttl);

  final RoutingProvider _inner;

  // "No route" is cached too (as null in the record) so unroutable points
  // aren't retried on every request
  final TtlCache<String, ({RouteResponse? route})> _cache;

  @override
  Future<RouteResponse?> route(GeoPoint from, GeoPoint to) async {
    final key = '${_round(from)};${_round(to)}';
    final hit = await _cache.getOrCompute(
      key,
      () async => (route: await _inner.route(from, to)),
    );
    return hit.route;
  }

  /// ~1 m precision, so tiny GPS jitter still hits the cache.
  static String _round(GeoPoint p) =>
      '${p.lat.toStringAsFixed(5)},${p.lng.toStringAsFixed(5)}';
}

/// Caches place searches and spaces out calls to the geocoder.
class ThrottledGeocodingProvider implements GeocodingProvider {
  ThrottledGeocodingProvider(
    this._inner, {
    required Duration ttl,
    required RequestThrottle throttle,
  }) : _cache = TtlCache(ttl: ttl),
       _throttle = throttle;

  final GeocodingProvider _inner;
  final TtlCache<String, List<PlaceDto>> _cache;
  final RequestThrottle _throttle;

  @override
  Future<List<PlaceDto>> search(String query, {required int limit}) {
    final key = '${query.trim().toLowerCase()}|$limit';
    return _cache.getOrCompute(
      key,
      () => _throttle.run(() => _inner.search(query, limit: limit)),
    );
  }
}
