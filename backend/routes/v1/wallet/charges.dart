import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_backend/gaux_backend.dart';
import 'package:gaux_contracts/gaux_contracts.dart';

/// `POST /v1/wallet/charges` with an `Idempotency-Key` header and a
/// [ChargeRequest] body. Charges a quote: the full fare, or a partial fare
/// for a cancellation. Retrying with the same key never charges twice.
Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) return methodNotAllowed();
  final key = idempotencyKey(context.request);
  if (key == null) return missingIdempotencyKey();

  return forSignedInRider(context, (rider, ledger) async {
    final request = ChargeRequest.fromJson(await jsonBody(context.request));
    if (request.distanceCoveredMeters < 0) {
      return badRequest('distanceCoveredMeters must be >= 0');
    }
    final wallet = await ledger.charge(rider, request, idempotencyKey: key);
    return Response.json(body: wallet.toJson());
  });
}
