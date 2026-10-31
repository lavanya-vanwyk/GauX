import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/core/theme/app_theme.dart';
import 'package:gau_x/features/auth/presentation/views/login_view.dart';

void main() {
  Future<void> pumpLogin(WidgetTester tester) {
    return tester.pumpWidget(
      MaterialApp(theme: AppTheme.lightTheme, home: const LoginView()),
    );
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

    await tester.enterText(
      find.widgetWithText(TextField, 'Email'),
      'someone@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Password'),
      'wrong-password',
    );
    await tester.tap(find.text('Sign In'));
    await tester.pump(const Duration(milliseconds: 1600));

    expect(find.textContaining('Invalid credentials'), findsOneWidget);
  });
}
