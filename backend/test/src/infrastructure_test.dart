import 'dart:io';

import 'package:gaux_backend/gaux_backend.dart';
import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:test/test.dart';

void main() {
  group('TtlCache', () {
    var now = DateTime(2026, 11, 2);
    DateTime clock() => now;

    test('serves values until they expire', () {
      final cache = TtlCache<String, int>(
        ttl: const Duration(minutes: 1),
        clock: clock,
      )..set('a', 1);

      expect(cache.get('a'), 1);
      now = now.add(const Duration(minutes: 1));
      expect(cache.get('a'), isNull);
    });

    test('evicts the least recently used entry when full', () {
      final cache =
          TtlCache<String, int>(
              ttl: const Duration(hours: 1),
              maxEntries: 2,
              clock: clock,
            )
            ..set('a', 1)
            ..set('b', 2)
            ..get('a') // a is now more recent than b
            ..set('c', 3);

      expect(cache.get('a'), 1);
      expect(cache.get('b'), isNull);
      expect(cache.get('c'), 3);
    });

    test('does not cache failures', () async {
      final cache = TtlCache<String, int>(ttl: const Duration(minutes: 1));
      var calls = 0;

      await expectLater(
        cache.getOrCompute('a', () async => throw StateError('down')),
        throwsStateError,
      );
      expect(await cache.getOrCompute('a', () async => ++calls), 1);
      expect(await cache.getOrCompute('a', () async => ++calls), 1);
    });
  });

  group('RequestThrottle', () {
    test('spaces task starts by the minimum interval', () async {
      var now = DateTime(2026);
      final waits = <Duration>[];
      final throttle = RequestThrottle(
        minInterval: const Duration(seconds: 1),
        clock: () => now,
        sleep: (d) async {
          waits.add(d);
          now = now.add(d);
        },
      );

      final results = await Future.wait([
        throttle.run(() async => 1),
        throttle.run(() async => 2),
        throttle
            .run<int>(() async => throw StateError('x'))
            .catchError((Object _) => 0),
        throttle.run(() async => 4),
      ]);

      expect(results, [1, 2, 0, 4]);
      expect(waits, List.filled(3, const Duration(seconds: 1)));
    });
  });

  group('ClientRateLimiter', () {
    test('allows a burst up to capacity, then refills over the window', () {
      var now = DateTime(2026);
      final limiter = ClientRateLimiter(capacity: 2, clock: () => now);

      expect(limiter.tryAcquire('1.2.3.4'), isTrue);
      expect(limiter.tryAcquire('1.2.3.4'), isTrue);
      expect(limiter.tryAcquire('1.2.3.4'), isFalse);
      expect(limiter.retryAfterSeconds('1.2.3.4'), 30);
      expect(limiter.tryAcquire('5.6.7.8'), isTrue, reason: 'per client');

      now = now.add(const Duration(seconds: 30));
      expect(limiter.tryAcquire('1.2.3.4'), isTrue);
    });
  });

  group('RemoteConfigSource', () {
    test('serves defaults without a file', () {
      final source = RemoteConfigSource.load(null);

      expect(source.config, const RemoteConfig());
      expect(source.etag, matches(RegExp(r'^"[0-9a-f]{16}"$')));
    });

    test('loads a document and gives changed content a new ETag', () {
      final dir = Directory.systemTemp.createTempSync('gaux_config');
      addTearDown(() => dir.deleteSync(recursive: true));
      final file = File('${dir.path}/config.json')
        ..writeAsStringSync('{"version": 2, "flags": {"poolEnabled": false}}');

      final source = RemoteConfigSource.load(file.path);

      expect(source.config.version, 2);
      expect(source.config.flags.poolEnabled, isFalse);
      expect(source.etag, isNot(RemoteConfigSource.load(null).etag));
    });
  });

  test('the example config document matches the defaults', () {
    final source = RemoteConfigSource.load(
      'config/remote_config.example.json',
    );

    expect(source.config, const RemoteConfig());
  });

  group('ServerConfig.fromEnvironment', () {
    test('reads overrides and keeps defaults for the rest', () {
      final config = ServerConfig.fromEnvironment({
        'OSRM_BASE_URL': 'https://osrm.internal',
        'RATE_LIMIT_PER_MINUTE': '30',
        'CACHE_TTL_SECONDS': 'not-a-number',
      });

      expect(config.osrmBaseUrl, 'https://osrm.internal');
      expect(config.requestsPerMinute, 30);
      expect(config.cacheTtl, const ServerConfig().cacheTtl);
    });
  });
}
