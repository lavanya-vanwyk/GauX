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
*   **State Management:** Provider
*   **Mapping & Routing:** `flutter_map`, `latlong2`, OpenStreetMap (OSM), OSRM (Directions API), Nominatim (Geocoding/Search)
*   **Architecture:** Feature-first modular architecture (Clean Architecture principles)

## 🚀 Getting Started

### Prerequisites
*   Flutter SDK (latest stable release)
*   Android Studio / VS Code

### Configuration
Build settings are compiled in with `--dart-define-from-file`. `gau_x/config/dev.json` holds the defaults:

| Key | Purpose |
| --- | --- |
| `APP_ENV` | Environment name (`dev`, `uat`, `prod`) |
| `NOMINATIM_BASE_URL` | Geocoding endpoint |
| `OSRM_BASE_URL` | Routing endpoint |
| `DEMO_LOGIN_ENABLED` | Accept the demo judging account. Set to `false` for real releases. |

Only put non-secret values here: anything compiled into the app can be extracted from it. Running without the flag uses the same defaults.

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
*The output will be located at `build/app/outputs/flutter-apk/app-release.apk`.*

## 🧑‍⚖️ Demo Credentials for Judges

To bypass the onboarding flow and jump straight into the GauX Wallet Dashboard, please use the following credentials on the login screen:

*   **Email:** `judge@gaux.co.za`
*   **Password:** `Hackathon2026!`

---

## 🌍 The Vision

GauX isn't just a ride-hailing app; it is a dedicated transit extension. By restricting our boundaries to 5km and integrating tightly with local financial ecosystems like FNB, we aim to drastically reduce urban congestion, lower the carbon footprint of Gauteng's commuters, and provide a secure extension to the world-class Gautrain service.

*Designed and engineered in Pretoria, South Africa.*
