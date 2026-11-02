import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/app/adapters/api_trip_payments.dart';
import 'package:gau_x/core/domain/failure.dart';
import 'package:gau_x/core/domain/result.dart';
import 'package:gau_x/core/domain/ride_type.dart';
import 'package:gau_x/core/network/api_client.dart';
import 'package:gau_x/core/storage/secure_cache.dart';
import 'package:gau_x/features/booking/domain/policies/fare_calculator.dart';
import 'package:gau_x/features/trip_tracking/domain/ports/trip_payment_port.dart';
import 'package:gau_x/features/wallet/data/datasources/wallet_api_datasource.dart';
import 'package:gau_x/features/wallet/data/repositories/api_gold_card_repository.dart';
import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:latlong2/latlong.dart';

/// A tiny in-memory stand-in for the GauX wallet API.
class _FakeApi {
  int balanceCents = 35000;
  final entries = <WalletEntryDto>[];
  final requests = <http.Request>[];
  final chargedKeys = <String>{};

  /// Fail this many requests with a network error before answering.
  int dropNext = 0;
  String? token = 'dev:judge@gaux.co.za';

  http.Response _json(Object body, [int status = 200]) =>
      http.Response(jsonEncode(body), status);

  WalletResponse _wallet([WalletEntryDto? entry]) => WalletResponse(
    balanceCents: balanceCents,
    entries: entries,
    entry: entry,
  );

  Future<http.Response> handle(http.Request request) async {
    requests.add(request);
    if (dropNext > 0) {
      dropNext--;
      throw http.ClientException('connection reset');
    }
    if (request.headers['Authorization'] != 'Bearer $token') {
      return _json({'code': 'unauthorized', 'message': 'x'}, 401);
    }

    switch (request.url.path) {
      case '/v1/wallet':
        return _json(_wallet().toJson());
      case '/v1/quotes':
        final body = QuoteRequest.fromJson(
          jsonDecode(request.body) as Map<String, dynamic>,
        );
        return _json(
          QuoteResponse(
            id: 'server-quote-1',
            rideType: body.rideType,
            distanceMeters: 1598,
            fareCents: 2918,
            etaMinutes: 4,
            expiresAt: DateTime.utc(2030),
          ).toJson(),
          201,
        );
      case '/v1/wallet/charges':
        final key = request.headers['Idempotency-Key']!;
        final body = ChargeRequest.fromJson(
          jsonDecode(request.body) as Map<String, dynamic>,
        );
        if (chargedKeys.add(key)) {
          final cents = body.cancelled ? 1200 : 2918;
          balanceCents -= cents;
          entries.insert(
            0,
            WalletEntryDto(
              id: key,
              kind: body.cancelled ? 'cancellation_fee' : 'ride_charge',
              description: 'GauX Private',
              amountCents: -cents,
              createdAt: DateTime.utc(2026, 11, 2),
            ),
          );
        }
        return _json(_wallet(entries.first).toJson());
      case '/v1/wallet/topups':
        final body = TopUpRequest.fromJson(
          jsonDecode(request.body) as Map<String, dynamic>,
        );
        balanceCents += body.amountCents;
        return _json(_wallet().toJson());
    }
    return _json({'code': 'not_found', 'message': 'x'}, 404);
  }
}

