import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/core/domain/failure.dart';
import 'package:gau_x/core/domain/result.dart';
import 'package:gau_x/core/theme/app_theme.dart';
import 'package:gau_x/features/auth/di/auth_providers.dart';
import 'package:gau_x/features/auth/domain/entities/auth_session.dart';
import 'package:gau_x/features/auth/domain/repositories/auth_repository.dart';
import 'package:gau_x/features/auth/presentation/state/auth_controller.dart';
import 'package:gau_x/features/auth/presentation/views/login_view.dart';

/// Answers sign-in with [result] and records calls.
class _FakeAuth implements AuthRepository {
  _FakeAuth(this.result);

  Result<AuthSession> result;
  int signIns = 0;

  @override
  Future<Result<AuthSession>> signIn() async {
    signIns++;
    return result;
  }

  @override
  Future<AuthSession?> restore() async => null;

  @override
  Future<String?> accessToken() async => null;

  @override
  Future<void> signOut() async {}
}

void main() {
  const judge = AuthSession(userId: 'c1e31e81', email: 'judge@gaux.co.za');
  late ProviderContainer container;
  late _FakeAuth auth;

  Future<void> pumpLogin(WidgetTester tester, Result<AuthSession> result) {
    auth = _FakeAuth(result);
    container = ProviderContainer.test(
      overrides: [authRepositoryProvider.overrideWithValue(auth)],
    );
    return tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(theme: AppTheme.lightTheme, home: const LoginView()),
      ),
    );
  }

  Future<void> tapSignIn(WidgetTester tester) async {
    await tester.tap(find.text('Sign In'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
  }

  testWidgets('shows a single sign-in button, no password field', (
    tester,
  ) async {
    await pumpLogin(tester, const Success(judge));

    expect(find.text('Welcome to GauX'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
  });

  testWidgets('signing in stores the session', (tester) async {
    await pumpLogin(tester, const Success(judge));

    await tapSignIn(tester);

    expect(auth.signIns, 1);
    expect(container.read(authControllerProvider), judge);
  });

  testWidgets('closing the login page shows no error', (tester) async {
    await pumpLogin(tester, const Err(SignInCancelledFailure('closed')));

    await tapSignIn(tester);

    expect(find.byType(SnackBar), findsNothing);
    expect(container.read(authControllerProvider), isNull);
  });

  testWidgets('explains a build without sign-in configured', (tester) async {
    await pumpLogin(tester, const Err(SignInUnavailableFailure('none')));

    await tapSignIn(tester);

    expect(find.textContaining('not available in this build'), findsOneWidget);
  });

  testWidgets('explains a failed sign-in', (tester) async {
    await pumpLogin(tester, const Err(NetworkFailure('offline')));

    await tapSignIn(tester);

    expect(find.textContaining("Couldn't sign in"), findsOneWidget);
  });
}
