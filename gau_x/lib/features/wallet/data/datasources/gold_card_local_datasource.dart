import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/gold_card_model.dart';

/// Keeps the on-device wallet in SharedPreferences as one JSON document.
///
/// Only for builds without the GauX API. Not tamper-proof; the server-side
/// ledger is the real wallet.
class GoldCardLocalDatasource {
  const GoldCardLocalDatasource(this._prefs);

  static const _key = 'gold_card_v2';

  // Phase 1 format: same document, but amounts in rand (doubles)
  static const _v1Key = 'gold_card_v1';

  // Hackathon format: a bare balance plus {route, cost, date} maps with
  // free-text dates such as "Today, 08:15", amounts in rand
  static const _legacyBalanceKey = 'wallet_balance';
  static const _legacyTripsKey = 'recent_trips';

  final SharedPreferences _prefs;

  GoldCardModel? read() {
    final raw = _prefs.getString(_key);
    if (raw == null) return null;
    return GoldCardModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> write(GoldCardModel card) =>
      _prefs.setString(_key, jsonEncode(card.toJson()));

  /// Reads a wallet saved by an older build, if there is one, converting
  /// rand to cents. Hackathon entries have unparseable dates, so they get
  /// [migratedAt]; descriptions and amounts are kept.
  GoldCardModel? readOlderFormat({required DateTime migratedAt}) {
    if (_prefs.getString(_v1Key) case final raw?) {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return GoldCardModel(
        balanceCents: _cents(json['balance']),
        ledger: [
          for (final e
              in (json['ledger'] as List<dynamic>? ?? const [])
                  .cast<Map<String, dynamic>>())
            LedgerEntryModel(
              description: e['description'] as String,
              amountCents: _cents(e['amount']),
              timestamp: DateTime.parse(e['timestamp'] as String),
            ),
        ],
      );
    }

    final balance = _prefs.getDouble(_legacyBalanceKey);
    if (balance == null) return null;
    final rawTrips = _prefs.getString(_legacyTripsKey);
    final trips = rawTrips == null
        ? const <dynamic>[]
        : jsonDecode(rawTrips) as List<dynamic>;
    return GoldCardModel(
      balanceCents: _cents(balance),
      ledger: [
        for (final trip in trips.cast<Map<String, dynamic>>())
          LedgerEntryModel(
            description: trip['route'] as String,
            amountCents: _cents(trip['cost']),
            timestamp: migratedAt.toUtc(),
          ),
      ],
    );
  }

  Future<void> clearOlderFormats() async {
    await _prefs.remove(_v1Key);
    await _prefs.remove(_legacyBalanceKey);
    await _prefs.remove(_legacyTripsKey);
  }

  static int _cents(Object? rand) => ((rand as num) * 100).round();
}
