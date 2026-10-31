import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/config/app_config.dart';
import '../core/network/api_client.dart';
import '../features/booking/data/datasources/geocoding_remote_datasource.dart';
import '../features/booking/data/datasources/mock_stations_datasource.dart';
import '../features/booking/data/datasources/routing_remote_datasource.dart';
import '../features/booking/data/repositories/booking_repository_impl.dart';
import '../features/booking/domain/repositories/booking_repository.dart';
import '../features/booking/domain/usecases/plan_route.dart';
import '../features/booking/domain/usecases/search_places.dart';
import '../features/booking/presentation/state/booking_notifier.dart';
import '../features/trip_tracking/data/repositories/tracking_repository_impl.dart';
import '../features/trip_tracking/domain/repositories/tracking_repository.dart';
import '../features/trip_tracking/domain/usecases/cancel_trip.dart';
import '../features/trip_tracking/domain/usecases/complete_trip.dart';
import '../features/trip_tracking/presentation/state/map_viewport_notifier.dart';
import '../features/trip_tracking/presentation/state/simulation_controller.dart';
import '../features/wallet/data/datasources/gold_card_local_datasource.dart';
import '../features/wallet/data/repositories/gold_card_repository_impl.dart';
import '../features/wallet/domain/repositories/gold_card_repository.dart';
import '../features/wallet/domain/usecases/charge_wallet.dart';
import '../features/wallet/domain/usecases/top_up_wallet.dart';
import '../features/wallet/presentation/state/wallet_notifier.dart';
import 'adapters/wallet_trip_payment_adapter.dart';

/// The composition root: the only place that knows which implementation
/// backs each interface. Tests and other environments pass their own
/// repositories to the constructor.
class AppDependencies {
  AppDependencies({
    required this.bookingRepository,
    required this.goldCardRepository,
    required this.trackingRepository,
  });

  /// Production wiring from [AppConfig].
  factory AppDependencies.create({
    required SharedPreferences prefs,
    http.Client? httpClient,
  }) {
    final api = ApiClient(httpClient: httpClient ?? http.Client());
    return AppDependencies(
      bookingRepository: BookingRepositoryImpl(
        routing: RoutingRemoteDatasource(
          client: api,
          baseUrl: AppConfig.osrmBaseUrl,
        ),
        geocoding: GeocodingRemoteDatasource(
          client: api,
          baseUrl: AppConfig.nominatimBaseUrl,
        ),
        stations: const MockStationsDatasource(),
      ),
      goldCardRepository: GoldCardRepositoryImpl(
        local: GoldCardLocalDatasource(prefs),
      ),
      trackingRepository: const SimulatedTrackingRepository(),
    );
  }

  final BookingRepository bookingRepository;
  final GoldCardRepository goldCardRepository;
  final TrackingRepository trackingRepository;

  /// State objects exposed to the widget tree.
  List<SingleChildWidget> get providers {
    final payments = WalletTripPaymentAdapter(
      ChargeWallet(repository: goldCardRepository),
    );
    return [
      ChangeNotifierProvider(
        create: (_) => WalletNotifier(
          repository: goldCardRepository,
          topUpWallet: TopUpWallet(repository: goldCardRepository),
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => SimulationController(
          tracking: trackingRepository,
          completeTrip: CompleteTrip(payments: payments),
          cancelTrip: CancelTrip(payments: payments),
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => BookingNotifier(
          repository: bookingRepository,
          planRoute: PlanRoute(repository: bookingRepository),
          searchPlaces: SearchPlaces(repository: bookingRepository),
        ),
      ),
      ChangeNotifierProvider(create: (_) => MapViewportNotifier()),
    ];
  }
}
