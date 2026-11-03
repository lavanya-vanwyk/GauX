/// In-memory cache with a time-to-live and a size cap. When full, the least
/// recently used entry is evicted.
///
/// Per process: each server instance has its own cache. Swap for Redis or
/// similar when running more than one instance.
class TtlCache<K, V> {
  TtlCache({
    required this.ttl,
    this.maxEntries = 1000,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final Duration ttl;
  final int maxEntries;
  final DateTime Function() _clock;
  // Map literals keep insertion order, which gives the LRU ordering
  final _entries = <K, ({V value, DateTime expiresAt})>{};

  int get length => _entries.length;

  V? get(K key) {
    final entry = _entries.remove(key);
    if (entry == null) return null;
    if (!_clock().isBefore(entry.expiresAt)) return null;
    _entries[key] = entry; // Re-insert to mark as recently used
    return entry.value;
  }

  void set(K key, V value) {
    _entries
      ..remove(key)
      ..[key] = (value: value, expiresAt: _clock().add(ttl));
    while (_entries.length > maxEntries) {
      _entries.remove(_entries.keys.first);
    }
  }

  /// Returns the cached value for [key], or computes, stores and returns it.
  /// Failures from [compute] are not cached.
  Future<V> getOrCompute(K key, Future<V> Function() compute) async {
    final cached = get(key);
    if (cached != null) return cached;
    final value = await compute();
    set(key, value);
    return value;
  }
}
