import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:gaux_contracts/gaux_contracts.dart';

/// The remote config document and its ETag.
class RemoteConfigSource {
  RemoteConfigSource(this.config)
    : body = jsonEncode(config.toJson()),
      etag = _etagFor(jsonEncode(config.toJson()));

  /// Reads the document from [path], or serves defaults when [path] is null.
  ///
  /// Read once at startup: restart (or redeploy) the server to publish a
  /// change. A database-backed source can replace this later.
  factory RemoteConfigSource.load(String? path) {
    if (path == null) return RemoteConfigSource(const RemoteConfig());
    final json = jsonDecode(File(path).readAsStringSync());
    return RemoteConfigSource(
      RemoteConfig.fromJson(json as Map<String, dynamic>),
    );
  }

  final RemoteConfig config;

  /// The JSON served to clients.
  final String body;

  /// Strong ETag, so clients can revalidate with `If-None-Match` and get a
  /// 304 instead of the whole document.
  final String etag;

  static String _etagFor(String body) =>
      '"${sha256.convert(utf8.encode(body)).toString().substring(0, 16)}"';
}
