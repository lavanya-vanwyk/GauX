# gaux_contracts

Request and response models for the GauX API, shared by the app (`gau_x/`) and the backend (`backend/`) so the two can't drift apart.

- `GeoPoint`: a coordinate on the wire.
- `RouteResponse`, `PlacesResponse`, `StationsResponse`: booking endpoints.
- `RemoteConfig`: pricing, service area and feature flags. Every field has a default, so older apps and newer documents (and the reverse) stay compatible.
- `ApiError`: the body of every error response.

After changing a model, regenerate code from this folder:

```bash
dart run build_runner build
```

Then run the tests:

```bash
dart test
```
