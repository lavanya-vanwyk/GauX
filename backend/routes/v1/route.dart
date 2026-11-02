import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_backend/gaux_backend.dart';
import 'package:gaux_contracts/gaux_contracts.dart';

/// `GET /v1/route?from=lat,lng&to=lat,lng`
Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.get) return methodNotAllowed();

  final query = context.request.uri.queryParameters;
  final from = GeoPoint.tryParse(query['from']);
  final to = GeoPoint.tryParse(query['to']);
  if (from == null || to == null) {
    return badRequest('from and to must be "lat,lng"');
  }

  try {
    final route = await context.read<BackendServices>().routing.route(from, to);
    if (route == null) {
      return errorResponse(
        HttpStatus.notFound,
        ApiErrorCode.notFound,
        'No road route between these points',
      );
    }
    return Response.json(body: route.toJson());
  } on UpstreamException {
    return upstreamUnavailable('Routing');
  }
}
