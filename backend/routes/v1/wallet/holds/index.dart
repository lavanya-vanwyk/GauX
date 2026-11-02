import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_backend/gaux_backend.dart';
import 'package:gaux_contracts/gaux_contracts.dart';

/// `POST /v1/wallet/holds` with an `Idempotency-Key` header and a
/// [HoldRequest] body. Reserves the quote's fare when a ride is confirmed;
/// charging the quote later settles from the hold. `402` if the wallet
/// can't cover it.
Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) return methodNotAllowed();
  final key = idempotencyKey(context.request);
  if (key == null) return missingIdempotencyKey();

  return forSignedInRider(context, (rider, ledger) async {
    final request = HoldRequest.fromJson(await jsonBody(context.request));
    final wallet = await ledger.placeHold(rider, request, idempotencyKey: key);
    return Response.json(body: wallet.toJson());
  });
}
