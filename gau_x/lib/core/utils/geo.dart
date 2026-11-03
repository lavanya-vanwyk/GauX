import 'package:latlong2/latlong.dart';

const Distance _distance = Distance();

/// Total length of a polyline in metres, summed segment by segment.
double pathLengthMeters(List<LatLng> path) {
  var total = 0.0;
  for (var i = 0; i < path.length - 1; i++) {
    total += _distance.as(LengthUnit.Meter, path[i], path[i + 1]);
  }
  return total;
}

/// Straight-line distance between two points in metres.
double straightLineMeters(LatLng a, LatLng b) =>
    _distance.as(LengthUnit.Meter, a, b);
