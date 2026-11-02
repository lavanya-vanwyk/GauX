import 'dart:async';

import 'package:gaux_contracts/gaux_contracts.dart';

import '../../../../core/auth/access_token.dart';
import '../../../../core/domain/failure.dart';
import '../../../../core/domain/result.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/json_parsing.dart';

/// Wallet and pricing endpoints of the GauX API (`backend/routes/v1`).
///
/// Network failures are retried a few times. That's only safe because
/// every write carries an idempotency key, so the server applies it once.
class WalletApiDatasource {
  WalletApiDatasource({
    required ApiClient client,
    required String baseUrl,
    required AccessTokenSource accessToken,
    List<Duration> retryDelays = const [
      Duration(milliseconds: 300),
      Duration(seconds: 1),
    ],
  }) : _client = client,
       _baseUrl = baseUrl,
       _accessToken = accessToken,
       _retryDelays = retryDelays;

  final ApiClient _client;
  final String _baseUrl;
  final AccessTokenSource _accessToken;
  final List<Duration> _retryDelays;

  Future<Result<WalletResponse>> wallet() => _authorized(
    (headers) async => parseJson(
      await _client.getJson(_url('/v1/wallet'), headers: headers),
      (json) => WalletResponse.fromJson(json! as Map<String, dynamic>),
    ),
  );

  Future<Result<QuoteResponse>> createQuote(QuoteRequest request) =>
      _authorized(
        (headers) async => parseJson(
          await _client.postJson(
            _url('/v1/quotes'),
            request.toJson(),
            headers: headers,
          ),
          (json) => QuoteResponse.fromJson(json! as Map<String, dynamic>),
        ),
      );

  Future<Result<WalletResponse>> charge(
    ChargeRequest request, {
    required String idempotencyKey,
  }) => _authorized(
    (headers) async => parseJson(
      await _client.postJson(
        _url('/v1/wallet/charges'),
        request.toJson(),
        headers: {...headers, 'Idempotency-Key': idempotencyKey},
      ),
      (json) => WalletResponse.fromJson(json! as Map<String, dynamic>),
    ),
  );

  Future<Result<WalletResponse>> topUp(
    TopUpRequest request, {
    required String idempotencyKey,
  }) => _authorized(
    (headers) async => parseJson(
      await _client.postJson(
        _url('/v1/wallet/topups'),
        request.toJson(),
        headers: {...headers, 'Idempotency-Key': idempotencyKey},
      ),
      (json) => WalletResponse.fromJson(json! as Map<String, dynamic>),
    ),
  );

  Uri _url(String path) => Uri.parse('$_baseUrl$path');

  /// Adds the bearer token and retries on network failures.
  Future<Result<T>> _authorized<T>(
    Future<Result<T>> Function(Map<String, String> headers) call,
  ) async {
    final token = await _accessToken();
    if (token == null) {
      return const Err(
        ServerFailure(401, 'Not signed in', code: ApiErrorCode.unauthorized),
      );
    }
    final headers = {'Authorization': 'Bearer $token'};

    var result = await call(headers);
    for (final delay in _retryDelays) {
      if (result case Err(failure: NetworkFailure())) {
        await Future<void>.delayed(delay);
        result = await call(headers);
      } else {
        break;
      }
    }
    return result;
  }
}
