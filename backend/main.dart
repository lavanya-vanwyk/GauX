import 'dart:async';
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

  // Return money held for rides that were confirmed but never charged
  final ledger = services.ledger;
  if (ledger != null) {
    Timer.periodic(const Duration(minutes: 5), (_) async {
      try {
        final released = await ledger.releaseExpiredHolds();
        if (released > 0) stdout.writeln('Released $released expired holds');
      } on Object catch (e) {
        stderr.writeln('Releasing expired holds failed: $e');
      }
    });
  }
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) =>
    serve(handler, ip, port);
