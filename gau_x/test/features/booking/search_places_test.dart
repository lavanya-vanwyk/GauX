import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/core/domain/failure.dart';
import 'package:gau_x/core/domain/result.dart';
import 'package:gau_x/features/booking/domain/entities/place_suggestion.dart';
import 'package:gau_x/features/booking/domain/usecases/search_places.dart';
import 'package:latlong2/latlong.dart';

import '../../helpers/fakes.dart';

void main() {
  const rosebank = PlaceSuggestion(
    name: 'Rosebank',
    location: LatLng(-26.1452, 28.0436),
  );

  test('blank queries return nothing without a request', () async {
    final repository = FakeBookingRepository();

    final result = await SearchPlaces(repository: repository)('   ');

    expect(result.valueOrNull, isEmpty);
    expect(repository.searchRequests, isEmpty);
  });

  test('scopes queries to the service region', () async {
    final repository = FakeBookingRepository();

    await SearchPlaces(repository: repository)(' Rosebank ');

    expect(repository.searchRequests.single, (
      'Rosebank, Gauteng, South Africa',
      5,
    ));
  });

  test('bestMatch returns the first result', () async {
    final repository = FakeBookingRepository(
      searchResult: const Success([rosebank]),
    );

    final result = await SearchPlaces(
      repository: repository,
    ).bestMatch('Rosebank');

    expect(result.valueOrNull, rosebank);
    expect(repository.searchRequests.single.$2, 1);
  });

  test('bestMatch reports NotFoundFailure when nothing matches', () async {
    final result = await SearchPlaces(
      repository: FakeBookingRepository(),
    ).bestMatch('Atlantis');

    expect((result as Err).failure, isA<NotFoundFailure>());
  });
}
