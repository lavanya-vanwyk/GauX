import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';
part 'api_error.g.dart';

/// Body of every non-2xx response from the GauX API.
@freezed
abstract class ApiError with _$ApiError {
  const factory ApiError({
    /// Stable machine-readable reason; see [ApiErrorCode].
    required String code,

    /// Developer-facing detail. Not for display to riders.
    required String message,
  }) = _ApiError;

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
}

abstract final class ApiErrorCode {
  static const badRequest = 'bad_request';
  static const notFound = 'not_found';
  static const rateLimited = 'rate_limited';
  static const upstreamUnavailable = 'upstream_unavailable';
  static const methodNotAllowed = 'method_not_allowed';
  static const unauthorized = 'unauthorized';

  /// A feature the server isn't configured for (e.g. no wallet database).
  static const serviceUnavailable = 'service_unavailable';

  /// Outside the GauX service area, or not from a GauX station.
  static const outsideServiceArea = 'outside_service_area';
  static const insufficientFunds = 'insufficient_funds';
  static const quoteExpired = 'quote_expired';

  /// The Idempotency-Key was already used for a different request.
  static const idempotencyConflict = 'idempotency_conflict';
}
