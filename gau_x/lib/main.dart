import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/wallet/presentation/state/wallet_notifier.dart';
import 'features/wallet/presentation/views/wallet_dashboard_view.dart';
import 'features/trip_tracking/presentation/state/simulation_controller.dart';
import 'features/booking/presentation/state/booking_notifier.dart'; // Ensure this file exists from scaffolding

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WalletNotifier()),
        ChangeNotifierProvider(create: (_) => SimulationController()),

        ChangeNotifierProvider(create: (_) => BookingNotifier()),
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
      theme: ThemeData(
        primaryColor: const Color(0xFFC59B27), // Gautrain Gold
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF002244), // Gautrain Navy
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC59B27),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      // The entry point is now the Wallet Dashboard, keeping the user in the "Power of One" ecosystem
      home: const WalletDashboardView(), 
    );
  }
}
