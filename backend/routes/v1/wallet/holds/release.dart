import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_backend/gaux_backend.dart';
import 'package:gaux_contracts/gaux_contracts.dart';

/// `POST /v1/wallet/holds/release` with an `Idempotency-Key` header and a
/// [HoldRequest] body. Returns a hold to the wallet because the ride was
/// cancelled before pickup. Does nothing if the quote has no open hold.
Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) return methodNotAllowed();
  final key = idempotencyKey(context.request);
  if (key == null) return missingIdempotencyKey();

  return forSignedInRider(context, (rider, ledger) async {
    final request = HoldRequest.fromJson(await jsonBody(context.request));
    final wallet = await ledger.releaseHold(
      rider,
      request,
      idempotencyKey: key,
    );
    return Response.json(body: wallet.toJson());
  });
}
