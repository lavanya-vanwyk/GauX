import '../../../../core/domain/failure.dart';
import '../../../../core/domain/result.dart';
import '../entities/place_suggestion.dart';
import '../repositories/booking_repository.dart';

/// Searches for places within the GauX service region.
class SearchPlaces {
  const SearchPlaces({
    required BookingRepository repository,
    this.region = 'Gauteng, South Africa',
  }) : _repository = repository;

  final BookingRepository _repository;

  /// Appended to every query so results stay in the service region.
  final String region;

  /// Autocomplete suggestions for [query]. Empty when the query is blank.
  Future<Result<List<PlaceSuggestion>>> call(String query) async {
    if (query.trim().isEmpty) return const Success([]);
    return _repository.searchPlaces(_scoped(query));
  }

  /// The single best match for [address], or [NotFoundFailure].
  Future<Result<PlaceSuggestion>> bestMatch(String address) async {
    final result = await _repository.searchPlaces(_scoped(address), limit: 1);
    return switch (result) {
      Success(value: [final first, ...]) => Success(first),
      Success() => Err(NotFoundFailure('No place matches "$address"')),
      Err(:final failure) => Err(failure),
    };
  }

  String _scoped(String query) => '${query.trim()}, $region';
}
