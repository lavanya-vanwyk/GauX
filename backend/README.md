# GauX API

A [Dart Frog](https://dart-frog.dev) server that sits between the app and third-party services. It:

- Proxies routing (OSRM) and place search (Nominatim), with caching, and spaces out geocoder calls to respect Nominatim's one request per second.
- Rate-limits each client.
- Serves the station list and the remote config document (pricing, service-area radius, feature flags).

Request and response models live in [`packages/gaux_contracts`](../packages/gaux_contracts), shared with the app.

## Endpoints

| Method and path | Purpose |
| --- | --- |
| `GET /` | Health check: `{"status":"ok"}` |
| `GET /v1/route?from=lat,lng&to=lat,lng` | Driving route and its length in metres. `404` if there's no road route |
| `GET /v1/places?q=...&limit=5` | Place search (limit 1–10) |
| `GET /v1/stations` | All Gautrain stations GauX serves |
| `GET /v1/config` | Remote config. Send `If-None-Match` with the last `ETag` to get an empty `304` when unchanged |

Errors use one shape, `{"code": "...", "message": "..."}`, with these codes:
- `bad_request`
- `not_found`
- `rate_limited` (status 429, with a `Retry-After` header)
- `upstream_unavailable` (status 502: OSRM or Nominatim is down)
- `method_not_allowed`

## Running locally

From the repo root, once:

```bash
dart pub get
```

```bash
dart pub global activate dart_frog_cli
```

Then, from `backend/`:

```bash
dart_frog dev
```

The server listens on `http://localhost:8080` and reloads when you save. To point the app at it, add `--dart-define=GAUX_API_BASE_URL=http://10.0.2.2:8080` to `flutter run` (that address is your machine as seen from the Android emulator).

## Configuration

All configuration comes from environment variables and is optional.

| Variable | Default | Purpose |
| --- | --- | --- |
| `PORT` | `8080` | Listening port |
| `OSRM_BASE_URL` | public OSRM demo server | Routing engine |
| `NOMINATIM_BASE_URL` | public Nominatim | Geocoder |
| `UPSTREAM_USER_AGENT` | `GauX-Backend/0.1 (+https://gaux.co.za)` | Sent to OSM services. Their policies require real contact details |
| `REMOTE_CONFIG_PATH` | unset (built-in defaults) | JSON config document; see `config/remote_config.example.json` |
| `RATE_LIMIT_PER_MINUTE` | `120` | Requests per client IP per minute |
| `CACHE_TTL_SECONDS` | `600` | How long route and place results are cached |
| `GEOCODING_MIN_INTERVAL_MS` | `1000` | Minimum gap between geocoder calls |

The config document is read once at startup. Restart the server to publish a change.

## Tests

From `backend/`:

```bash
dart test
```

## Deploying

See [DEPLOY.md](DEPLOY.md).
