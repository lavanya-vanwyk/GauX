import 'package:latlong2/latlong.dart';

import '../../domain/entities/gautrain_station.dart';

/// Stations bundled with the app until a stations API exists. Also the
/// offline fallback once it does.
class MockStationsDatasource {
  const MockStationsDatasource();

  static const sandton = GautrainStation(
    id: 'sandton',
    name: 'Sandton',
    location: LatLng(-26.1075, 28.0567),
  );

  List<GautrainStation> get stations => const [sandton];

  /// The station rides start from until location-based selection lands.
  GautrainStation get defaultStation => sandton;
}
