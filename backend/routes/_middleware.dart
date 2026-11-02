import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_backend/gaux_backend.dart';

// Created on first request and shared for the life of the process, so the
// caches and rate-limit buckets persist between requests.
final _services = BackendServices.fromConfig(ServerConfig.fromEnvironment());

Handler middleware(Handler handler) => handler
    .use(provider<BackendServices>((_) => _services))
    .use(requestLogger());
