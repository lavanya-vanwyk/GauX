import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/failure.dart';
import '../domain/result.dart';

/// Thin wrapper over [http.Client] that applies a timeout and turns every
/// error into a [Failure]. All remote datasources go through this, so
/// retries, auth headers and logging can be added in one place later.
class ApiClient {
  ApiClient({
    required http.Client httpClient,
    this.timeout = const Duration(seconds: 10),
    Map<String, String> defaultHeaders = const {},
  }) : _http = httpClient,
       _defaultHeaders = defaultHeaders;

  final http.Client _http;
  final Map<String, String> _defaultHeaders;
  final Duration timeout;

  /// GETs [url] and returns the decoded JSON body. [headers] are added to
  /// the client's default headers.
  Future<Result<Object?>> getJson(
    Uri url, {
    Map<String, String> headers = const {},
  }) async {
    final http.Response response;
    try {
      response = await _http
          .get(url, headers: {..._defaultHeaders, ...headers})
          .timeout(timeout);
    } on TimeoutException {
      return Err(NetworkFailure('Timed out after $timeout: $url'));
    } on http.ClientException catch (e) {
      // Also covers socket errors: the IO client wraps them in this type.
      return Err(NetworkFailure('${e.message}: $url'));
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      return Err(
        ServerFailure(response.statusCode, 'HTTP ${response.statusCode}: $url'),
      );
    }

    try {
      return Success(jsonDecode(response.body));
    } on FormatException catch (e) {
      return Err(ParsingFailure('Invalid JSON from $url: ${e.message}'));
    }
  }
}
