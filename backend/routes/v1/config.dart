import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_backend/gaux_backend.dart';

/// `GET /v1/config`. Supports `If-None-Match`, so clients that already have
/// the current document get an empty 304.
Response onRequest(RequestContext context) {
  if (context.request.method != HttpMethod.get) return methodNotAllowed();

  final source = context.read<BackendServices>().remoteConfig;
  final headers = {
    HttpHeaders.etagHeader: source.etag,
    // Clients revalidate on every launch; proxies may cache briefly
    HttpHeaders.cacheControlHeader: 'public, max-age=60, must-revalidate',
  };

  if (context.request.headers['if-none-match'] == source.etag) {
    return Response(statusCode: HttpStatus.notModified, headers: headers);
  }
  return Response(
    body: source.body,
    headers: {
      ...headers,
      HttpHeaders.contentTypeHeader: ContentType.json.value,
    },
  );
}
