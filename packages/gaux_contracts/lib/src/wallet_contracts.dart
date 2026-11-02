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

/// `POST /v1/wallet/top-ups` (with an `Idempotency-Key` header).
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
    required int balanceCents,
    @Default('ZAR') String currency,

    /// Newest first.
    required List<WalletEntryDto> entries,

    /// The entry a charge or top-up created (or found, on a retry).
    WalletEntryDto? entry,
  }) = _WalletResponse;

  factory WalletResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletResponseFromJson(json);
}
