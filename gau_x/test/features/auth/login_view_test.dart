import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/core/theme/app_theme.dart';
import 'package:gau_x/features/auth/data/repositories/demo_auth_repository.dart';
import 'package:gau_x/features/auth/di/auth_providers.dart';
import 'package:gau_x/features/auth/presentation/state/auth_controller.dart';
import 'package:gau_x/features/auth/presentation/views/login_view.dart';

void main() {
  late ProviderContainer container;

  Future<void> pumpLogin(WidgetTester tester, {bool enabled = true}) {
    container = ProviderContainer.test(
      overrides: [
        authRepositoryProvider.overrideWithValue(
          DemoAuthRepository(enabled: enabled, latency: Duration.zero),
        ),
      ],
    );
    return tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(theme: AppTheme.lightTheme, home: const LoginView()),
      ),
    );
  }

  Future<void> signIn(
    WidgetTester tester,
    String email,
    String password,
  ) async {
    await tester.enterText(find.widgetWithText(TextField, 'Email'), email);
    await tester.enterText(
      find.widgetWithText(TextField, 'Password'),
      password,
    );
    await tester.tap(find.text('Sign In'));
    // Let the (zero) sign-in delay elapse, then show the result
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pump(const Duration(milliseconds: 100));
  }

  testWidgets('shows the sign-in form', (tester) async {
    await pumpLogin(tester);

    expect(find.text('Welcome to GauX'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });

  testWidgets('asks for both fields when submitted empty', (tester) async {
    await pumpLogin(tester);

    await tester.tap(find.text('Sign In'));
    await tester.pump();

    expect(find.text('Please enter both email and password.'), findsOneWidget);
  });

  testWidgets('rejects wrong credentials', (tester) async {
    await pumpLogin(tester);

    await signIn(tester, 'someone@example.com', 'wrong-password');

    expect(find.textContaining('Invalid credentials'), findsOneWidget);
    expect(container.read(authControllerProvider), isNull);
  });

  testWidgets('signs in with the demo account', (tester) async {
    await pumpLogin(tester);

    await signIn(
      tester,
      DemoAuthRepository.demoEmail,
      DemoAuthRepository.demoPassword,
    );

    expect(
      container.read(authControllerProvider)?.email,
      DemoAuthRepository.demoEmail,
    );
  });

  testWidgets('explains when sign-in is disabled for the build', (
    tester,
  ) async {
    await pumpLogin(tester, enabled: false);

    await signIn(
      tester,
      DemoAuthRepository.demoEmail,
      DemoAuthRepository.demoPassword,
    );

    expect(find.textContaining('not available in this build'), findsOneWidget);
  });
}
