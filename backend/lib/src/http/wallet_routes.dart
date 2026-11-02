import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_backend/src/backend_services.dart';
import 'package:gaux_backend/src/http/responses.dart';
import 'package:gaux_backend/src/ledger/ledger_exception.dart';
import 'package:gaux_backend/src/ledger/ledger_service.dart';
import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:json_annotation/json_annotation.dart';

/// Runs [handle] for a signed-in rider, turning the usual problems into
/// error responses: no ledger configured (503), not signed in (401), a bad
/// body (400) or a refused wallet operation ([LedgerException]).
Future<Response> forSignedInRider(
  RequestContext context,
  Future<Response> Function(String riderId, LedgerService ledger) handle,
) async {
  final services = context.read<BackendServices>();
  final ledger = services.ledger;
  if (ledger == null) {
    return errorResponse(
      HttpStatus.serviceUnavailable,
      ApiErrorCode.serviceUnavailable,
      'The wallet is not configured on this server',
    );
  }

  final riderId = await services.authenticator.userId(context.request);
  if (riderId == null) {
    return errorResponse(
      HttpStatus.unauthorized,
      ApiErrorCode.unauthorized,
      'Sign in required',
      headers: {HttpHeaders.wwwAuthenticateHeader: 'Bearer'},
    );
  }

  try {
    return await handle(riderId, ledger);
  } on LedgerException catch (e) {
    return errorResponse(e.statusCode, e.code, e.message);
  } on FormatException catch (e) {
    return badRequest('Body is not valid JSON: ${e.message}');
  } on CheckedFromJsonException catch (e) {
    return badRequest('Invalid ${e.key}: ${e.message}');
  }
}

/// Reads a JSON object body.
Future<Map<String, dynamic>> jsonBody(Request request) async {
  final body = await request.json();
  if (body is! Map<String, dynamic>) {
    throw const FormatException('expected a JSON object');
  }
  return body;
}

/// The request's `Idempotency-Key`, or null if missing or malformed.
String? idempotencyKey(Request request) {
  final key = request.headers['idempotency-key']?.trim();
  if (key == null || key.isEmpty || key.length > 128) return null;
  return key;
}

Response missingIdempotencyKey() =>
    badRequest('An Idempotency-Key header (1-128 characters) is required');
