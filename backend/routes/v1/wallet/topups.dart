import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_backend/gaux_backend.dart';
import 'package:gaux_contracts/gaux_contracts.dart';

/// Largest single top-up, in cents (R5 000).
const _maxTopUpCents = 500000;

/// `POST /v1/wallet/topups` with an `Idempotency-Key` header and a
/// [TopUpRequest] body.
///
/// Simulated: no payment provider confirms the money, so this is disabled
/// unless the server runs with `SIMULATED_TOPUPS=true`.
Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) return methodNotAllowed();
  if (!context.read<BackendServices>().simulatedTopUps) {
    return errorResponse(
      HttpStatus.serviceUnavailable,
      ApiErrorCode.serviceUnavailable,
      'Top-ups need a payment provider, which is not configured',
    );
  }
  final key = idempotencyKey(context.request);
  if (key == null) return missingIdempotencyKey();

  return forSignedInRider(context, (rider, ledger) async {
    final request = TopUpRequest.fromJson(await jsonBody(context.request));
    if (request.amountCents <= 0 || request.amountCents > _maxTopUpCents) {
      return badRequest('amountCents must be 1-$_maxTopUpCents');
    }
    final wallet = await ledger.topUp(rider, request, idempotencyKey: key);
    return Response.json(body: wallet.toJson());
  });
}
