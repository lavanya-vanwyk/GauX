import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_backend/gaux_backend.dart';
import 'package:gaux_contracts/gaux_contracts.dart';

const _maxLimit = 10;
const _maxQueryLength = 200;

/// `GET /v1/places?q=...&limit=5`
Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.get) return methodNotAllowed();

  final params = context.request.uri.queryParameters;
  final query = params['q']?.trim() ?? '';
  if (query.isEmpty || query.length > _maxQueryLength) {
    return badRequest('q must be 1-$_maxQueryLength characters');
  }
  final limit = int.tryParse(params['limit'] ?? '5');
  if (limit == null || limit < 1 || limit > _maxLimit) {
    return badRequest('limit must be 1-$_maxLimit');
  }

  try {
    final places = await context.read<BackendServices>().geocoding.search(
      query,
      limit: limit,
    );
    return Response.json(body: PlacesResponse(places: places).toJson());
  } on UpstreamException {
    return upstreamUnavailable('Geocoding');
  }
}
