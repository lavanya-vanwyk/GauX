import 'package:latlong2/latlong.dart';

import '../../../../core/utils/geo.dart';
import '../entities/gautrain_station.dart';

/// The station in [stations] closest to [position] in a straight line.
GautrainStation nearestStation(
  LatLng position,
  List<GautrainStation> stations,
) {
  assert(stations.isNotEmpty, 'nearestStation needs at least one station');
  return stations.reduce(
    (best, station) =>
        straightLineMeters(position, station.location) <
            straightLineMeters(position, best.location)
        ? station
        : best,
  );
}
