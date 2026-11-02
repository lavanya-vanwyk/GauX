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

## 3. Deploy (Cloud Run example)

```bash
gcloud run deploy gaux-api \
  --source build \
  --region africa-south1 \
  --allow-unauthenticated \
  --set-env-vars UPSTREAM_USER_AGENT="GauX/1.0 (ops@your-domain)"
```

`africa-south1` is Johannesburg, the closest region to riders.

## 4. Point the app at it

Put the service URL in `gau_x/config/uat.json` (and later `prod.json`):

```json
"GAUX_API_BASE_URL": "https://gaux-api-xxxxx.a.run.app"
```

Builds from that file then use the API for routing, place search, stations and remote config. Builds with an empty value keep calling the public services directly.

## Before real traffic

- **Map providers:**
  - The public OSRM demo server and public Nominatim forbid commercial use. Set `OSRM_BASE_URL` and `NOMINATIM_BASE_URL` to a self-hosted instance or a paid provider.
  - The backend is the only place that needs to change. Implement `RoutingProvider` or `GeocodingProvider` for a new vendor.
- **More than one instance:** the cache and the rate limiter are in memory, so each instance keeps its own. Move them to Redis (or similar) before scaling out, or the limits multiply by the number of instances.
- **Client IPs:** behind a load balancer, the rate limiter trusts `X-Forwarded-For`. Only expose the service through that load balancer.
- **Authentication:** the API is open. Add it with real sign-in in Phase 3.
