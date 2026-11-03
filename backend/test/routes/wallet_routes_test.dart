@Tags(['postgres'])
library;

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_backend/gaux_backend.dart';
import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:mocktail/mocktail.dart';
import 'package:postgres/postgres.dart';
import 'package:test/test.dart';

import '../../routes/v1/quotes.dart' as quotes;
import '../../routes/v1/wallet/charges.dart' as charges;
import '../../routes/v1/wallet/holds/index.dart' as holds;
import '../../routes/v1/wallet/holds/release.dart' as release;
import '../../routes/v1/wallet/index.dart' as wallet;
import '../../routes/v1/wallet/topups.dart' as topups;

final _databaseUrl =
    Platform.environment['TEST_DATABASE_URL'] ??
    'postgresql://gaux_dev:gaux_dev@localhost:5432/gaux_test?sslmode=disable';

class _MockContext extends Mock implements RequestContext {}

/// A straight 2.5 km route, whatever the endpoints.
class _FixedRouting implements RoutingProvider {
  @override
  Future<RouteResponse?> route(GeoPoint from, GeoPoint to) async =>
      RouteResponse(points: [from, to], distanceMeters: 2500);
}

class _NoGeocoding implements GeocodingProvider {
  @override
  Future<List<PlaceDto>> search(String query, {required int limit}) async =>
      const [];
}

const _sandton = GeoPoint(lat: -26.1075, lng: 28.0567);
const _nearSandton = GeoPoint(lat: -26.0975, lng: 28.0567);

