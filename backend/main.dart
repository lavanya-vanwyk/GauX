import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_backend/gaux_backend.dart';

/// Runs once before the server starts: builds the shared services and, if
/// configured, brings the database schema up to date.
Future<void> init(InternetAddress ip, int port) async {
  final config = ServerConfig.fromEnvironment();
  final services = BackendServices.fromConfig(config);
  if (config.migrateOnStart) await services.migrate();
  backendServices = services;
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) =>
    serve(handler, ip, port);
