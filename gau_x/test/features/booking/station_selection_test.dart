import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/core/di/core_providers.dart';
import 'package:gau_x/core/location/location_service.dart';
import 'package:gau_x/features/booking/data/datasources/mock_stations_datasource.dart';
import 'package:gau_x/features/booking/di/booking_providers.dart';
import 'package:gau_x/features/booking/domain/policies/nearest_station.dart';
import 'package:gau_x/features/booking/presentation/state/station_controller.dart';
import 'package:latlong2/latlong.dart';

import '../../helpers/fakes.dart';

void main() {
  const stations = MockStationsDatasource.stations;
  const hatfieldPlaza = LatLng(-25.7500, 28.2370);

  test('nearestStation picks the closest station', () {
    expect(nearestStation(hatfieldPlaza, stations).id, 'hatfield');
    expect(
      nearestStation(const LatLng(-26.1080, 28.0560), stations).id,
      'sandton',
    );
  });

  ProviderContainer createContainer(LocationService location) =>
      ProviderContainer.test(
        overrides: [
          bookingRepositoryProvider.overrideWithValue(FakeBookingRepository()),
          locationServiceProvider.overrideWithValue(location),
        ],
      );

  test('preselects the station nearest the rider', () async {
    final container = createContainer(FakeLocationService.at(hatfieldPlaza));

    final selection = await container.read(stationControllerProvider.future);

    expect(selection.selected.id, 'hatfield');
    expect(selection.source, StationSource.nearest);
    expect(container.read(originStationProvider).id, 'hatfield');
  });

  test('falls back to Sandton without a location', () async {
    final container = createContainer(FakeLocationService.unavailable());

    final selection = await container.read(stationControllerProvider.future);

    expect(selection.selected, MockStationsDatasource.sandton);
    expect(selection.source, StationSource.fallback);
  });

  test('uses Sandton while the location is still loading', () {
    final container = createContainer(FakeLocationService.at(hatfieldPlaza));

    expect(
      container.read(originStationProvider),
      MockStationsDatasource.sandton,
    );
  });

  test('the rider can override the selection', () async {
    final container = createContainer(FakeLocationService.at(hatfieldPlaza));
    await container.read(stationControllerProvider.future);

    container.read(stationControllerProvider.notifier).select(stations.first);

    expect(container.read(originStationProvider), stations.first);
    expect(
      container.read(stationControllerProvider).value?.source,
      StationSource.manual,
    );
  });
}
