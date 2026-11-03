/// Paths for every screen. Features navigate with these instead of
/// importing each other's views; `lib/app/router.dart` maps them to screens.
abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const wallet = '/wallet';
  static const ride = '/wallet/ride';
}
