import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_backend/gaux_backend.dart';
import 'package:gaux_contracts/gaux_contracts.dart';

/// Rate-limits every `/v1` endpoint per client.
Handler middleware(Handler handler) {
  return (context) async {
    final limiter = context.read<BackendServices>().rateLimiter;
    final client = clientKey(context.request);
    if (!limiter.tryAcquire(client)) {
      return errorResponse(
        HttpStatus.tooManyRequests,
        ApiErrorCode.rateLimited,
        'Too many requests',
        headers: {
          HttpHeaders.retryAfterHeader: '${limiter.retryAfterSeconds(client)}',
        },
      );
    }
    return handler(context);
  };
}

/// Identifies the caller. Behind a load balancer the real address is the
/// first entry of `X-Forwarded-For`; only trust it when the server is
/// deployed behind one.
String clientKey(Request request) {
  final forwarded = request.headers['x-forwarded-for'];
  if (forwarded != null && forwarded.isNotEmpty) {
    return forwarded.split(',').first.trim();
  }
  return request.connectionInfo.remoteAddress.address;
}
