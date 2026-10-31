import 'package:latlong2/latlong.dart';

import '../../../../core/domain/result.dart';
import '../entities/driving_route.dart';
import '../entities/gautrain_station.dart';
import '../entities/place_suggestion.dart';

/// Routing, geocoding and station data for booking, independent of which
/// providers (OSRM, Nominatim, a GauX backend) supply them.
abstract interface class BookingRepository {
  /// The station rides currently start from.
  GautrainStation get originStation;

  Future<Result<DrivingRoute>> getRoute(LatLng from, LatLng to);

  /// Up to [limit] places matching [query]. An empty list means no matches.
  Future<Result<List<PlaceSuggestion>>> searchPlaces(
    String query, {
    int limit = 5,
  });
}
