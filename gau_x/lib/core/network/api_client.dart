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
    final result = await get(url, headers: headers);
    final http.Response response;
    switch (result) {
      case Err(:final failure):
        return Err(failure);
      case Success(:final value):
        response = value;
    }

    try {
      return Success(jsonDecode(response.body));
    } on FormatException catch (e) {
      return Err(ParsingFailure('Invalid JSON from $url: ${e.message}'));
    }
  }

  /// GETs [url] and returns the raw response. Statuses outside 2xx become a
  /// [ServerFailure], except those listed in [alsoAccept] (e.g. 304).
  Future<Result<http.Response>> get(
    Uri url, {
    Map<String, String> headers = const {},
    Set<int> alsoAccept = const {},
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

    final ok = response.statusCode >= 200 && response.statusCode < 300;
    if (!ok && !alsoAccept.contains(response.statusCode)) {
      return Err(
        ServerFailure(response.statusCode, 'HTTP ${response.statusCode}: $url'),
      );
    }
    return Success(response);
  }

  /// POSTs [body] as JSON and returns the decoded JSON response. Error
  /// statuses become a [ServerFailure] whose message includes the API's
  /// error code when there is one.
  Future<Result<Object?>> postJson(
    Uri url,
    Object body, {
    Map<String, String> headers = const {},
  }) async {
    final http.Response response;
    try {
      response = await _http
          .post(
            url,
            headers: {
              ..._defaultHeaders,
              'Content-Type': 'application/json',
              ...headers,
            },
            body: jsonEncode(body),
          )
          .timeout(timeout);
    } on TimeoutException {
      return Err(NetworkFailure('Timed out after $timeout: $url'));
    } on http.ClientException catch (e) {
      return Err(NetworkFailure('${e.message}: $url'));
    }

    final Object? json;
    try {
      json = response.body.isEmpty ? null : jsonDecode(response.body);
    } on FormatException catch (e) {
      return Err(ParsingFailure('Invalid JSON from $url: ${e.message}'));
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final code = json is Map<String, dynamic> ? json['code'] : null;
      return Err(
        ServerFailure(
          response.statusCode,
          'HTTP ${response.statusCode}${code == null ? '' : ' ($code)'}: $url',
          code: code is String ? code : null,
        ),
      );
    }
    return Success(json);
  }
}
