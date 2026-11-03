/// Token bucket per client key (usually the IP address): each client can
/// make [capacity] requests at once and regains one every
/// `window / capacity`.
///
/// Per process, like `TtlCache`.
class ClientRateLimiter {
  ClientRateLimiter({
    required this.capacity,
    this.window = const Duration(minutes: 1),
    this.maxClients = 10000,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final int capacity;
  final Duration window;

  /// Oldest clients are forgotten beyond this, bounding memory use.
  final int maxClients;
  final DateTime Function() _clock;
  final _buckets = <String, ({double tokens, DateTime updatedAt})>{};

  /// Consumes a token for [client]. False when the client is over the limit.
  bool tryAcquire(String client) {
    final now = _clock();
    final bucket = _buckets.remove(client);
    var tokens = capacity.toDouble();
    if (bucket != null) {
      final refill =
          now.difference(bucket.updatedAt).inMicroseconds /
          window.inMicroseconds *
          capacity;
      tokens = (bucket.tokens + refill).clamp(0, capacity).toDouble();
    }

    final allowed = tokens >= 1;
    _buckets[client] = (tokens: allowed ? tokens - 1 : tokens, updatedAt: now);
    if (_buckets.length > maxClients) _buckets.remove(_buckets.keys.first);
    return allowed;
  }

  /// Seconds until [client] can make another request.
  int retryAfterSeconds(String client) {
    final bucket = _buckets[client];
    if (bucket == null || bucket.tokens >= 1) return 0;
    final perToken = window.inMilliseconds / capacity;
    return ((1 - bucket.tokens) * perToken / 1000).ceil();
  }
}
