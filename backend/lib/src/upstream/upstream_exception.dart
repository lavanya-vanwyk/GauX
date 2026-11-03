/// An upstream service (router, geocoder) failed or returned junk.
/// Routes turn this into a 502 so clients can tell it apart from their own
/// mistakes.
class UpstreamException implements Exception {
  const UpstreamException(this.service, this.message);

  final String service;
  final String message;

  @override
  String toString() => 'UpstreamException($service): $message';
}
