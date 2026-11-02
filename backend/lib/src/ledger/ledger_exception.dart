import 'dart:io';

import 'package:gaux_contracts/gaux_contracts.dart';

/// A wallet operation was refused. [code] is an [ApiErrorCode]; routes turn
/// this into an error response with [statusCode].
class LedgerException implements Exception {
  const LedgerException(this.statusCode, this.code, this.message);

  const LedgerException.insufficientFunds()
    : this(
        HttpStatus.paymentRequired,
        ApiErrorCode.insufficientFunds,
        'Wallet balance is too low',
      );

  const LedgerException.quoteNotFound()
    : this(HttpStatus.notFound, ApiErrorCode.notFound, 'Quote not found');

  const LedgerException.quoteExpired()
    : this(
        HttpStatus.gone,
        ApiErrorCode.quoteExpired,
        'Quote has expired; request a new one',
      );

  const LedgerException.idempotencyConflict(String message)
    : this(HttpStatus.conflict, ApiErrorCode.idempotencyConflict, message);

  final int statusCode;
  final String code;
  final String message;

  @override
  String toString() => 'LedgerException($code): $message';
}
