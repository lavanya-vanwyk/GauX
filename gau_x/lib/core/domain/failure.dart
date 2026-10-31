/// Why an operation failed. Repositories translate exceptions and HTTP
/// errors into one of these, so callers can react without knowing which
/// provider or transport was involved.
///
/// Features may define their own subclasses for business-rule failures.
abstract class Failure {
  const Failure(this.message);

  /// Developer-facing detail for logs. Never show this to users directly.
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// No connection, DNS failure, or the request timed out.
final class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// The server answered with a non-success status code.
final class ServerFailure extends Failure {
  const ServerFailure(this.statusCode, String message) : super(message);

  final int statusCode;
}

/// The response arrived but didn't have the expected shape.
final class ParsingFailure extends Failure {
  const ParsingFailure(super.message);
}

/// The request succeeded but nothing matched (e.g. an unknown address).
final class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}
