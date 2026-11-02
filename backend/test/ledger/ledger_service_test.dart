// Runs against a real Postgres: the guarantees under test (row locks,
// constraints, triggers) only exist there. Uses TEST_DATABASE_URL, or the
// local gaux_test database described in backend/README.md.
@Tags(['postgres'])
library;

import 'dart:io';
import 'dart:math';

import 'package:gaux_backend/src/db/migrator.dart';
import 'package:gaux_backend/src/ledger/ledger_exception.dart';
import 'package:gaux_backend/src/ledger/ledger_service.dart';
import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:postgres/postgres.dart';
import 'package:test/test.dart';

final _databaseUrl =
    Platform.environment['TEST_DATABASE_URL'] ??
    'postgresql://gaux_dev:gaux_dev@localhost:5432/gaux_test?sslmode=disable';

const _pricing = PricingConfig();

void main() {
  late Pool<void> pool;
  late LedgerService ledger;
  final random = Random();

  // Each test uses its own riders, so tests don't affect each other
  String newRider() => 'rider-${random.nextInt(1 << 32)}';

  setUpAll(() async {
    pool = Pool.withUrl(_databaseUrl);
    await pool.execute(
      'DROP SCHEMA IF EXISTS gaux CASCADE; '
      'DROP TABLE IF EXISTS public.gaux_schema_migrations',
      queryMode: QueryMode.simple,
    );
    await Migrator(pool).migrate();
    ledger = LedgerService(pool);
  });

  tearDownAll(() => pool.close());

  Future<QuoteResponse> quote(
    String rider, {
    RideKind type = RideKind.private,
    double meters = 2500,
  }) => ledger.createQuote(
    rider,
    rideType: type,
    distanceMeters: meters,
    pricing: _pricing,
  );

  Future<int> scalar(String sql) async =>
      (await pool.execute(sql)).single[0]! as int;

  group('wallets', () {
    test('a new wallet starts with the R350 welcome credit', () async {
      final wallet = await ledger.wallet(newRider());

      expect(wallet.balanceCents, 35000);
      expect(wallet.entries.single.kind, 'opening_balance');
      expect(wallet.entries.single.amountCents, 35000);
    });

    test('opening a wallet twice credits it once', () async {
      final rider = newRider();
      await Future.wait([ledger.wallet(rider), ledger.wallet(rider)]);

      final wallet = await ledger.wallet(rider);

      expect(wallet.balanceCents, 35000);
      expect(wallet.entries, hasLength(1));
    });
  });

  group('charges', () {
    test('charging a quote moves the fare from wallet to revenue', () async {
      final rider = newRider();
      final q = await quote(rider);
      final revenueBefore = await scalar(
        'SELECT balance_cents::int FROM gaux.accounts '
        "WHERE kind = 'platform_revenue'",
      );

      final wallet = await ledger.charge(
        rider,
        ChargeRequest(quoteId: q.id),
        idempotencyKey: 'ride-1',
      );

      expect(q.fareCents, 4000); // R10 + 2.5 km × R12
      expect(wallet.balanceCents, 31000);
      expect(wallet.entry?.kind, 'ride_charge');
      expect(wallet.entry?.description, 'GauX Private');
      expect(wallet.entry?.amountCents, -4000);
      final revenueAfter = await scalar(
        'SELECT balance_cents::int FROM gaux.accounts '
        "WHERE kind = 'platform_revenue'",
      );
      expect(revenueAfter - revenueBefore, greaterThanOrEqualTo(4000));
    });

    test('a retry with the same key returns the same entry', () async {
      final rider = newRider();
      final q = await quote(rider);

      final first = await ledger.charge(
        rider,
        ChargeRequest(quoteId: q.id),
        idempotencyKey: 'ride-1',
      );
      final retry = await ledger.charge(
        rider,
        ChargeRequest(quoteId: q.id),
        idempotencyKey: 'ride-1',
      );

      expect(retry.entry?.id, first.entry?.id);
      expect(retry.balanceCents, 31000, reason: 'charged once');
    });

    test('reusing a key for another quote is rejected', () async {
      final rider = newRider();
      final a = await quote(rider);
      final b = await quote(rider);
      await ledger.charge(
        rider,
        ChargeRequest(quoteId: a.id),
        idempotencyKey: 'k',
      );

      await expectLater(
        ledger.charge(rider, ChargeRequest(quoteId: b.id), idempotencyKey: 'k'),
        throwsA(_ledgerError(ApiErrorCode.idempotencyConflict)),
      );
    });

    test('a quote can only be charged once', () async {
      final rider = newRider();
      final q = await quote(rider);
      await ledger.charge(
        rider,
        ChargeRequest(quoteId: q.id),
        idempotencyKey: 'a',
      );

      await expectLater(
        ledger.charge(
          rider,
          ChargeRequest(quoteId: q.id, cancelled: true),
          idempotencyKey: 'b',
        ),
        throwsA(_ledgerError(ApiErrorCode.idempotencyConflict)),
      );
      expect((await ledger.wallet(rider)).balanceCents, 31000);
    });

    test('a cancellation charges the server-computed partial fare', () async {
      final rider = newRider();
      final q = await quote(rider);

      final wallet = await ledger.charge(
        rider,
        ChargeRequest(
          quoteId: q.id,
          cancelled: true,
          distanceCoveredMeters: 1000,
        ),
        idempotencyKey: 'cancel',
      );

      expect(wallet.entry?.amountCents, -2200); // R10 + 1 km × R12
      expect(wallet.chargedCents, 2200);
      expect(wallet.entry?.description, 'Canceled: GauX Private');
    });

    test('a cancellation fee is capped at the quoted fare', () async {
      final rider = newRider();
      final q = await quote(rider);

      final wallet = await ledger.charge(
        rider,
        ChargeRequest(
          quoteId: q.id,
          cancelled: true,
          distanceCoveredMeters: 1000000000,
        ),
        idempotencyKey: 'cancel',
      );

      expect(wallet.entry?.amountCents, -q.fareCents);
    });

    test('cannot overdraw the wallet', () async {
      final rider = newRider();
      final q = await quote(rider, meters: 40000); // R490

      await expectLater(
        ledger.charge(rider, ChargeRequest(quoteId: q.id), idempotencyKey: 'x'),
        throwsA(_ledgerError(ApiErrorCode.insufficientFunds)),
      );
      expect((await ledger.wallet(rider)).balanceCents, 35000);
    });

    test("can't charge another rider's quote, or a made-up one", () async {
      final q = await quote(newRider());

      for (final id in [q.id, '00000000-0000-0000-0000-000000000000', 'nope']) {
        await expectLater(
          ledger.charge(
            newRider(),
            ChargeRequest(quoteId: id),
            idempotencyKey: 'x',
          ),
          throwsA(_ledgerError(ApiErrorCode.notFound)),
          reason: id,
        );
      }
    });

    test('expired quotes are refused', () async {
      final rider = newRider();
      final issuedEarlier = LedgerService(
        pool,
        clock: () => DateTime.now().subtract(const Duration(hours: 7)),
      );
      final q = await issuedEarlier.createQuote(
        rider,
        rideType: RideKind.pool,
        distanceMeters: 1000,
        pricing: _pricing,
      );

      await expectLater(
        ledger.charge(rider, ChargeRequest(quoteId: q.id), idempotencyKey: 'x'),
        throwsA(_ledgerError(ApiErrorCode.quoteExpired)),
      );
    });
  });

  group('concurrency (row-level locking)', () {
    test('simultaneous charges never spend more than the balance', () async {
      final rider = newRider();
      await ledger.wallet(rider);
      // R350 buys 14 pool rides at R25; try 20 at once
      final quotes = [
        for (var i = 0; i < 20; i++) await quote(rider, type: RideKind.pool),
      ];

      final outcomes = await Future.wait([
        for (final (i, q) in quotes.indexed)
          ledger
              .charge(
                rider,
                ChargeRequest(quoteId: q.id),
                idempotencyKey: 'ride-$i',
              )
              .then((_) => 'charged')
              .catchError(
                (Object e) => (e as LedgerException).code,
                test: (e) => e is LedgerException,
              ),
      ]);

      expect(outcomes.where((o) => o == 'charged'), hasLength(14));
      expect(
        outcomes.where((o) => o == ApiErrorCode.insufficientFunds),
        hasLength(6),
      );
      expect((await ledger.wallet(rider)).balanceCents, 0);
    });

    test('simultaneous retries with one key charge once', () async {
      final rider = newRider();
      await ledger.wallet(rider);
      final q = await quote(rider);

      final results = await Future.wait([
        for (var i = 0; i < 10; i++)
          ledger.charge(
            rider,
            ChargeRequest(quoteId: q.id),
            idempotencyKey: 'same',
          ),
      ]);

      expect(results.map((r) => r.entry?.id).toSet(), hasLength(1));
      expect((await ledger.wallet(rider)).balanceCents, 31000);
    });

    test('simultaneous top-ups all land', () async {
      final rider = newRider();
      await ledger.wallet(rider);

      await Future.wait([
        for (var i = 0; i < 10; i++)
          ledger.topUp(
            rider,
            const TopUpRequest(amountCents: 10000, paymentMethod: 'EFT'),
            idempotencyKey: 'top-$i',
          ),
      ]);

      expect((await ledger.wallet(rider)).balanceCents, 135000);
    });
  });

  group('top-ups and reversals', () {
    test('a top-up retry is credited once', () async {
      final rider = newRider();
      const request = TopUpRequest(amountCents: 15000, paymentMethod: 'EFT');

      await ledger.topUp(rider, request, idempotencyKey: 't');
      final retry = await ledger.topUp(rider, request, idempotencyKey: 't');

      expect(retry.balanceCents, 50000);
      expect(retry.entry?.description, 'Top Up: EFT');
    });

    test('a reversal restores the balance and keeps the original', () async {
      final rider = newRider();
      final topUp = await ledger.topUp(
        rider,
        const TopUpRequest(amountCents: 10000, paymentMethod: 'EFT'),
        idempotencyKey: 't',
      );

      await ledger.reverse(topUp.entry!.id, reason: 'duplicate deposit');

      final wallet = await ledger.wallet(rider);
      expect(wallet.balanceCents, 35000);
      expect(wallet.entries.map((e) => e.kind), [
        'reversal',
        'top_up',
        'opening_balance',
      ]);
    });

    test('an entry can only be reversed once', () async {
      final rider = newRider();
      final topUp = await ledger.topUp(
        rider,
        const TopUpRequest(amountCents: 10000, paymentMethod: 'EFT'),
        idempotencyKey: 't',
      );
      await ledger.reverse(topUp.entry!.id, reason: 'first');

      await expectLater(
        ledger.reverse(topUp.entry!.id, reason: 'second'),
        throwsA(isA<ServerException>()),
      );
    });

    test('reversing money that was already spent is refused', () async {
      final rider = newRider();
      final topUp = await ledger.topUp(
        rider,
        const TopUpRequest(amountCents: 10000, paymentMethod: 'EFT'),
        idempotencyKey: 't',
      );
      final q = await quote(rider, meters: 35000); // R430 of the R450
      await ledger.charge(
        rider,
        ChargeRequest(quoteId: q.id),
        idempotencyKey: 'r',
      );

      await expectLater(
        ledger.reverse(topUp.entry!.id, reason: 'chargeback'),
        throwsA(isA<ServerException>()),
      );
      expect((await ledger.wallet(rider)).balanceCents, 2000);
    });
  });

  group('fare holds', () {
    Future<WalletResponse> hold(String rider, QuoteResponse q, [String? key]) =>
        ledger.placeHold(
          rider,
          HoldRequest(quoteId: q.id),
          idempotencyKey: key ?? 'hold:${q.id}',
        );

    Future<int> heldInSystem() => scalar(
      "SELECT balance_cents::int FROM gaux.accounts WHERE kind = 'rider_holds'",
    );

    test('a hold moves the fare out of the spendable balance', () async {
      final rider = newRider();
      final q = await quote(rider); // R40

      final wallet = await hold(rider, q);

      expect(wallet.balanceCents, 31000);
      expect(wallet.heldCents, 4000);
      expect(wallet.entry?.kind, 'hold');
    });

    test('charging a held quote settles from the hold', () async {
      final rider = newRider();
      final q = await quote(rider);
      await hold(rider, q);

      final wallet = await ledger.charge(
        rider,
        ChargeRequest(quoteId: q.id),
        idempotencyKey: 'ride:${q.id}',
      );

      expect(wallet.balanceCents, 31000, reason: 'nothing extra deducted');
      expect(wallet.heldCents, 0);
      expect(wallet.chargedCents, 4000);
      // Settled exactly from the hold: no wallet line beyond the hold itself
      expect(wallet.entry, isNull);
      expect(wallet.entries.first.description, 'GauX Private');
      expect(wallet.entries.first.amountCents, -4000);
    });

    test('a cancelled ride keeps the fee and returns the rest', () async {
      final rider = newRider();
      final q = await quote(rider); // R40 held
      await hold(rider, q);

      final wallet = await ledger.charge(
        rider,
        ChargeRequest(
          quoteId: q.id,
          cancelled: true,
          distanceCoveredMeters: 1000,
        ),
        idempotencyKey: 'ride:${q.id}',
      );

      // R22 fee kept, R18 of the R40 hold returned
      expect(wallet.balanceCents, 35000 - 2200);
      expect(wallet.heldCents, 0);
      expect(wallet.chargedCents, 2200);
      expect(wallet.entry?.amountCents, 1800);
      expect(wallet.entry?.description, 'Canceled: GauX Private');
    });

    test('releasing a hold returns everything', () async {
      final rider = newRider();
      final q = await quote(rider);
      await hold(rider, q);

      final wallet = await ledger.releaseHold(
        rider,
        HoldRequest(quoteId: q.id),
        idempotencyKey: 'release:${q.id}',
      );

      expect(wallet.balanceCents, 35000);
      expect(wallet.heldCents, 0);
      expect(wallet.entry?.kind, 'hold_release');
    });

    test('a released quote cannot be charged or held again', () async {
      final rider = newRider();
      final q = await quote(rider);
      await hold(rider, q);
      await ledger.releaseHold(
        rider,
        HoldRequest(quoteId: q.id),
        idempotencyKey: 'release',
      );

      await expectLater(
        ledger.charge(rider, ChargeRequest(quoteId: q.id), idempotencyKey: 'c'),
        throwsA(_ledgerError(ApiErrorCode.idempotencyConflict)),
      );
      await expectLater(
        hold(rider, q, 'again'),
        throwsA(_ledgerError(ApiErrorCode.idempotencyConflict)),
      );
    });

    test('retrying a hold holds once', () async {
      final rider = newRider();
      final q = await quote(rider);

      final results = await Future.wait([
        for (var i = 0; i < 5; i++) hold(rider, q),
      ]);

      expect(results.map((r) => r.entry?.id).toSet(), hasLength(1));
      expect((await ledger.wallet(rider)).heldCents, 4000);
    });

    test('a hold needs the balance to cover it', () async {
      final rider = newRider();
      final q = await quote(rider, meters: 40000); // R490

      await expectLater(
        hold(rider, q),
        throwsA(_ledgerError(ApiErrorCode.insufficientFunds)),
      );
    });

    test(
      'held money cannot be spent on other rides at the same time',
      () async {
        final rider = newRider();
        await ledger.wallet(rider);
        // Hold R320 of the R350 for one long ride (R10 + 25.8 km × R12)
        final big = await quote(rider, meters: 25834);
        await hold(rider, big);
        final small = [
          for (var i = 0; i < 5; i++) await quote(rider, type: RideKind.pool),
        ];

        final outcomes = await Future.wait([
          for (final (i, q) in small.indexed)
            ledger
                .charge(
                  rider,
                  ChargeRequest(quoteId: q.id),
                  idempotencyKey: 'small-$i',
                )
                .then((_) => 'charged')
                .catchError(
                  (Object e) => (e as LedgerException).code,
                  test: (e) => e is LedgerException,
                ),
        ]);

        // Only R30 is spendable: one R25 pool ride fits, the rest don't
        expect(outcomes.where((o) => o == 'charged'), hasLength(1));
        final wallet = await ledger.wallet(rider);
        expect(wallet.heldCents, big.fareCents);
        expect(wallet.balanceCents, 35000 - big.fareCents - 2500);
      },
    );

    test('expired holds are released, by the sweep or on next use', () async {
      final rider = newRider();
      final past = LedgerService(
        pool,
        clock: () => DateTime.now().subtract(const Duration(hours: 7)),
      );
      final stale = await past.createQuote(
        rider,
        rideType: RideKind.pool,
        distanceMeters: 1000,
        pricing: _pricing,
      );
      await past.placeHold(
        rider,
        HoldRequest(quoteId: stale.id),
        idempotencyKey: 'h',
      );

      expect(await ledger.releaseExpiredHolds(), greaterThanOrEqualTo(1));
      final wallet = await ledger.wallet(rider);
      expect(wallet.balanceCents, 35000);
      expect(wallet.heldCents, 0);
      expect(wallet.entries.first.description, 'Released: quote expired');
    });

    test('holds cannot be reversed by hand', () async {
      final rider = newRider();
      final q = await quote(rider);
      final held = await hold(rider, q);

      await expectLater(
        ledger.reverse(held.entry!.id, reason: 'x'),
        throwsA(_ledgerError(ApiErrorCode.idempotencyConflict)),
      );
    });

    test('the holds account always equals the open holds', () async {
      final open = await scalar(
        'SELECT coalesce(sum(amount_cents), 0)::int FROM gaux.holds '
        "WHERE status = 'active'",
      );

      expect(await heldInSystem(), open);
    });
  });

  group('database guarantees', () {
    test('ledger rows cannot be edited or deleted', () async {
      await ledger.wallet(newRider());

      for (final sql in [
        'UPDATE gaux.postings SET amount_cents = 1',
        'DELETE FROM gaux.postings',
        "UPDATE gaux.journal_entries SET description = 'x'",
        'DELETE FROM gaux.journal_entries',
        'TRUNCATE gaux.postings',
      ]) {
        await expectLater(
          pool.execute(sql),
          throwsA(isA<ServerException>()),
          reason: sql,
        );
      }
    });

    test('an unbalanced entry is rejected at commit', () async {
      final rider = newRider();
      await ledger.wallet(rider);

      await expectLater(
        pool.runTx((tx) async {
          final entry = await tx.execute(
            Sql.named('''
              INSERT INTO gaux.journal_entries
                (owner_id, idempotency_key, kind, description)
              VALUES (@o, 'free-money', 'top_up', 'x') RETURNING id'''),
            parameters: {'o': rider},
          );
          await tx.execute(
            Sql.named('''
              INSERT INTO gaux.postings (entry_id, account_id, amount_cents)
              SELECT @e, id, 100000 FROM gaux.accounts WHERE owner_id = @o'''),
            parameters: {'e': entry.single[0], 'o': rider},
          );
        }),
        throwsA(isA<ServerException>()),
      );
      expect((await ledger.wallet(rider)).balanceCents, 35000);
    });

    test('the API role cannot change balances directly', () async {
      await expectLater(
        pool.runTx((tx) async {
          await tx.execute('SET LOCAL ROLE gaux_api');
          await tx.execute('UPDATE gaux.accounts SET balance_cents = 999999');
        }),
        throwsA(isA<ServerException>()),
      );
    });

    test('the API role can run the whole wallet flow', () async {
      // The deploy guide runs the server as a member of gaux_api; prove
      // that's enough for everything the server does
      await pool.execute(r'''
        DO $$ BEGIN
          IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'gaux_api_test') THEN
            CREATE ROLE gaux_api_test LOGIN PASSWORD 'gaux_api_test' IN ROLE gaux_api;
          END IF;
        END $$''', queryMode: QueryMode.simple);
      final asApi = Pool<void>.withUrl(
        _databaseUrl.replaceFirst(
          RegExp('//[^@]+@'),
          '//gaux_api_test:gaux_api_test@',
        ),
      );
      addTearDown(asApi.close);
      final apiLedger = LedgerService(asApi);
      final rider = newRider();

      final q = await apiLedger.createQuote(
        rider,
        rideType: RideKind.private,
        distanceMeters: 2500,
        pricing: _pricing,
      );
      await apiLedger.charge(
        rider,
        ChargeRequest(quoteId: q.id),
        idempotencyKey: 'r',
      );
      final wallet = await apiLedger.topUp(
        rider,
        const TopUpRequest(amountCents: 1000, paymentMethod: 'EFT'),
        idempotencyKey: 't',
      );

      expect(wallet.balanceCents, 35000 - 4000 + 1000);
      await expectLater(
        asApi.execute('UPDATE gaux.accounts SET balance_cents = 0'),
        throwsA(isA<ServerException>()),
      );
    });

    test('every cached balance matches its postings', () async {
      expect(
        await pool.execute('SELECT * FROM gaux.account_reconciliation'),
        isEmpty,
      );
    });

    test('migrating again applies nothing', () async {
      expect(await Migrator(pool).migrate(), isEmpty);
    });
  });
}

Matcher _ledgerError(String code) =>
    isA<LedgerException>().having((e) => e.code, 'code', code);
