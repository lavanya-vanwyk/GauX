import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/core_providers.dart';
import '../../../../core/domain/result.dart';
import '../../di/booking_providers.dart';
import '../../domain/entities/gautrain_station.dart';
import '../../domain/policies/nearest_station.dart';

part 'station_controller.freezed.dart';
part 'station_controller.g.dart';

enum StationSource {
  /// Closest to the rider's GPS position.
  nearest,

  /// Location was unavailable, so the default station is used.
  fallback,

  /// Chosen by the rider.
  manual,
}

@freezed
abstract class StationSelection with _$StationSelection {
  const factory StationSelection({
    required List<GautrainStation> stations,
    required GautrainStation selected,
    required StationSource source,
  }) = _StationSelection;
}

/// Which station rides start from: the nearest one by GPS, until the rider
/// picks another.
@Riverpod(keepAlive: true)
class StationController extends _$StationController {
  @override
  Future<StationSelection> build() async {
    final repository = ref.watch(bookingRepositoryProvider);
    final stations =
        (await repository.getStations()).valueOrNull ??
        [repository.defaultStation];

    switch (await ref.watch(locationServiceProvider).currentPosition()) {
      case Success(:final value):
        return StationSelection(
          stations: stations,
          selected: nearestStation(value, stations),
          source: StationSource.nearest,
        );
      case Err(:final failure):
        debugPrint('Station: falling back to default ($failure)');
        return StationSelection(
          stations: stations,
          selected: repository.defaultStation,
          source: StationSource.fallback,
        );
    }
  }

  void select(GautrainStation station) {
    final current = state.value;
    if (current == null || current.selected == station) return;
    state = AsyncData(
      current.copyWith(selected: station, source: StationSource.manual),
    );
  }
}

/// The station rides start from right now. While the nearest station is
/// still being found, this is the default station.
@Riverpod(keepAlive: true)
GautrainStation originStation(Ref ref) =>
    ref.watch(stationControllerProvider).value?.selected ??
    ref.watch(bookingRepositoryProvider).defaultStation;
