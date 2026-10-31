import 'package:json_annotation/json_annotation.dart';

import '../domain/failure.dart';
import '../domain/result.dart';

/// Maps a successful JSON [response] through [parse], turning shape errors
/// into a [ParsingFailure]. Failures pass through unchanged.
Result<T> parseJson<T>(
  Result<Object?> response,
  T Function(Object? json) parse,
) {
  switch (response) {
    case Err(:final failure):
      return Err(failure);
    case Success(:final value):
      try {
        return Success(parse(value));
      } on CheckedFromJsonException catch (e) {
        return Err(ParsingFailure('${e.key}: ${e.message}'));
      } on FormatException catch (e) {
        return Err(ParsingFailure(e.message));
      } on TypeError catch (e) {
        // Thrown by the casts at the top level of a response.
        return Err(ParsingFailure(e.toString()));
      }
  }
}
