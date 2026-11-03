import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_backend/gaux_backend.dart';

/// `GET /v1/wallet`: balance and recent entries. Opens the wallet (with its
/// welcome credit) on first use.
Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.get) return methodNotAllowed();
  return forSignedInRider(context, (rider, ledger) async {
    return Response.json(body: (await ledger.wallet(rider)).toJson());
  });
}
