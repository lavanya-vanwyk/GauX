import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_backend/gaux_backend.dart';
import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:latlong2/latlong.dart';

/// How far `from` may be from a station's recorded position.
const _stationToleranceMeters = 300.0;

/// `POST /v1/quotes` with a [QuoteRequest] body: prices a ride from a GauX
/// station. The server works out the route and fare itself, and enforces
/// the service area, so riders are charged what the server quoted.
Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) return methodNotAllowed();

  return forSignedInRider(context, (rider, ledger) async {
    final services = context.read<BackendServices>();
    final request = QuoteRequest.fromJson(await jsonBody(context.request));
    final config = services.remoteConfig.config;

    if (!config.flags.bookingEnabled) {
      return errorResponse(
        HttpStatus.serviceUnavailable,
        ApiErrorCode.serviceUnavailable,
        'Booking is paused',
      );
    }
    if (request.rideType == RideKind.pool && !config.flags.poolEnabled) {
      return badRequest('Pool rides are not available right now');
    }

    const distance = Distance();
    LatLng latLng(GeoPoint p) => LatLng(p.lat, p.lng);
    final fromStation = services.stations.any(
      (s) =>
          distance(latLng(s.location), latLng(request.from)) <=
          _stationToleranceMeters,
    );
    final withinRadius =
        distance(latLng(request.from), latLng(request.to)) <=
        config.serviceArea.radiusMeters;
    if (!fromStation || !withinRadius) {
      return errorResponse(
        HttpStatus.unprocessableEntity,
        ApiErrorCode.outsideServiceArea,
        'Rides must start at a GauX station and end within '
        '${config.serviceArea.radiusMeters} m of it',
      );
    }

    final RouteResponse? route;
    try {
      route = await services.routing.route(request.from, request.to);
    } on UpstreamException {
      return upstreamUnavailable('Routing');
    }
    if (route == null) {
      return errorResponse(
        HttpStatus.notFound,
        ApiErrorCode.notFound,
        'No road route between these points',
      );
    }

    final quote = await ledger.createQuote(
      rider,
      rideType: request.rideType,
      distanceMeters: route.distanceMeters,
      pricing: config.pricing,
    );
    return Response.json(statusCode: HttpStatus.created, body: quote.toJson());
  });
}
