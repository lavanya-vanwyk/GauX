import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session.freezed.dart';

/// A signed-in rider. Will carry tokens once real authentication lands.
@freezed
abstract class AuthSession with _$AuthSession {
  const factory AuthSession({required String email}) = _AuthSession;
}
