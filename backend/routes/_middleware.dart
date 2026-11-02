import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_backend/gaux_backend.dart';

Handler middleware(Handler handler) => handler
    .use(provider<BackendServices>((_) => backendServices))
    .use(requestLogger());
