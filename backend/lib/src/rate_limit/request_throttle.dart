import 'dart:async';

/// Runs tasks one at a time with at least [minInterval] between their
/// starts, to respect upstream limits such as Nominatim's 1 request/second.
class RequestThrottle {
  RequestThrottle({
    required this.minInterval,
    DateTime Function()? clock,
    Future<void> Function(Duration)? sleep,
  }) : _clock = clock ?? DateTime.now,
       _sleep = sleep ?? Future<void>.delayed;

  final Duration minInterval;
  final DateTime Function() _clock;
  final Future<void> Function(Duration) _sleep;

  Future<void> _queue = Future.value();
  DateTime? _lastStart;

  Future<T> run<T>(Future<T> Function() task) {
    final result = Completer<T>();
    _queue = _queue.then((_) async {
      final last = _lastStart;
      if (last != null) {
        final wait = minInterval - _clock().difference(last);
        if (wait > Duration.zero) await _sleep(wait);
      }
      _lastStart = _clock();
      try {
        result.complete(await task());
      } on Object catch (error, stack) {
        result.completeError(error, stack);
      }
    });
    return result.future;
  }
}
