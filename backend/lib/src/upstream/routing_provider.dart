import 'dart:async';
import 'dart:convert';

import 'package:gaux_backend/src/upstream/upstream_exception.dart';
import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

/// Driving routes from some routing engine.
abstract interface class RoutingProvider {
  /// The route from [from] to [to], or null if no road route exists.
  ///
  /// Throws [UpstreamException] if the engine is unreachable or misbehaves.
  Future<RouteResponse?> route(GeoPoint from, GeoPoint to);
}

/// OSRM's `/route/v1/driving` service.
class OsrmRoutingProvider implements RoutingProvider {
  OsrmRoutingProvider({
    required http.Client client,
    required this.baseUrl,
    required this.userAgent,
    this.timeout = const Duration(seconds: 10),
  }) : _client = client;

  final http.Client _client;
  final String baseUrl;
  final String userAgent;
  final Duration timeout;

  static const _distance = Distance();

  @override
  Future<RouteResponse?> route(GeoPoint from, GeoPoint to) async {
    final url = Uri.parse(
      '$baseUrl/route/v1/driving/'
      '${from.lng},${from.lat};${to.lng},${to.lat}'
      '?overview=full&geometries=geojson',
    );

    final http.Response response;
    try {
      response = await _client
          .get(url, headers: {'User-Agent': userAgent})
          .timeout(timeout);
    } on TimeoutException {
      throw const UpstreamException('osrm', 'timed out');
    } on http.ClientException catch (e) {
      throw UpstreamException('osrm', e.message);
    }

    // OSRM answers 400 with code NoRoute/NoSegment for unroutable points
    final Object? body;
    try {
      body = jsonDecode(response.body);
    } on FormatException {
      throw UpstreamException('osrm', 'HTTP ${response.statusCode}, not JSON');
    }
    if (body is! Map<String, dynamic>) {
      throw const UpstreamException('osrm', 'unexpected response');
    }
    final code = body['code'];
    if (code == 'NoRoute' || code == 'NoSegment') return null;
    if (response.statusCode != 200 || code != 'Ok') {
      throw UpstreamException('osrm', 'HTTP ${response.statusCode} ($code)');
    }

    try {
      final routes = body['routes'] as List<dynamic>;
      if (routes.isEmpty) return null;
      final geometry =
          (routes.first as Map<String, dynamic>)['geometry']
              as Map<String, dynamic>;
      final points = [
        for (final pair in geometry['coordinates'] as List<dynamic>)
          GeoPoint(
            lat: ((pair as List<dynamic>)[1] as num).toDouble(),
            lng: (pair[0] as num).toDouble(),
          ),
      ];
      return RouteResponse(points: points, distanceMeters: _length(points));
      // The JSON casts above throw TypeError on an unexpected shape
      // ignore: avoid_catching_errors
    } on TypeError catch (e) {
      throw UpstreamException('osrm', 'unexpected shape: $e');
    }
  }

  /// Measured along the geometry, the same way the app measured it before
  /// the backend existed, so fares don't change.
  static double _length(List<GeoPoint> points) {
    var total = 0.0;
    for (var i = 0; i < points.length - 1; i++) {
      total += _distance.as(
        LengthUnit.Meter,
        LatLng(points[i].lat, points[i].lng),
        LatLng(points[i + 1].lat, points[i + 1].lng),
      );
    }
    return total;
  }
}
