import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_contracts/gaux_contracts.dart';

Response errorResponse(
  int statusCode,
  String code,
  String message, {
  Map<String, Object> headers = const {},
}) => Response.json(
  statusCode: statusCode,
  body: ApiError(code: code, message: message).toJson(),
  headers: headers,
);

Response badRequest(String message) =>
    errorResponse(HttpStatus.badRequest, ApiErrorCode.badRequest, message);

Response methodNotAllowed() => errorResponse(
  HttpStatus.methodNotAllowed,
  ApiErrorCode.methodNotAllowed,
  'Only GET is supported',
);

Response upstreamUnavailable(String service) => errorResponse(
  HttpStatus.badGateway,
  ApiErrorCode.upstreamUnavailable,
  '$service is unavailable',
);
