# Deploying the GauX API

The server builds to a single native binary in a minimal Docker image, so it runs on any container host. The steps below use **Google Cloud Run** as the example, because it scales to zero and has a free tier. Fly.io, Render or a VPS work the same way: build the image, run it, set the environment variables.

Nothing here has been deployed yet. You need an account with the host you choose.

## 1. Build the image

From `backend/`:

```bash
dart_frog build
```

```bash
docker build -t gaux-api build
```

`dart_frog build` writes a self-contained bundle to `build/`. It includes the shared `gaux_contracts` package and the pinned [Dockerfile](Dockerfile).

Check the image locally:

```bash
docker run --rm -p 8080:8080 gaux-api
```

```bash
curl http://localhost:8080/
```

You should get `{"status":"ok"}`.

## 2. Publish the config document

Copy `config/remote_config.example.json`, edit it, and make it available to the container:

- **Cloud Run:** store it as a Secret Manager secret and mount it as a file, e.g. at `/config/remote_config.json`.
- **Docker or a VPS:** use `-v $(pwd)/config:/config:ro`.

Then set `REMOTE_CONFIG_PATH=/config/remote_config.json`. Without it, the server serves built-in defaults, which match the app's current pricing and flags.

To change prices or flip a kill switch, edit the document, bump `version`, and redeploy (or restart). Apps pick up the change on their next launch.

## 3. Create the database

Use a managed Postgres 14+ in the same region, for example Cloud SQL in `africa-south1`, Neon or Supabase. You need two logins:

- **Owner (for migrations):** owns the `gaux` schema and needs `CREATEROLE` the first time, to create the `gaux_api` role.
- **API login (for the server):** a member of `gaux_api`. It can read and append to the ledger but can't edit balances or rows. Create it after the first migration:

```sql
CREATE ROLE gaux_api_login LOGIN PASSWORD '<strong password>' IN ROLE gaux_api;
```

To run that way:

1. Run the migrations once as the owner: start the server with the owner's `DATABASE_URL`, or run the image with it as a one-off job.
2. Run the service as `gaux_api_login` with `MIGRATE_ON_START=false`.

For a single instance, running everything as the owner with migrations on start also works, but you lose the least-privilege protection.

Keep the connection string in a secret (Secret Manager on Cloud Run), never in the image or in `config/`.

## 4. Run Keycloak

Riders sign in with Keycloak. Run it separately from the API, using either a managed Keycloak or the official image on its own service with its own Postgres database. It must be reachable over HTTPS at a stable address, for example `https://auth.gaux.co.za`.

Create the production realm from [`dev/keycloak/gaux-realm.json`](dev/keycloak/gaux-realm.json), with these changes:
- **Delete the `gaux-dev-cli` client.** Its password grant exists only for tests.
- **Delete the judges' demo user.**
- **Configure SMTP,** so registration and password resets can send email.
- **Turn on the realm's security settings:** brute-force protection is already on. Consider requiring email verification, and OTP for staff accounts.

Then set the API's `OIDC_ISSUER` to the realm URL, e.g. `https://auth.gaux.co.za/realms/gaux`. It must match the tokens' `iss` exactly, which is the hostname Keycloak is configured with (`KC_HOSTNAME`).

## 5. Deploy (Cloud Run example)

```bash
gcloud run deploy gaux-api \
  --source build \
  --region africa-south1 \
  --allow-unauthenticated \
  --set-env-vars UPSTREAM_USER_AGENT="GauX/1.0 (ops@your-domain)",MIGRATE_ON_START=false,OIDC_ISSUER=https://auth.gaux.co.za/realms/gaux \
  --set-secrets DATABASE_URL=gaux-database-url:latest
```

Leave `DEV_AUTH` and `SIMULATED_TOPUPS` unset in production. With `DEV_AUTH` on, anyone can act as any rider, and with `SIMULATED_TOPUPS` on, anyone can add free money.

`africa-south1` is Johannesburg, the closest region to riders.

## 6. Point the app at it

Put the API and Keycloak URLs in `gau_x/config/uat.json` (and later `prod.json`):

```json
"GAUX_API_BASE_URL": "https://gaux-api-xxxxx.a.run.app",
"OIDC_ISSUER": "https://auth.gaux.co.za/realms/gaux"
```

Builds from that file then use the API for routing, place search, stations and remote config. Builds with an empty value keep calling the public services directly.

## Before real traffic

- **Map providers:**
  - The public OSRM demo server and public Nominatim forbid commercial use. Set `OSRM_BASE_URL` and `NOMINATIM_BASE_URL` to a self-hosted instance or a paid provider.
  - The backend is the only place that needs to change. Implement `RoutingProvider` or `GeocodingProvider` for a new vendor.
- **More than one instance:** the cache and the rate limiter are in memory, so each instance keeps its own. Move them to Redis (or similar) before scaling out, or the limits multiply by the number of instances.
- **Client IPs:** behind a load balancer, the rate limiter trusts `X-Forwarded-For`. Only expose the service through that load balancer.
- **Authentication:** wallet endpoints require a Keycloak access token. The routing, places, stations and config endpoints are open. Rate limiting is their only protection.
- **Payments:** top-ups are simulated. A real payment provider must confirm money before the ledger credits it.
- **Ledger monitoring:** alert if `SELECT count(*) FROM gaux.account_reconciliation` is ever above zero, and back up the database (point-in-time recovery).
