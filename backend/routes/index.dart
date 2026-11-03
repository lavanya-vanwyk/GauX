import 'package:dart_frog/dart_frog.dart';

/// Health check for load balancers and uptime monitors.
Response onRequest(RequestContext context) =>
    Response.json(body: {'status': 'ok'});
