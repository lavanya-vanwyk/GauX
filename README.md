# 🚆 GauX - Solving the 'Last-Mile Problem'

**An FNB App of the Year Hackathon Submission (2026)**

GauX is a modern transit solution designed to solve the "last mile problem" for Gautrain commuters in Gauteng, South Africa. By seamlessly integrating a dedicated micro-fleet ecosystem with a robust digital wallet, GauX ensures that the journey from the station to your final destination (Home, School, or Office) is safe, affordable, and fully tracked.

---

## ✨ Key Features

*   **📍 Live Map & Ride Tracking:** Built with `flutter_map` and OpenStreetMap, featuring drag-to-drop pin mechanics, live vehicle telemetry simulation, and dynamic routing using OSRM.
*   **💳 GauX Digital Wallet:** A fully integrated digital wallet supporting simulated Instant EFT and FNB eWallet top-ups. Deductions are processed in real-time upon trip completion.
*   **🛡️ Smart Geo-Fencing:** Enforces a strict 5km service radius around stations to guarantee micro-fleet availability, reduce wait times, and maximize operational efficiency.
*   **🚗 Pool vs. Private Selection:** Commuters can choose between an eco-friendly flat-rate GauX Pool or a premium distance-based GauX Private ride.
*   **🆘 Discreet SOS System:** A built-in threat mitigation feature allowing users to silently broadcast their telemetry to GauX Security and emergency contacts without alerting the driver.

## 🛠️ Technology Stack

*   **Frontend Framework:** Flutter (Dart)
*   **State Management:** Riverpod 3 (`riverpod_generator`)
*   **Navigation:** `go_router`, with sign-in required for the wallet and ride screens
*   **Models:** `freezed` and `json_serializable`
*   **Mapping & Routing:** `flutter_map`, `latlong2`, OpenStreetMap (OSM), OSRM (Directions API), Nominatim (Geocoding/Search), `geolocator` (nearest station)
*   **Architecture:** Feature-first Clean Architecture. Each feature in `lib/features/` has `domain` (entities, policies, use cases), `data` (models, datasources, repositories), `presentation` and `di` (its providers). Cross-feature wiring lives in `lib/app/`.

## 📁 Repository Layout

| Folder | What it is |
| --- | --- |
| `gau_x/` | The Flutter app |
| `backend/` | The GauX API (Dart Frog): proxies maps and geocoding, serves stations and remote config. See [backend/README.md](backend/README.md) |
| `packages/gaux_contracts/` | Request and response models shared by the app and the API |

`backend/` and `packages/gaux_contracts/` form a Dart pub workspace (root `pubspec.yaml`): run `dart pub get` at the repo root for both. The app isn't part of the workspace, because the Flutter SDK pins test libraries that clash with the backend's. It uses the contracts through a path dependency and has its own lockfile.

## 🚀 Getting Started

### Prerequisites
*   Flutter SDK (latest stable release)
*   Android Studio / VS Code

### Configuration
Build settings are compiled in with `--dart-define-from-file`. There is one file per environment in `gau_x/config/`: `dev.json` (local development), `uat.json` (testing) and `prod.json` (release, demo login off).

| Key | Purpose |
| --- | --- |
| `APP_ENV` | Environment name (`dev`, `uat`, `prod`) |
| `GAUX_API_BASE_URL` | The GauX API. When set, routing, place search, stations and remote config come from it. When empty, the app calls the public services directly and uses bundled stations and default config |
| `NOMINATIM_BASE_URL` | Geocoding endpoint (used when `GAUX_API_BASE_URL` is empty) |
| `OSRM_BASE_URL` | Routing endpoint (used when `GAUX_API_BASE_URL` is empty) |
| `OIDC_ISSUER` | The Keycloak realm riders sign in with. Empty means sign-in isn't available in that build (currently `uat` and `prod`, until Keycloak is deployed) |

Only put non-secret values here: anything compiled into the app can be extracted from it. Running without the flag uses the `dev` defaults.

`GAUX_API_BASE_URL` is empty in every environment until the API is deployed (see [backend/DEPLOY.md](backend/DEPLOY.md)). Until then the app uses the public OpenStreetMap services directly, and those don't allow commercial traffic.

With `GAUX_API_BASE_URL` set, the wallet lives on the server, in an immutable double-entry ledger in Postgres (see [backend/README.md](backend/README.md#the-wallet-ledger)). The server prices each ride when it's confirmed, and that price is what's charged. The app caches the last wallet in secure storage for offline display. Riders sign in with Keycloak: the app opens its login page in the system browser (Authorization Code with PKCE), so passwords never pass through the app. The tokens are kept in secure storage and refreshed automatically. When a ride is confirmed, the fare is held in the wallet and settled on arrival or cancellation. Without the API, the wallet stays on the device as before. All money is integer cents.

Prices, the service-area radius and feature flags (booking, Pool, SOS, top-ups) come from the API's remote config. The app caches the last copy and uses built-in defaults until it has fetched one.

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/gaux-app.git
   ```
2. Navigate to the Flutter app directory:
   ```bash
   cd gaux-app/gau_x
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. After changing any `@freezed` or JSON model, regenerate code (generated files are committed):
   ```bash
   dart run build_runner build
   ```
5. Run the app on a connected emulator or physical device:
   ```bash
   flutter run --dart-define-from-file=config/dev.json
   ```

### 📦 Building for Release (APK)
To generate a fat APK for Android devices, run:
```bash
flutter build apk --release --dart-define-from-file=config/dev.json
```
Use `config/uat.json` or `config/prod.json` for those environments. The prod build turns the demo login off.
*The output will be located at `build/app/outputs/flutter-apk/app-release.apk`.*

## 🧑‍⚖️ Demo Credentials for Judges

To bypass the onboarding flow and jump straight into the GauX Wallet Dashboard, tap **Sign In** and use these credentials on the GauX sign-in page:

*   **Email:** `judge@gaux.co.za`
*   **Password:** `Hackathon2026!`

This account exists in the development Keycloak realm (`backend/dev/keycloak/gaux-realm.json`). It must never be created in a production realm.

---

## 🌍 The Vision

GauX isn't just a ride-hailing app; it is a dedicated transit extension. By restricting our boundaries to 5km and integrating tightly with local financial ecosystems like FNB, we aim to drastically reduce urban congestion, lower the carbon footprint of Gauteng's commuters, and provide a secure extension to the world-class Gautrain service.

*Designed and engineered in Pretoria, South Africa.*
