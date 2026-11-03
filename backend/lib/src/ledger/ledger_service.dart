import 'dart:convert';
import 'dart:io';

import 'package:gaux_backend/src/ledger/ledger_exception.dart';
import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:postgres/postgres.dart';

/// The rider wallet, backed by the immutable double-entry ledger in the
/// `gaux` schema (see `db/migrations.dart`).
///
/// Every operation that moves money runs in one transaction that first
/// locks the rider's wallet row (`SELECT ... FOR UPDATE`). Operations on the
/// same wallet therefore run one at a time: two simultaneous charges can't
/// both spend the same balance, and a retried request finds the entry the
/// first attempt created. The database independently rejects overdrafts,
/// unbalanced entries and any edit to existing entries.
class LedgerService {
  LedgerService(
    this._db, {
    this.openingBalanceCents = 35000,
    this.quoteValidity = const Duration(hours: 6),
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final Pool<void> _db;

  /// Promotional credit given to every new wallet (R350 for the demo).
  final int openingBalanceCents;

  /// How long a quote can be charged after it was issued.
  final Duration quoteValidity;
  final DateTime Function() _clock;

  static const _recentEntries = 20;

  static final _uuid = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
    caseSensitive: false,
  );

  /// The rider's balance and recent entries. Opens the wallet on first use.
  Future<WalletResponse> wallet(String ownerId) => _db.runTx((tx) async {
    final wallet = await _lockOpenWallet(tx, ownerId);
    return _walletResponse(tx, wallet);
  });

  /// Reserves a quote's fare: moves it from the wallet into held funds, so
  /// it can't be spent elsewhere while the ride is in progress. Charging the
  /// quote later settles from the hold. Safe to retry with the same
  /// [idempotencyKey].
  Future<WalletResponse> placeHold(
    String ownerId,
    HoldRequest request, {
    required String idempotencyKey,
  }) => _db.runTx((tx) async {
    var wallet = await _lockOpenWallet(tx, ownerId);

    final previous = await _entryByKey(tx, ownerId, idempotencyKey);
    if (previous != null) {
      if (previous.kind != 'hold' || previous.quoteId != request.quoteId) {
        throw const LedgerException.idempotencyConflict(
          'Idempotency-Key was used for a different request',
        );
      }
      return _walletResponse(tx, wallet, entryId: previous.id);
    }

    final quote = await _quote(tx, ownerId, request.quoteId);
    if (!_clock().toUtc().isBefore(quote.expiresAt)) {
      throw const LedgerException.quoteExpired();
    }
    if (await _quoteHasEntry(tx, quote.id)) {
      throw const LedgerException.idempotencyConflict(
        'This quote has already been held, charged or released',
      );
    }
    if (wallet.balanceCents < quote.fareCents) {
      throw const LedgerException.insufficientFunds();
    }

    final entryId = await _post(
      tx,
      ownerId: ownerId,
      idempotencyKey: idempotencyKey,
      kind: 'hold',
      description: _rideName(quote.rideType),
      quoteId: quote.id,
      legs: [
        (account: wallet.id, cents: -quote.fareCents),
        (
          account: await _systemAccount(tx, 'rider_holds'),
          cents: quote.fareCents,
        ),
      ],
    );
    await tx.execute(
      Sql.named('''
        INSERT INTO gaux.holds (owner_id, quote_id, amount_cents, hold_entry_id)
        VALUES (@owner, @quote, @amount, @entry)'''),
      parameters: {
        'owner': ownerId,
        'quote': TypedValue(Type.uuid, quote.id),
        'amount': quote.fareCents,
        'entry': TypedValue(Type.uuid, entryId),
      },
    );
    wallet = await _lockWallet(tx, ownerId);
    return _walletResponse(tx, wallet, entryId: entryId);
  });

  /// Returns a hold's money to the wallet because the ride didn't happen.
  /// Releasing a quote with no open hold does nothing. Safe to retry.
  Future<WalletResponse> releaseHold(
    String ownerId,
    HoldRequest request, {
    required String idempotencyKey,
  }) => _db.runTx((tx) async {
    final wallet = await _lockOpenWallet(tx, ownerId);
    final previous = await _entryByKey(tx, ownerId, idempotencyKey);
    if (previous != null) {
      if (previous.quoteId != request.quoteId) {
        throw const LedgerException.idempotencyConflict(
          'Idempotency-Key was used for a different request',
        );
      }
      return _walletResponse(tx, wallet, entryId: previous.id);
    }
    if (!_uuid.hasMatch(request.quoteId)) {
      throw const LedgerException.quoteNotFound();
    }

    final hold = await _activeHold(tx, ownerId, request.quoteId);
    if (hold == null) return _walletResponse(tx, wallet);
    final entryId = await _closeHold(
      tx,
      hold,
      wallet: wallet,
      ownerId: ownerId,
      idempotencyKey: idempotencyKey,
      feeCents: 0,
      description: 'Released: ride not taken',
    );
    return _walletResponse(
      tx,
      await _lockWallet(tx, ownerId),
      entryId: entryId,
    );
  });

  /// Releases every hold whose quote has expired (rides that were confirmed
  /// but never charged, e.g. the app was closed). Run periodically; each
  /// rider is also swept whenever they next use their wallet. Returns the
  /// number released.
  Future<int> releaseExpiredHolds() async {
    final owners = await _db.execute(
      Sql.named('''
        SELECT DISTINCT h.owner_id FROM gaux.holds h
          JOIN gaux.quotes q ON q.id = h.quote_id
         WHERE h.status = 'active' AND q.expires_at <= @now'''),
      parameters: {'now': _clock().toUtc()},
    );
    var released = 0;
    for (final row in owners) {
      final owner = row[0]! as String;
      released += await _db.runTx((tx) async {
        await _lockWallet(tx, owner);
        return _releaseExpired(tx, owner);
      });
    }
    return released;
  }

  /// Prices a ride and records the quote so it can be charged later.
  Future<QuoteResponse> createQuote(
    String ownerId, {
    required RideKind rideType,
    required double distanceMeters,
    required PricingConfig pricing,
  }) async {
    final fare = Fares.fareCents(pricing, rideType, distanceMeters);
    final expiresAt = _clock().toUtc().add(quoteValidity);
    final rows = await _db.execute(
      Sql.named('''
        INSERT INTO gaux.quotes
          (owner_id, ride_type, distance_meters, fare_cents, pricing, expires_at)
        VALUES (@owner, @type, @distance, @fare, @pricing, @expires)
        RETURNING id'''),
      parameters: {
        'owner': ownerId,
        'type': rideType.name,
        'distance': distanceMeters,
        'fare': fare,
        'pricing': TypedValue(Type.jsonb, pricing.toJson()),
        'expires': expiresAt,
      },
    );
    return QuoteResponse(
      id: rows.single[0]! as String,
      rideType: rideType,
      distanceMeters: distanceMeters,
      fareCents: fare,
      etaMinutes: Fares.etaMinutes(pricing, distanceMeters),
      expiresAt: expiresAt,
    );
  }

  /// Charges a quote: the full fare, or a partial fare when [request] is a
  /// cancellation. Safe to retry with the same [idempotencyKey].
  ///
  /// Throws [LedgerException] when the quote is unknown, expired, already
  /// charged under another key, or the balance is too low.
  Future<WalletResponse> charge(
    String ownerId,
    ChargeRequest request, {
    required String idempotencyKey,
  }) => _db.runTx((tx) async {
    final wallet = await _lockOpenWallet(tx, ownerId);

    final previous = await _entryByKey(tx, ownerId, idempotencyKey);
    if (previous != null) {
      if (previous.quoteId != request.quoteId) {
        throw const LedgerException.idempotencyConflict(
          'Idempotency-Key was used for a different charge',
        );
      }
      return _walletResponse(
        tx,
        wallet,
        entryId: previous.id,
        chargedCents: await _chargedFor(tx, previous.id),
      );
    }

    final quote = await _quote(tx, ownerId, request.quoteId);
    if (!_clock().toUtc().isBefore(quote.expiresAt)) {
      throw const LedgerException.quoteExpired();
    }
    final alreadyCharged = await tx.execute(
      Sql.named('''
        SELECT 1 FROM gaux.journal_entries
         WHERE quote_id = @q AND kind IN ('ride_charge', 'cancellation_fee',
                                          'hold_release')'''),
      parameters: {'q': TypedValue(Type.uuid, quote.id)},
    );
    if (alreadyCharged.isNotEmpty) {
      throw const LedgerException.idempotencyConflict(
        'This quote has already been charged',
      );
    }

    final amount = request.cancelled
        ? Fares.cancellationCents(
            quote.pricing,
            quote.rideType,
            plannedMeters: quote.distanceMeters,
            coveredMeters: request.distanceCoveredMeters,
          )
        : quote.fareCents;
    final name = _rideName(quote.rideType);

    // With a hold, settle from it: the fee to revenue, the rest back
    final hold = await _activeHold(tx, ownerId, quote.id);
    if (hold != null) {
      final entryId = await _closeHold(
        tx,
        hold,
        wallet: wallet,
        ownerId: ownerId,
        idempotencyKey: idempotencyKey,
        feeCents: amount,
        description: request.cancelled ? 'Canceled: $name' : name,
        feeKind: request.cancelled ? 'cancellation_fee' : 'ride_charge',
      );
      return _walletResponse(
        tx,
        await _lockWallet(tx, ownerId),
        entryId: entryId,
        chargedCents: amount,
      );
    }

    if (amount == 0) return _walletResponse(tx, wallet, chargedCents: 0);
    if (wallet.balanceCents < amount) {
      throw const LedgerException.insufficientFunds();
    }

    final entryId = await _post(
      tx,
      ownerId: ownerId,
      idempotencyKey: idempotencyKey,
      kind: request.cancelled ? 'cancellation_fee' : 'ride_charge',
      description: request.cancelled ? 'Canceled: $name' : name,
      quoteId: quote.id,
      legs: [
        (account: wallet.id, cents: -amount),
        (account: await _systemAccount(tx, 'platform_revenue'), cents: amount),
      ],
    );
    return _walletResponse(
      tx,
      await _lockWallet(tx, ownerId),
      entryId: entryId,
      chargedCents: amount,
    );
  });

  /// Adds funds from [TopUpRequest.paymentMethod]. Safe to retry with the
  /// same [idempotencyKey].
  ///
  /// Simulated: no payment provider confirms the money. Only enable this
  /// endpoint where that's acceptable (see `SIMULATED_TOPUPS`).
  Future<WalletResponse> topUp(
    String ownerId,
    TopUpRequest request, {
    required String idempotencyKey,
  }) => _db.runTx((tx) async {
    if (request.amountCents <= 0) {
      throw const LedgerException(
        HttpStatus.badRequest,
        ApiErrorCode.badRequest,
        'amountCents must be > 0',
      );
    }
    final wallet = await _lockOpenWallet(tx, ownerId);

    final previous = await _entryByKey(tx, ownerId, idempotencyKey);
    if (previous != null) {
      if (previous.kind != 'top_up' ||
          previous.walletCents != request.amountCents) {
        throw const LedgerException.idempotencyConflict(
          'Idempotency-Key was used for a different request',
        );
      }
      return _walletResponse(tx, wallet, entryId: previous.id);
    }

    final entryId = await _post(
      tx,
      ownerId: ownerId,
      idempotencyKey: idempotencyKey,
      kind: 'top_up',
      description: 'Top Up: ${request.paymentMethod}',
      legs: [
        (
          account: await _systemAccount(tx, 'topup_clearing'),
          cents: -request.amountCents,
        ),
        (account: wallet.id, cents: request.amountCents),
      ],
    );
    return _walletResponse(
      tx,
      await _lockWallet(tx, ownerId),
      entryId: entryId,
    );
  });

  /// Undoes [entryId] with an equal and opposite entry. The original stays
  /// in the ledger. For support and operations, not riders.
  ///
  /// Refused (by the database) if it would overdraw a wallet, e.g.
  /// reversing a top-up that has already been spent.
  Future<String> reverse(String entryId, {required String reason}) =>
      _db.runTx((tx) async {
        final original = await tx.execute(
          Sql.named(
            'SELECT owner_id, kind FROM gaux.journal_entries WHERE id = @id',
          ),
          parameters: {'id': entryId},
        );
        if (original.isEmpty) {
          throw const LedgerException(
            HttpStatus.notFound,
            ApiErrorCode.notFound,
            'Entry not found',
          );
        }
        final ownerId = original.single[0]! as String;
        // Holds are closed by settling or releasing them, which keeps the
        // holds table in step with the ledger
        if (original.single[1] case 'hold' || 'hold_release') {
          throw const LedgerException(
            HttpStatus.conflict,
            ApiErrorCode.idempotencyConflict,
            'Release or settle a hold instead of reversing it',
          );
        }
        await _lockWallet(tx, ownerId);

        final legs = await tx.execute(
          Sql.named(
            'SELECT account_id, amount_cents FROM gaux.postings '
            'WHERE entry_id = @id',
          ),
          parameters: {'id': entryId},
        );
        return _post(
          tx,
          ownerId: ownerId,
          idempotencyKey: 'reversal:$entryId',
          kind: 'reversal',
          description: 'Reversal: $reason',
          reversesEntryId: entryId,
          legs: [
            for (final row in legs)
              (account: row[0]! as String, cents: -(row[1]! as int)),
          ],
        );
      });

  // --- internals -----------------------------------------------------------

  /// Locks the wallet and releases any of the rider's holds that expired.
  Future<_Wallet> _lockOpenWallet(TxSession tx, String ownerId) async {
    await _lockWallet(tx, ownerId);
    await _releaseExpired(tx, ownerId);
    // Re-read: releasing changes the balance
    return _lockWallet(tx, ownerId);
  }

  /// Releases [ownerId]'s expired holds. The wallet must already be locked.
  Future<int> _releaseExpired(TxSession tx, String ownerId) async {
    final expired = await tx.execute(
      Sql.named('''
        SELECT h.id, h.quote_id, h.amount_cents FROM gaux.holds h
          JOIN gaux.quotes q ON q.id = h.quote_id
         WHERE h.owner_id = @owner AND h.status = 'active'
           AND q.expires_at <= @now
           FOR UPDATE OF h'''),
      parameters: {'owner': ownerId, 'now': _clock().toUtc()},
    );
    if (expired.isEmpty) return 0;
    final wallet = await _lockWallet(tx, ownerId);
    for (final row in expired) {
      await _closeHold(
        tx,
        (
          id: row[0]! as String,
          quoteId: row[1]! as String,
          amountCents: row[2]! as int,
        ),
        wallet: wallet,
        ownerId: ownerId,
        idempotencyKey: 'expire:${row[1]}',
        feeCents: 0,
        description: 'Released: quote expired',
      );
    }
    return expired.length;
  }

  Future<_Hold?> _activeHold(
    TxSession tx,
    String ownerId,
    String quoteId,
  ) async {
    final rows = await tx.execute(
      Sql.named('''
        SELECT id, quote_id, amount_cents FROM gaux.holds
         WHERE owner_id = @owner AND quote_id = @quote AND status = 'active'
           FOR UPDATE'''),
      parameters: {'owner': ownerId, 'quote': TypedValue(Type.uuid, quoteId)},
    );
    if (rows.isEmpty) return null;
    final row = rows.single;
    return (
      id: row[0]! as String,
      quoteId: row[1]! as String,
      amountCents: row[2]! as int,
    );
  }

  /// Settles or releases [hold] in one balanced entry: [feeCents] to
  /// revenue and the remainder back to the wallet. A zero fee releases it.
  Future<String> _closeHold(
    TxSession tx,
    _Hold hold, {
    required _Wallet wallet,
    required String ownerId,
    required String idempotencyKey,
    required int feeCents,
    required String description,
    String feeKind = 'ride_charge',
  }) async {
    assert(feeCents >= 0 && feeCents <= hold.amountCents, 'fee within hold');
    final returned = hold.amountCents - feeCents;
    final entryId = await _post(
      tx,
      ownerId: ownerId,
      idempotencyKey: idempotencyKey,
      kind: feeCents == 0 ? 'hold_release' : feeKind,
      description: description,
      quoteId: hold.quoteId,
      legs: [
        (
          account: await _systemAccount(tx, 'rider_holds'),
          cents: -hold.amountCents,
        ),
        if (feeCents > 0)
          (
            account: await _systemAccount(tx, 'platform_revenue'),
            cents: feeCents,
          ),
        if (returned > 0) (account: wallet.id, cents: returned),
      ],
    );
    await tx.execute(
      Sql.named('''
        UPDATE gaux.holds
           SET status = @status, closing_entry_id = @entry, closed_at = now()
         WHERE id = @id'''),
      parameters: {
        'status': feeCents == 0 ? 'released' : 'settled',
        'entry': TypedValue(Type.uuid, entryId),
        'id': TypedValue(Type.uuid, hold.id),
      },
    );
    return entryId;
  }

  /// What revenue received from charge entry [entryId], for retries.
  Future<int> _chargedFor(TxSession tx, String entryId) async {
    final rows = await tx.execute(
      Sql.named('''
        SELECT coalesce(sum(p.amount_cents), 0)::bigint FROM gaux.postings p
          JOIN gaux.accounts a ON a.id = p.account_id
         WHERE p.entry_id = @entry AND a.kind = 'platform_revenue' '''),
      parameters: {'entry': TypedValue(Type.uuid, entryId)},
    );
    return rows.single[0]! as int;
  }

  Future<bool> _quoteHasEntry(TxSession tx, String quoteId) async {
    final rows = await tx.execute(
      Sql.named('SELECT 1 FROM gaux.journal_entries WHERE quote_id = @q'),
      parameters: {'q': TypedValue(Type.uuid, quoteId)},
    );
    return rows.isNotEmpty;
  }

  static String _rideName(RideKind kind) =>
      kind == RideKind.pool ? 'GauX Pool' : 'GauX Private';

  /// Opens the wallet if needed (with its opening balance), then locks it
  /// for the rest of the transaction.
  Future<_Wallet> _lockWallet(TxSession tx, String ownerId) async {
    final created = await tx.execute(
      Sql.named('''
        INSERT INTO gaux.accounts (owner_id, kind) VALUES (@owner, 'rider_wallet')
        ON CONFLICT (owner_id, currency) WHERE kind = 'rider_wallet' DO NOTHING
        RETURNING id'''),
      parameters: {'owner': ownerId},
    );
    if (created.isNotEmpty && openingBalanceCents > 0) {
      await _post(
        tx,
        ownerId: ownerId,
        idempotencyKey: 'opening-balance',
        kind: 'opening_balance',
        description: 'Welcome credit',
        legs: [
          (
            account: await _systemAccount(tx, 'promotions'),
            cents: -openingBalanceCents,
          ),
          (account: created.single[0]! as String, cents: openingBalanceCents),
        ],
      );
    }

    final row = (await tx.execute(
      Sql.named('''
        SELECT id, balance_cents FROM gaux.accounts
         WHERE owner_id = @owner AND kind = 'rider_wallet'
           FOR UPDATE'''),
      parameters: {'owner': ownerId},
    )).single;
    return (id: row[0]! as String, balanceCents: row[1]! as int);
  }

  Future<String> _systemAccount(TxSession tx, String kind) async {
    final rows = await tx.execute(
      Sql.named(
        'SELECT id FROM gaux.accounts WHERE kind = @kind AND owner_id IS NULL',
      ),
      parameters: {'kind': kind},
    );
    return rows.single[0]! as String;
  }

  /// Writes one balanced journal entry. The database checks the balance at
  /// commit.
  Future<String> _post(
    TxSession tx, {
    required String ownerId,
    required String idempotencyKey,
    required String kind,
    required String description,
    required List<({String account, int cents})> legs,
    String? quoteId,
    String? reversesEntryId,
  }) async {
    final entry = await tx.execute(
      Sql.named('''
        INSERT INTO gaux.journal_entries
          (owner_id, idempotency_key, kind, description, quote_id,
           reverses_entry_id)
        VALUES (@owner, @key, @kind, @description, @quote, @reverses)
        RETURNING id'''),
      parameters: {
        'owner': ownerId,
        'key': idempotencyKey,
        'kind': kind,
        'description': description,
        'quote': TypedValue(Type.uuid, quoteId),
        'reverses': TypedValue(Type.uuid, reversesEntryId),
      },
    );
    final entryId = entry.single[0]! as String;
    for (final leg in legs) {
      await tx.execute(
        Sql.named('''
          INSERT INTO gaux.postings (entry_id, account_id, amount_cents)
          VALUES (@entry, @account, @cents)'''),
        parameters: {
          'entry': entryId,
          'account': leg.account,
          'cents': leg.cents,
        },
      );
    }
    return entryId;
  }

  Future<_PreviousEntry?> _entryByKey(
    TxSession tx,
    String ownerId,
    String idempotencyKey,
  ) async {
    final rows = await tx.execute(
      Sql.named('''
        SELECT e.id, e.kind, e.quote_id,
               (SELECT p.amount_cents FROM gaux.postings p
                  JOIN gaux.accounts a ON a.id = p.account_id
                 WHERE p.entry_id = e.id AND a.kind = 'rider_wallet')
          FROM gaux.journal_entries e
         WHERE e.owner_id = @owner AND e.idempotency_key = @key'''),
      parameters: {'owner': ownerId, 'key': idempotencyKey},
    );
    if (rows.isEmpty) return null;
    final row = rows.single;
    return (
      id: row[0]! as String,
      kind: row[1]! as String,
      quoteId: row[2] as String?,
      walletCents: row[3] as int?,
    );
  }

  Future<_Quote> _quote(TxSession tx, String ownerId, String quoteId) async {
    if (!_uuid.hasMatch(quoteId)) throw const LedgerException.quoteNotFound();
    final rows = await tx.execute(
      Sql.named('''
        SELECT id, ride_type, distance_meters, fare_cents, pricing, expires_at
          FROM gaux.quotes WHERE id = @id AND owner_id = @owner'''),
      parameters: {'id': TypedValue(Type.uuid, quoteId), 'owner': ownerId},
    );
    if (rows.isEmpty) throw const LedgerException.quoteNotFound();
    final row = rows.single;
    return (
      id: row[0]! as String,
      rideType: RideKind.values.byName(row[1]! as String),
      distanceMeters: row[2]! as double,
      fareCents: row[3]! as int,
      pricing: PricingConfig.fromJson(_json(row[4])),
      expiresAt: row[5]! as DateTime,
    );
  }

  Future<WalletResponse> _walletResponse(
    TxSession tx,
    _Wallet wallet, {
    String? entryId,
    int? chargedCents,
  }) async {
    final rows = await tx.execute(
      Sql.named('''
        SELECT e.id, e.kind, e.description, p.amount_cents, e.created_at
          FROM gaux.postings p
          JOIN gaux.journal_entries e ON e.id = p.entry_id
         WHERE p.account_id = @wallet
         ORDER BY p.id DESC
         LIMIT $_recentEntries'''),
      parameters: {'wallet': wallet.id},
    );
    final entries = [
      for (final row in rows)
        WalletEntryDto(
          id: row[0]! as String,
          kind: row[1]! as String,
          description: row[2]! as String,
          amountCents: row[3]! as int,
          createdAt: (row[4]! as DateTime).toUtc(),
        ),
    ];

    WalletEntryDto? entry;
    if (entryId != null) {
      entry = entries.where((e) => e.id == entryId).firstOrNull;
    }
    final held = await tx.execute(
      Sql.named('''
        SELECT coalesce(sum(h.amount_cents), 0)::bigint
          FROM gaux.holds h
          JOIN gaux.accounts a ON a.owner_id = h.owner_id
         WHERE a.id = @wallet AND h.status = 'active' '''),
      parameters: {'wallet': wallet.id},
    );
    return WalletResponse(
      balanceCents: wallet.balanceCents,
      heldCents: held.single[0]! as int,
      entries: entries,
      entry: entry,
      chargedCents: chargedCents,
    );
  }

  static Map<String, dynamic> _json(Object? value) => switch (value) {
    final Map<String, dynamic> map => map,
    final String text => jsonDecode(text) as Map<String, dynamic>,
    _ => const {},
  };
}

typedef _Wallet = ({String id, int balanceCents});

typedef _PreviousEntry = ({
  String id,
  String kind,
  String? quoteId,
  int? walletCents,
});

typedef _Quote = ({
  String id,
  RideKind rideType,
  double distanceMeters,
  int fareCents,
  PricingConfig pricing,
  DateTime expiresAt,
});

typedef _Hold = ({String id, String quoteId, int amountCents});
