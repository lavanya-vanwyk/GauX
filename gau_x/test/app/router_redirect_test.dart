import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/app/router.dart';

void main() {
  String? redirect(String location, {required bool signedIn}) =>
      authRedirect(signedIn: signedIn, location: Uri.parse(location));

  group('signed out', () {
    test('can see the splash and login screens', () {
      expect(redirect('/', signedIn: false), isNull);
      expect(redirect('/login', signedIn: false), isNull);
    });

    test('is sent to login from the wallet, remembering where to return', () {
      expect(
        redirect('/wallet/ride', signedIn: false),
        '/login?from=%2Fwallet%2Fride',
      );
    });
  });

  group('signed in', () {
    test('skips login and lands on the wallet', () {
      expect(redirect('/login', signedIn: true), '/wallet');
    });

    test('returns to the page that required sign-in', () {
      expect(
        redirect('/login?from=%2Fwallet%2Fride', signedIn: true),
        '/wallet/ride',
      );
    });

    test('ignores a return address that is not an in-app path', () {
      expect(
        redirect('/login?from=https%3A%2F%2Fevil.example', signedIn: true),
        '/wallet',
      );
    });

    test('can open wallet screens', () {
      expect(redirect('/wallet', signedIn: true), isNull);
      expect(redirect('/wallet/ride', signedIn: true), isNull);
    });
  });
}
