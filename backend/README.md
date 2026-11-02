# GauX API

A [Dart Frog](https://dart-frog.dev) server that sits between the app and third-party services. It:

- Holds the rider wallet in an immutable double-entry ledger in Postgres (see [The wallet ledger](#the-wallet-ledger)).
- Prices rides itself, so riders are charged what the server quoted.
- Proxies routing (OSRM) and place search (Nominatim), with caching, and spaces out geocoder calls to respect Nominatim's one request per second.
- Rate-limits each client.
- Serves the station list and the remote config document (pricing, service-area radius, feature flags).

Request and response models, and the fare rules, live in [`packages/gaux_contracts`](../packages/gaux_contracts), shared with the app.

## Endpoints

| Method and path | Sign-in | Purpose |
| --- | --- | --- |
| `GET /` | | Health check: `{"status":"ok"}` |
| `GET /v1/route?from=lat,lng&to=lat,lng` | | Driving route and its length in metres. `404` if there's no road route |
| `GET /v1/places?q=...&limit=5` | | Place search (limit 1–10) |
| `GET /v1/stations` | | All Gautrain stations GauX serves |
| `GET /v1/config` | | Remote config. Send `If-None-Match` with the last `ETag` to get an empty `304` when unchanged |
| `POST /v1/quotes` | ✓ | Prices a ride from a station. The server works out the route and fare and checks the service area. Quotes can be charged for 6 hours |
| `GET /v1/wallet` | ✓ | Balance and the 20 most recent entries. Opens the wallet with R350 welcome credit on first use |
| `POST /v1/wallet/holds` | ✓ | Reserves a quote's fare when the ride is confirmed. Needs an `Idempotency-Key` header. `402` if the wallet can't cover it |
| `POST /v1/wallet/holds/release` | ✓ | Returns a hold because the ride was cancelled before pickup. Needs an `Idempotency-Key` header |
| `POST /v1/wallet/charges` | ✓ | Charges a quote: the full fare, or a partial fare for a cancellation, settling from its hold when there is one. Response includes `chargedCents`. Needs an `Idempotency-Key` header |
| `POST /v1/wallet/topups` | ✓ | Adds funds. Needs an `Idempotency-Key` header. Simulated; off unless `SIMULATED_TOPUPS=true` |

All money is integer cents (ZAR).

**Signing in:** riders sign in with Keycloak, and the app sends the access token as `Authorization: Bearer <token>`. The server checks the token's RS256 signature against Keycloak's published keys (fetched and cached, and re-fetched when Keycloak rotates keys), then its issuer, its `gaux-api` audience and its expiry. The rider's ID is the token's `sub`, and wallets are keyed by it.

For local work, `DEV_AUTH=true` also accepts `Authorization: Bearer dev:<user-id>`. Anyone can claim any user that way, so never enable it in production.

**Retries:** a charge or top-up sent again with the same `Idempotency-Key` returns the original result instead of applying twice. The app keys ride charges by quote (`ride:<quote-id>`), so a quote can never be charged twice.

Errors use one shape, `{"code": "...", "message": "..."}`:

| Code | Status | Meaning |
| --- | --- | --- |
| `bad_request` | 400 | Malformed input, or a missing `Idempotency-Key` |
| `unauthorized` | 401 | Not signed in |
| `insufficient_funds` | 402 | The wallet can't cover the charge |
| `not_found` | 404 | Unknown quote, or no road route |
| `idempotency_conflict` | 409 | The key was used for a different request, or the quote was already charged |
| `quote_expired` | 410 | Request a new quote |
| `outside_service_area` | 422 | Not from a GauX station, or too far from it |
| `rate_limited` | 429 | Comes with a `Retry-After` header |
| `upstream_unavailable` | 502 | OSRM or Nominatim is down |
| `service_unavailable` | 503 | No wallet database, top-ups disabled, or booking paused by the kill switch |
| `method_not_allowed` | 405 | |

## The wallet ledger

Money is never stored as a single editable balance. Each movement is a **journal entry** with two or more **postings** that sum to zero. A R29.18 ride, for example, posts −2918 to the rider's wallet and +2918 to platform revenue. The database itself enforces the rules, so a bug in the server can't break them:

- **Balanced:** a deferred trigger rejects, at commit, any entry whose postings don't sum to zero.
- **Immutable:** triggers reject `UPDATE`, `DELETE` and `TRUNCATE` on entries and postings. Mistakes are fixed with a reversing entry (`LedgerService.reverse`), and the original stays in the ledger.
- **No overdrafts:** each account's cached `balance_cents` is maintained by a trigger, and a `CHECK` constraint rejects any rider wallet below zero.
- **Holds:** confirming a ride moves the fare into the `rider_holds` account, so it can't be spent elsewhere mid-ride. On arrival or cancellation one entry settles it: the fee to revenue and any remainder back to the wallet. A release returns it in full. Holds whose quote has expired are released whenever that rider next uses the wallet, and by a sweep every 5 minutes. The `rider_holds` balance always equals the total of open holds.
- **Serialised per wallet:** every operation that moves money first locks the rider's wallet row (`SELECT … FOR UPDATE`). Two simultaneous charges therefore can't both spend the same rand, and a retry always finds the first attempt's entry.
- **Least privilege:** the API's database role (`gaux_api`) can only read and insert. It can't edit balances or ledger rows.
- **Auditable:** the `gaux.account_reconciliation` view lists any account whose cached balance disagrees with its postings. It should always be empty; monitor it.

The schema lives in [`lib/src/db/migrations.dart`](lib/src/db/migrations.dart). Migrations are applied at startup under an advisory lock. Never edit a migration that has shipped; add a new one.

## Running locally

From the repo root, once:

```bash
dart pub get
```

```bash
dart pub global activate dart_frog_cli
```

### Database

You need Postgres 14 or later. With Postgres installed locally, create a development role and two databases, `gaux_dev` for running the server and `gaux_test` for the tests:

```bash
sudo -u postgres psql -c "CREATE ROLE gaux_dev LOGIN PASSWORD 'gaux_dev' CREATEROLE"
```

```bash
sudo -u postgres createdb -O gaux_dev gaux_dev
```

```bash
sudo -u postgres createdb -O gaux_dev gaux_test
```

Or with Docker:

```bash
docker run -d --name gaux-postgres -p 5432:5432 -e POSTGRES_USER=gaux_dev -e POSTGRES_PASSWORD=gaux_dev -e POSTGRES_DB=gaux_dev postgres:16
```

```bash
docker exec gaux-postgres createdb -U gaux_dev gaux_test
```

### Keycloak

The dev realm in [`dev/keycloak/gaux-realm.json`](dev/keycloak/gaux-realm.json) is loaded at start-up. It has:
- **`gaux-app`:** the app's client, which only allows browser sign-in with PKCE.
- **`gaux-api`:** the audience the server checks for.
- **`gaux-dev-cli`:** a password-grant client for tests and curl. Dev only: never create it in a production realm.
- **The judges' account:** `judge@gaux.co.za` / `Hackathon2026!`.

From `backend/`:

```bash
docker run -d --name gaux-keycloak -p 8180:8080 -e KC_BOOTSTRAP_ADMIN_USERNAME=admin -e KC_BOOTSTRAP_ADMIN_PASSWORD=admin -e KC_HOSTNAME=http://localhost:8180 -v "$PWD/dev/keycloak:/opt/keycloak/data/import:ro" quay.io/keycloak/keycloak:26.4 start-dev --import-realm
```

The first start takes a minute or two. The admin console is at `http://localhost:8180/admin` (admin / admin). Restart the container after editing the realm file only if the realm doesn't exist yet: imports skip realms that already exist. To start over, `docker rm -f gaux-keycloak` and run the command again.

To get a token from the command line:

```bash
curl -s -d grant_type=password -d client_id=gaux-dev-cli -d username=judge@gaux.co.za -d 'password=Hackathon2026!' http://localhost:8180/realms/gaux/protocol/openid-connect/token
```

### Server

From `backend/`:

```bash
DATABASE_URL="postgresql://gaux_dev:gaux_dev@localhost:5432/gaux_dev?sslmode=disable" OIDC_ISSUER=http://localhost:8180/realms/gaux SIMULATED_TOPUPS=true dart_frog dev
```

The server listens on `http://localhost:8080` and reloads when you save.

### The app against your machine

Tokens name `http://localhost:8180` as their issuer, so the app has to reach Keycloak at that exact address. With a phone (USB) or emulator connected, forward both ports:

```bash
adb reverse tcp:8180 tcp:8180
```

```bash
adb reverse tcp:8080 tcp:8080
```

Then run the app from `gau_x/`:

```bash
flutter run --dart-define-from-file=config/dev.json --dart-define=GAUX_API_BASE_URL=http://localhost:8080
```

Debug builds allow plain `http` to `localhost` only; release builds require HTTPS.

## Configuration

All configuration comes from environment variables and is optional.

| Variable | Default | Purpose |
| --- | --- | --- |
| `PORT` | `8080` | Listening port |
| `DATABASE_URL` | unset | Postgres for the wallet ledger. Wallet and quote endpoints answer 503 without it |
| `MIGRATE_ON_START` | `true` | Apply pending migrations at startup |
| `OIDC_ISSUER` | unset | Keycloak realm URL, e.g. `https://auth.gaux.co.za/realms/gaux`. Must match tokens' `iss` exactly. Without it (or `DEV_AUTH`) nobody can sign in |
| `OIDC_AUDIENCE` | `gaux-api` | Client ID that tokens must name in `aud` |
| `OIDC_JWKS_URL` | issuer's standard Keycloak path | Where to fetch signing keys, if the server reaches Keycloak by another address |
| `DEV_AUTH` | `false` | Also accept `Bearer dev:<user-id>` tokens. **Development only** |
| `SIMULATED_TOPUPS` | `false` | Allow top-ups without a payment provider |
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

The ledger and wallet route tests need Postgres. They use `TEST_DATABASE_URL`, defaulting to the local `gaux_test` database above, and they reset the `gaux` schema in that database. The Keycloak tests need the dev Keycloak running (`TEST_OIDC_ISSUER`, defaulting to `http://localhost:8180/realms/gaux`). To skip either:

```bash
dart test -x postgres -x keycloak
```

## Deploying

See [DEPLOY.md](DEPLOY.md).