void main() {
  late Pool<void> pool;
  late BackendServices services;
  final random = Random();

  setUpAll(() async {
    pool = Pool.withUrl(_databaseUrl);
    await Migrator(pool).migrate();
  });
  tearDownAll(() => pool.close());

  BackendServices servicesWith({
    bool ledger = true,
    bool topUps = true,
    RemoteConfig config = const RemoteConfig(),
  }) => BackendServices(
    routing: _FixedRouting(),
    geocoding: _NoGeocoding(),
    remoteConfig: RemoteConfigSource(config),
    rateLimiter: ClientRateLimiter(capacity: 1000),
    ledger: ledger ? LedgerService(pool) : null,
    authenticator: const DevAuthenticator(),
    simulatedTopUps: topUps,
  );

  setUp(() => services = servicesWith());

  late String rider;
  setUp(() => rider = 'rider-${random.nextInt(1 << 32)}');

  RequestContext request(
    String path, {
    HttpMethod method = HttpMethod.get,
    Object? body,
    String? key,
    bool signedIn = true,
  }) {
    final context = _MockContext();
    when(() => context.request).thenReturn(
      Request(
        method.value,
        Uri.parse('http://localhost$path'),
        body: body == null ? null : jsonEncode(body),
        headers: {
          if (signedIn) 'authorization': 'Bearer dev:$rider',
          'idempotency-key': ?key,
        },
      ),
    );
    when(() => context.read<BackendServices>()).thenReturn(services);
    return context;
  }

  Future<Map<String, dynamic>> json(Response response) async =>
      jsonDecode(await response.body()) as Map<String, dynamic>;

  Future<QuoteResponse> newQuote({RideKind type = RideKind.private}) async {
    final response = await quotes.onRequest(
      request(
        '/v1/quotes',
        method: HttpMethod.post,
        body: QuoteRequest(
          from: _sandton,
          to: _nearSandton,
          rideType: type,
        ).toJson(),
      ),
    );
    expect(response.statusCode, HttpStatus.created);
    return QuoteResponse.fromJson(await json(response));
  }

  group('access', () {
    test('wallet endpoints need a signed-in rider', () async {
      final response = await wallet.onRequest(
        request('/v1/wallet', signedIn: false),
      );

      expect(response.statusCode, HttpStatus.unauthorized);
      expect((await json(response))['code'], ApiErrorCode.unauthorized);
    });

    test('answer 503 when the server has no wallet database', () async {
      services = servicesWith(ledger: false);

      final response = await wallet.onRequest(request('/v1/wallet'));

      expect(response.statusCode, HttpStatus.serviceUnavailable);
    });
  });

  test('GET /v1/wallet opens the wallet with its welcome credit', () async {
    final response = await wallet.onRequest(request('/v1/wallet'));

    expect(response.statusCode, HttpStatus.ok);
    expect(WalletResponse.fromJson(await json(response)).balanceCents, 35000);
  });

  group('POST /v1/quotes', () {
    test('prices the route on the server', () async {
      final quote = await newQuote();

      expect(quote.fareCents, 4000);
      expect(quote.distanceMeters, 2500);
      expect(quote.expiresAt.isAfter(DateTime.now()), isTrue);
    });

    test(
      'refuses rides outside the service area or not from a station',
      () async {
        for (final (from, to) in [
          (_sandton, const GeoPoint(lat: -25.9, lng: 28.0567)), // 23 km away
          (const GeoPoint(lat: -26.3, lng: 28.2), _nearSandton), // no station
        ]) {
          final response = await quotes.onRequest(
            request(
              '/v1/quotes',
              method: HttpMethod.post,
              body: QuoteRequest(
                from: from,
                to: to,
                rideType: RideKind.private,
              ).toJson(),
            ),
          );
          expect(response.statusCode, HttpStatus.unprocessableEntity);
          expect(
            (await json(response))['code'],
            ApiErrorCode.outsideServiceArea,
          );
        }
      },
    );

    test('respects the booking and pool kill switches', () async {
      services = servicesWith(
        config: const RemoteConfig(flags: FeatureFlags(poolEnabled: false)),
      );
      final pool = await quotes.onRequest(
        request(
          '/v1/quotes',
          method: HttpMethod.post,
          body: const QuoteRequest(
            from: _sandton,
            to: _nearSandton,
            rideType: RideKind.pool,
          ).toJson(),
        ),
      );
      expect(pool.statusCode, HttpStatus.badRequest);

      services = servicesWith(
        config: const RemoteConfig(flags: FeatureFlags(bookingEnabled: false)),
      );
      final any = await quotes.onRequest(
        request(
          '/v1/quotes',
          method: HttpMethod.post,
          body: const QuoteRequest(
            from: _sandton,
            to: _nearSandton,
            rideType: RideKind.private,
          ).toJson(),
        ),
      );
      expect(any.statusCode, HttpStatus.serviceUnavailable);
    });

    test('rejects a malformed body', () async {
      final response = await quotes.onRequest(
        request('/v1/quotes', method: HttpMethod.post, body: {'from': 'x'}),
      );

      expect(response.statusCode, HttpStatus.badRequest);
    });
  });

  group('POST /v1/wallet/charges', () {
    test('requires an Idempotency-Key', () async {
      final response = await charges.onRequest(
        request(
          '/v1/wallet/charges',
          method: HttpMethod.post,
          body: const ChargeRequest(quoteId: 'x').toJson(),
        ),
      );

      expect(response.statusCode, HttpStatus.badRequest);
    });

    test('charges the quote once, however often it is retried', () async {
      final quote = await newQuote();
      Future<Response> charge() => charges.onRequest(
        request(
          '/v1/wallet/charges',
          method: HttpMethod.post,
          body: ChargeRequest(quoteId: quote.id).toJson(),
          key: 'ride-${quote.id}',
        ),
      );

      final first = WalletResponse.fromJson(await json(await charge()));
      final retry = WalletResponse.fromJson(await json(await charge()));

      expect(first.balanceCents, 31000);
      expect(retry.balanceCents, 31000);
      expect(retry.entry?.id, first.entry?.id);
    });

    test('answers 402 when the wallet is short', () async {
      final quotesNeeded = [for (var i = 0; i < 9; i++) await newQuote()];
      final statuses = <int>[];
      for (final (i, quote) in quotesNeeded.indexed) {
        final response = await charges.onRequest(
          request(
            '/v1/wallet/charges',
            method: HttpMethod.post,
            body: ChargeRequest(quoteId: quote.id).toJson(),
            key: 'k$i',
          ),
        );
        statuses.add(response.statusCode);
      }

      // R350 covers eight R40 rides
      expect(statuses.where((s) => s == HttpStatus.ok), hasLength(8));
      expect(statuses.last, HttpStatus.paymentRequired);
    });
  });

  group('holds', () {
    test('hold, then charge: the fare is paid once, from the hold', () async {
      final quote = await newQuote();
      final held = await holds.onRequest(
        request(
          '/v1/wallet/holds',
          method: HttpMethod.post,
          body: HoldRequest(quoteId: quote.id).toJson(),
          key: 'hold:${quote.id}',
        ),
      );
      final afterHold = WalletResponse.fromJson(await json(held));

      final charged = WalletResponse.fromJson(
        await json(
          await charges.onRequest(
            request(
              '/v1/wallet/charges',
              method: HttpMethod.post,
              body: ChargeRequest(quoteId: quote.id).toJson(),
              key: 'ride:${quote.id}',
            ),
          ),
        ),
      );

      expect(held.statusCode, HttpStatus.ok);
      expect(afterHold.balanceCents, 31000);
      expect(afterHold.heldCents, 4000);
      expect(charged.balanceCents, 31000);
      expect(charged.heldCents, 0);
      expect(charged.chargedCents, 4000);
    });

    test('release returns the hold', () async {
      final quote = await newQuote();
      await holds.onRequest(
        request(
          '/v1/wallet/holds',
          method: HttpMethod.post,
          body: HoldRequest(quoteId: quote.id).toJson(),
          key: 'hold:${quote.id}',
        ),
      );

      final released = WalletResponse.fromJson(
        await json(
          await release.onRequest(
            request(
              '/v1/wallet/holds/release',
              method: HttpMethod.post,
              body: HoldRequest(quoteId: quote.id).toJson(),
              key: 'release:${quote.id}',
            ),
          ),
        ),
      );

      expect(released.balanceCents, 35000);
      expect(released.heldCents, 0);
    });

    test('a hold the wallet cannot cover answers 402', () async {
      for (var i = 0; i < 8; i++) {
        final q = await newQuote();
        await holds.onRequest(
          request(
            '/v1/wallet/holds',
            method: HttpMethod.post,
            body: HoldRequest(quoteId: q.id).toJson(),
            key: 'h$i',
          ),
        );
      }
      final ninth = await newQuote();

      final response = await holds.onRequest(
        request(
          '/v1/wallet/holds',
          method: HttpMethod.post,
          body: HoldRequest(quoteId: ninth.id).toJson(),
          key: 'h9',
        ),
      );

      expect(response.statusCode, HttpStatus.paymentRequired);
    });
  });

  group('POST /v1/wallet/topups', () {
    test('credits the wallet', () async {
      final response = await topups.onRequest(
        request(
          '/v1/wallet/topups',
          method: HttpMethod.post,
          body: const TopUpRequest(
            amountCents: 10000,
            paymentMethod: 'FNB eWallet',
          ).toJson(),
          key: 'top-1',
        ),
      );

      expect(response.statusCode, HttpStatus.ok);
      expect(WalletResponse.fromJson(await json(response)).balanceCents, 45000);
    });

    test('is off unless simulated top-ups are enabled', () async {
      services = servicesWith(topUps: false);

      final response = await topups.onRequest(
        request(
          '/v1/wallet/topups',
          method: HttpMethod.post,
          body: const TopUpRequest(
            amountCents: 10000,
            paymentMethod: 'EFT',
          ).toJson(),
          key: 'top-1',
        ),
      );

      expect(response.statusCode, HttpStatus.serviceUnavailable);
    });

    test('rejects silly amounts', () async {
      for (final cents in [0, -100, 999999999]) {
        final response = await topups.onRequest(
          request(
            '/v1/wallet/topups',
            method: HttpMethod.post,
            body: TopUpRequest(
              amountCents: cents,
              paymentMethod: 'EFT',
            ).toJson(),
            key: 'top-$cents',
          ),
        );
        expect(response.statusCode, HttpStatus.badRequest, reason: '$cents');
      }
    });
  });
}
