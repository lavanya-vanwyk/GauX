import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/routing/app_routes.dart';
import '../features/auth/presentation/state/auth_controller.dart';
import '../features/auth/presentation/views/login_view.dart';
import '../features/splash/presentation/views/animated_splash_screen.dart';
import '../features/trip_tracking/presentation/views/active_ride_map_view.dart';
import '../features/wallet/presentation/views/wallet_dashboard_view.dart';

part 'router.g.dart';

/// Where to send the user instead of [location], or null to allow it.
///
/// Signed-out users can only see the splash and login screens; the page
/// they asked for is kept in `from` so sign-in can return them there.
/// Signed-in users skip the login screen.
@visibleForTesting
String? authRedirect({required bool signedIn, required Uri location}) {
  final path = location.path;
  final isPublic = path == AppRoutes.splash || path == AppRoutes.login;

  if (!signedIn && !isPublic) {
    return Uri(
      path: AppRoutes.login,
      queryParameters: {'from': location.toString()},
    ).toString();
  }
  if (signedIn && path == AppRoutes.login) {
    final from = location.queryParameters['from'];
    // Only follow in-app paths, never a full URL
    return from != null && from.startsWith('/') ? from : AppRoutes.wallet;
  }
  return null;
}

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final authChanges = ValueNotifier(0);
  ref.listen(authControllerProvider, (_, _) => authChanges.value++);

  final router = GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: authChanges,
    redirect: (context, state) => authRedirect(
      signedIn: ref.read(authControllerProvider) != null,
      location: state.uri,
    ),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, _) => const AnimatedSplashScreen(),
      ),
      GoRoute(path: AppRoutes.login, builder: (_, _) => const LoginView()),
      GoRoute(
        path: AppRoutes.wallet,
        builder: (_, _) => const WalletDashboardView(),
        routes: [
          GoRoute(path: 'ride', builder: (_, _) => const ActiveRideMapView()),
        ],
      ),
    ],
  );
  ref.onDispose(() {
    router.dispose();
    authChanges.dispose();
  });
  return router;
}
