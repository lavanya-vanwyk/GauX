import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app_dependencies.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/presentation/views/animated_splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dependencies = AppDependencies.create(
    prefs: await SharedPreferences.getInstance(),
  );
  runApp(
    MultiProvider(providers: dependencies.providers, child: const GauXApp()),
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
