import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'features/booking/presentation/state/booking_notifier.dart';
import 'features/splash/presentation/views/animated_splash_screen.dart';
import 'features/trip_tracking/presentation/state/map_viewport_notifier.dart';
import 'features/trip_tracking/presentation/state/simulation_controller.dart';
import 'features/wallet/presentation/state/wallet_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WalletNotifier()),
        ChangeNotifierProvider(create: (_) => SimulationController()),
        ChangeNotifierProvider(create: (_) => BookingNotifier()),
        ChangeNotifierProvider(create: (_) => MapViewportNotifier()),
      ],
      child: const GauXApp(),
    ),
  );
}

class GauXApp extends StatelessWidget {
  const GauXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GauX',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AnimatedSplashScreen(),
    );
  }
}
