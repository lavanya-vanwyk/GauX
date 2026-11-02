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
    final wallet = await _lockWallet(tx, ownerId);
    return _walletResponse(tx, wallet);
  });

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
    final wallet = await _lockWallet(tx, ownerId);

    final previous = await _entryByKey(tx, ownerId, idempotencyKey);
    if (previous != null) {
      if (previous.quoteId != request.quoteId) {
        throw const LedgerException.idempotencyConflict(
          'Idempotency-Key was used for a different charge',
        );
      }
      return _walletResponse(tx, wallet, entryId: previous.id);
    }

    final quote = await _quote(tx, ownerId, request.quoteId);
    if (!_clock().toUtc().isBefore(quote.expiresAt)) {
      throw const LedgerException.quoteExpired();
    }
    final alreadyCharged = await tx.execute(
      Sql.named('SELECT 1 FROM gaux.journal_entries WHERE quote_id = @q'),
      parameters: {'q': quote.id},
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
    if (amount == 0) return _walletResponse(tx, wallet);
    if (wallet.balanceCents < amount) {
      throw const LedgerException.insufficientFunds();
    }

    final name = quote.rideType == RideKind.pool ? 'GauX Pool' : 'GauX Private';
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
    final wallet = await _lockWallet(tx, ownerId);

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
            'SELECT owner_id FROM gaux.journal_entries WHERE id = @id',
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
    return WalletResponse(
      balanceCents: wallet.balanceCents,
      entries: entries,
      entry: entry,
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
