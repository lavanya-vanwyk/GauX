import 'package:freezed_annotation/freezed_annotation.dart';

import 'fares.dart';
import 'geo_point.dart';

part 'wallet_contracts.freezed.dart';
part 'wallet_contracts.g.dart';

/// `POST /v1/quotes`: price a ride before it starts.
@freezed
abstract class QuoteRequest with _$QuoteRequest {
  const factory QuoteRequest({
    required GeoPoint from,
    required GeoPoint to,
    required RideKind rideType,
  }) = _QuoteRequest;

  factory QuoteRequest.fromJson(Map<String, dynamic> json) =>
      _$QuoteRequestFromJson(json);
}

/// A server-issued price. Charges refer to [id], so the client never names
/// the amount.
@freezed
abstract class QuoteResponse with _$QuoteResponse {
  const factory QuoteResponse({
    required String id,
    required RideKind rideType,
    required double distanceMeters,
    required int fareCents,
    required int etaMinutes,
    required DateTime expiresAt,
  }) = _QuoteResponse;

  factory QuoteResponse.fromJson(Map<String, dynamic> json) =>
      _$QuoteResponseFromJson(json);
}

/// `POST /v1/wallet/charges` (with an `Idempotency-Key` header).
@freezed
abstract class ChargeRequest with _$ChargeRequest {
  const factory ChargeRequest({
    required String quoteId,

    /// True for a cancelled ride: the server charges a partial fare for
    /// [distanceCoveredMeters] instead of the full quote.
    @Default(false) bool cancelled,
    @Default(0) double distanceCoveredMeters,
  }) = _ChargeRequest;

  factory ChargeRequest.fromJson(Map<String, dynamic> json) =>
      _$ChargeRequestFromJson(json);
}

/// `POST /v1/wallet/holds` and `POST /v1/wallet/holds/release` (with an
/// `Idempotency-Key` header). A hold reserves a quote's fare when the ride
/// is confirmed; a release returns it if the ride doesn't happen.
@freezed
abstract class HoldRequest with _$HoldRequest {
  const factory HoldRequest({required String quoteId}) = _HoldRequest;

  factory HoldRequest.fromJson(Map<String, dynamic> json) =>
      _$HoldRequestFromJson(json);
}

/// `POST /v1/wallet/topups` (with an `Idempotency-Key` header).
@freezed
abstract class TopUpRequest with _$TopUpRequest {
  const factory TopUpRequest({
    required int amountCents,
    required String paymentMethod,
  }) = _TopUpRequest;

  factory TopUpRequest.fromJson(Map<String, dynamic> json) =>
      _$TopUpRequestFromJson(json);
}

/// One movement in the rider's wallet. [amountCents] is negative for
/// charges and positive for top-ups and credits.
@freezed
abstract class WalletEntryDto with _$WalletEntryDto {
  const factory WalletEntryDto({
    required String id,
    required String kind,
    required String description,
    required int amountCents,
    required DateTime createdAt,
  }) = _WalletEntryDto;

  factory WalletEntryDto.fromJson(Map<String, dynamic> json) =>
      _$WalletEntryDtoFromJson(json);
}

/// `GET /v1/wallet`, and the body of successful charges and top-ups.
@freezed
abstract class WalletResponse with _$WalletResponse {
  const factory WalletResponse({
    /// Available to spend. Excludes [heldCents].
    required int balanceCents,

    /// Reserved for rides in progress; settled or returned when they end.
    @Default(0) int heldCents,
    @Default('ZAR') String currency,

    /// Newest first.
    required List<WalletEntryDto> entries,

    /// The entry a charge, hold or top-up created (or found, on a retry).
    /// Null when nothing touched the wallet directly, e.g. a ride settled
    /// exactly from its hold.
    WalletEntryDto? entry,

    /// Set by charges: what the rider paid for the quote, in cents. With a
    /// hold this differs from [entry], which is then the refund of any
    /// unused part.
    int? chargedCents,
  }) = _WalletResponse;

  factory WalletResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletResponseFromJson(json);
}
