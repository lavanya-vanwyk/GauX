import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/gold_card_model.dart';

/// Keeps the wallet in SharedPreferences as one JSON document.
///
/// Not secure storage: fine for the demo balance, replaced by a server-side
/// ledger with an encrypted local cache in Phase 3.
class GoldCardLocalDatasource {
  const GoldCardLocalDatasource(this._prefs);

  static const _key = 'gold_card_v1';

  // Format used by the hackathon build: a bare balance plus a list of
  // {route, cost, date} maps with free-text dates such as "Today, 08:15".
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

  /// Reads a wallet saved by the hackathon build, if there is one.
  ///
  /// Legacy dates can't be parsed, so every legacy entry gets [migratedAt]
  /// as its timestamp; descriptions and amounts are kept.
  GoldCardModel? readLegacy({required DateTime migratedAt}) {
    final balance = _prefs.getDouble(_legacyBalanceKey);
    if (balance == null) return null;

    final rawTrips = _prefs.getString(_legacyTripsKey);
    final trips = rawTrips == null
        ? const <dynamic>[]
        : jsonDecode(rawTrips) as List<dynamic>;

    return GoldCardModel(
      balance: balance,
      ledger: [
        for (final trip in trips.cast<Map<String, dynamic>>())
          LedgerEntryModel(
            description: trip['route'] as String,
            amount: (trip['cost'] as num).toDouble(),
            timestamp: migratedAt.toUtc(),
          ),
      ],
    );
  }

  Future<void> clearLegacy() async {
    await _prefs.remove(_legacyBalanceKey);
    await _prefs.remove(_legacyTripsKey);
  }
}
