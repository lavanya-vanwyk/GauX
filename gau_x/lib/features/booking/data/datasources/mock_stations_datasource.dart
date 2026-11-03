import 'package:latlong2/latlong.dart';

import '../../domain/entities/gautrain_station.dart';

/// Gautrain stations bundled with the app until a stations API exists. Also
/// the offline fallback once it does.
///
/// TODO(verify): coordinates are approximate (about 100 m) and should be
/// checked against Gautrain's published station locations. They decide the
/// nearest station and the 5 km service area.
class MockStationsDatasource {
  const MockStationsDatasource();

  static const sandton = GautrainStation(
    id: 'sandton',
    name: 'Sandton',
    location: LatLng(-26.1075, 28.0567),
  );

  static const stations = [
    GautrainStation(
      id: 'park',
      name: 'Park',
      location: LatLng(-26.1955, 28.0415),
    ),
    GautrainStation(
      id: 'rosebank',
      name: 'Rosebank',
      location: LatLng(-26.1455, 28.0437),
    ),
    sandton,
    GautrainStation(
      id: 'marlboro',
      name: 'Marlboro',
      location: LatLng(-26.0843, 28.1115),
    ),
    GautrainStation(
      id: 'midrand',
      name: 'Midrand',
      location: LatLng(-25.9963, 28.1366),
    ),
    GautrainStation(
      id: 'centurion',
      name: 'Centurion',
      location: LatLng(-25.8516, 28.1897),
    ),
    GautrainStation(
      id: 'pretoria',
      name: 'Pretoria',
      location: LatLng(-25.7586, 28.1895),
    ),
    GautrainStation(
      id: 'hatfield',
      name: 'Hatfield',
      location: LatLng(-25.7477, 28.2381),
    ),
    GautrainStation(
      id: 'rhodesfield',
      name: 'Rhodesfield',
      location: LatLng(-26.1265, 28.2257),
    ),
    GautrainStation(
      id: 'or-tambo',
      name: 'OR Tambo',
      location: LatLng(-26.1330, 28.2310),
    ),
  ];

  /// Used when the rider's location is unknown.
  GautrainStation get defaultStation => sandton;
}