void main() {
  late _FakeApi server;
  late InMemorySecureCache cache;
  late WalletApiDatasource api;
  late ApiGoldCardRepository wallet;

  setUp(() {
    server = _FakeApi();
    cache = InMemorySecureCache();
    api = WalletApiDatasource(
      client: ApiClient(httpClient: MockClient(server.handle)),
      baseUrl: 'https://api.test',
      accessToken: () async => server.token,
      retryDelays: const [Duration.zero, Duration.zero],
    );
    wallet = ApiGoldCardRepository(api: api, cache: cache);
  });

  group('ApiGoldCardRepository', () {
    test('loads the server wallet and sends the bearer token', () async {
      final card = (await wallet.load()).valueOrNull;

      expect(card?.balanceCents, 35000);
      expect(
        server.requests.single.headers['Authorization'],
        'Bearer dev:judge@gaux.co.za',
      );
    });

    test('shows the cached copy while offline', () async {
      await wallet.load();
      final offline = ApiGoldCardRepository(
        api: WalletApiDatasource(
          client: ApiClient(
            httpClient: MockClient(
              (_) async => throw http.ClientException('offline'),
            ),
          ),
          baseUrl: 'https://api.test',
          accessToken: () async => 'dev:x',
          retryDelays: const [],
        ),
        cache: cache,
      );

      final first = await offline.watch().first;
      final refresh = await offline.load();

      expect(first.balanceCents, 35000);
      expect((refresh as Err).failure, isA<NetworkFailure>());
    });

    test('top-ups go to the server with an idempotency key', () async {
      final card = (await wallet.topUp(
        amountCents: 10000,
        paymentMethod: 'EFT',
        idempotencyKey: 'top-1',
      )).valueOrNull;

      expect(card?.balanceCents, 45000);
      expect(server.requests.last.headers['Idempotency-Key'], 'top-1');
    });

    test('reports signed-out calls without contacting the server', () async {
      final signedOut = ApiGoldCardRepository(
        api: WalletApiDatasource(
          client: ApiClient(httpClient: MockClient(server.handle)),
          baseUrl: 'https://api.test',
          accessToken: () async => null,
        ),
        cache: cache,
      );

      final result = await signedOut.load();

      expect(
        (result as Err).failure,
        isA<ServerFailure>().having((f) => f.statusCode, 'status', 401),
      );
      expect(server.requests, isEmpty);
    });
  });

  group('ApiTripPayments', () {
    const from = LatLng(-26.1075, 28.0567);
    const to = LatLng(-26.0975, 28.0567);
    final appQuote = const FareCalculator().quote(
      rideType: RideType.private,
      distanceMeters: 1500,
    );
    late ApiTripPayments payments;

    setUp(() => payments = ApiTripPayments(api: api, wallet: wallet));

    test('rides use the server price, not the app estimate', () async {
      final confirmed = await payments.confirmPrice(
        appQuote,
        from: from,
        to: to,
      );

      expect(confirmed.valueOrNull?.serverQuoteId, 'server-quote-1');
      expect(confirmed.valueOrNull?.fareCents, 2918);
      final body =
          jsonDecode(server.requests.first.body) as Map<String, dynamic>;
      expect(body['rideType'], 'private');
    });

    test('refuses rides the server wallet cannot cover', () async {
      server.balanceCents = 1000;

      final confirmed = await payments.confirmPrice(
        appQuote,
        from: from,
        to: to,
      );

      expect((confirmed as Err).failure, isA<InsufficientFundsFailure>());
    });

    test('charges by quote, and a retried charge is not doubled', () async {
      final quote = (await payments.confirmPrice(
        appQuote,
        from: from,
        to: to,
      )).valueOrNull!;
      server.dropNext = 1; // first attempt lost on the network

      await payments.chargeCompleted(quote);
      await payments.chargeCompleted(quote);

      final charges = server.requests.where(
        (r) => r.url.path == '/v1/wallet/charges',
      );
      expect(charges.map((r) => r.headers['Idempotency-Key']).toSet(), {
        'ride:server-quote-1',
      });
      expect(server.balanceCents, 35000 - 2918);
      expect((await wallet.watch().first).balanceCents, 35000 - 2918);
    });

    test('a cancellation returns what the server charged', () async {
      final quote = (await payments.confirmPrice(
        appQuote,
        from: from,
        to: to,
      )).valueOrNull!;

      final fee = await payments.chargeCancelled(
        quote,
        distanceCoveredMeters: 800,
      );

      expect(fee.valueOrNull, 1200);
      final body =
          jsonDecode(server.requests.last.body) as Map<String, dynamic>;
      expect(body, containsPair('cancelled', true));
      expect(body, containsPair('distanceCoveredMeters', 800.0));
    });

    test('refuses to charge a ride that never got a server quote', () async {
      final result = await payments.chargeCompleted(appQuote);

      expect(result, isA<Err<void>>());
      expect(server.requests, isEmpty);
    });
  });
}
