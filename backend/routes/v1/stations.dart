import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_backend/gaux_backend.dart';
import 'package:gaux_contracts/gaux_contracts.dart';

/// `GET /v1/stations`
Response onRequest(RequestContext context) {
  if (context.request.method != HttpMethod.get) return methodNotAllowed();
  final stations = context.read<BackendServices>().stations;
  return Response.json(body: StationsResponse(stations: stations).toJson());
}
