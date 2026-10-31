import 'failure.dart';

/// The outcome of an operation that can fail in an expected way.
///
/// Use a `switch` to handle both cases:
/// ```dart
/// switch (await repository.getRoute(a, b)) {
///   case Success(:final value): ...
///   case Err(:final failure): ...
/// }
/// ```
sealed class Result<T> {
  const Result();

  /// The value on success, otherwise null.
  T? get valueOrNull => switch (this) {
    Success(:final value) => value,
    Err() => null,
  };
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

final class Err<T> extends Result<T> {
  const Err(this.failure);

  final Failure failure;
}
