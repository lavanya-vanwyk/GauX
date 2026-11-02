import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:gaux_contracts/gaux_contracts.dart';

import '../../../../core/domain/result.dart';
import '../../../../core/storage/secure_cache.dart';
import '../../domain/entities/gold_card.dart';
import '../../domain/entities/ledger_entry.dart';
import '../../domain/repositories/gold_card_repository.dart';
import '../datasources/wallet_api_datasource.dart';

/// The wallet as held by the GauX server ledger. The last copy is kept in
/// secure storage so the balance shows while offline; it's display-only,
/// since every change goes through the server.
class ApiGoldCardRepository implements GoldCardRepository {
  ApiGoldCardRepository({
    required WalletApiDatasource api,
    required SecureCache cache,
  }) : _api = api,
       _cache = cache;

  static const _cacheKey = 'wallet_cache_v1';

  final WalletApiDatasource _api;
  final SecureCache _cache;
  final _changes = StreamController<GoldCard>.broadcast();

  GoldCard? _current;

  @override
  Stream<GoldCard> watch() async* {
    final current = _current ?? await _readCache();
    if (current != null) yield current;
    yield* _changes.stream;
  }

  @override
  Future<Result<GoldCard>> load() async => _applyResult(await _api.wallet());

  @override
  Future<Result<GoldCard>> topUp({
    required int amountCents,
    required String paymentMethod,
    required String idempotencyKey,
  }) async => _applyResult(
    await _api.topUp(
      TopUpRequest(amountCents: amountCents, paymentMethod: paymentMethod),
      idempotencyKey: idempotencyKey,
    ),
  );

  /// Publishes a wallet the server returned (e.g. after a ride charge).
  Future<GoldCard> apply(WalletResponse response) async {
    final card = _toEntity(response);
    _current = card;
    _changes.add(card);
    await _cache.write(_cacheKey, jsonEncode(response.toJson()));
    return card;
  }

  Future<Result<GoldCard>> _applyResult(Result<WalletResponse> result) async {
    switch (result) {
      case Success(:final value):
        return Success(await apply(value));
      case Err(:final failure):
        return Err(failure);
    }
  }

  Future<GoldCard?> _readCache() async {
    final raw = await _cache.read(_cacheKey);
    if (raw == null) return null;
    try {
      return _toEntity(
        WalletResponse.fromJson(jsonDecode(raw) as Map<String, dynamic>),
      );
    } on Object catch (e) {
      debugPrint('Wallet: ignoring unreadable cached copy ($e)');
      return null;
    }
  }

  static GoldCard _toEntity(WalletResponse response) => GoldCard(
    balanceCents: response.balanceCents,
    ledger: [
      for (final entry in response.entries)
        LedgerEntry(
          description: entry.description,
          amountCents: entry.amountCents,
          timestamp: entry.createdAt.toLocal(),
        ),
    ],
  );
}
