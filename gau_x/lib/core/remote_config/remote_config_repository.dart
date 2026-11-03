import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/failure.dart';
import '../domain/result.dart';
import '../network/api_client.dart';

/// The remote config document: the last copy fetched from the GauX API,
/// kept on the device so the app starts with it even when offline.
/// Built-in defaults apply until a document has ever been fetched.
class RemoteConfigRepository {
  RemoteConfigRepository({
    required SharedPreferences prefs,
    ApiClient? client,
    String? baseUrl,
  }) : _prefs = prefs,
       _client = client,
       _baseUrl = baseUrl;

  static const _bodyKey = 'remote_config_v1';
  static const _etagKey = 'remote_config_v1_etag';
  static const _notModified = 304;

  final SharedPreferences _prefs;
  final ApiClient? _client;
  final String? _baseUrl;

  /// The cached document, or defaults if there isn't a valid one.
  RemoteConfig cached() {
    final body = _prefs.getString(_bodyKey);
    if (body == null) return const RemoteConfig();
    try {
      return RemoteConfig.fromJson(jsonDecode(body) as Map<String, dynamic>);
    } on Object catch (e) {
      // A corrupt cache must never stop the app from starting
      debugPrint('Remote config: ignoring bad cached copy ($e)');
      return const RemoteConfig();
    }
  }

  /// Fetches the latest document, sending the cached ETag so an unchanged
  /// document costs an empty 304. Without an API configured this is a no-op
  /// that returns the cached copy.
  Future<Result<RemoteConfig>> refresh() async {
    final client = _client;
    final baseUrl = _baseUrl;
    if (client == null || baseUrl == null || baseUrl.isEmpty) {
      return Success(cached());
    }

    final etag = _prefs.getString(_etagKey);
    final result = await client.get(
      Uri.parse('$baseUrl/v1/config'),
      headers: {'If-None-Match': ?etag},
      alsoAccept: {_notModified},
    );

    switch (result) {
      case Err(:final failure):
        return Err(failure);
      case Success(value: final response)
          when response.statusCode == _notModified:
        return Success(cached());
      case Success(value: final response):
        final RemoteConfig config;
        try {
          config = RemoteConfig.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>,
          );
        } on Object catch (e) {
          return Err(ParsingFailure('Remote config: $e'));
        }
        await _prefs.setString(_bodyKey, response.body);
        // package:http lower-cases response header names
        final newEtag = response.headers['etag'];
        if (newEtag != null) await _prefs.setString(_etagKey, newEtag);
        return Success(config);
    }
  }
}
