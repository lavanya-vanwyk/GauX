import 'package:gaux_backend/src/backend_services.dart';

/// The process-wide services, set by `init` in `main.dart` before the first
/// request. Routes get them through the provider in `routes/_middleware.dart`
/// rather than reading this directly, so tests can supply fakes.
late final BackendServices backendServices;
