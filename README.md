# 🚆 GauX - Solving the 'Last-Mile Problem'

**An FNB App of the Year Hackathon Submission (2026)**

GauX is a modern transit solution designed to solve the "last mile problem" for Gautrain commuters in Gauteng, South Africa. By seamlessly integrating a dedicated micro-fleet ecosystem with a robust digital wallet, GauX ensures that the journey from the station to your final destination (Home, School, or Office) is safe, affordable, and fully tracked.

> **🏗️ Architectural Note to Judges:**
> While exploring the codebase, you will encounter several placeholder files containing `TODO(MVP)` comments (particularly within the `domain` and `data` layers). To prioritize rapid UI prototyping and core functionality for this hackathon MVP, we intentionally condensed some of the logic. However, these files serve as intentional **Clean Architecture & Domain-Driven Design (DDD) scaffolding**. They demonstrate our concrete roadmap for decoupling logic, writing unit tests, and scaling GauX into a secure, production-grade enterprise application post-hackathon.

## ✨ Key Features

* **📍 Live Map & Ride Tracking:** Built with `flutter_map` and OpenStreetMap, featuring drag-to-drop pin mechanics, live vehicle telemetry simulation, and dynamic routing using OSRM.

* **💳 GauX Digital Wallet:** A fully integrated digital wallet supporting simulated Instant EFT and FNB eWallet top-ups. Deductions are processed in real-time upon trip completion.

* **🛡️ Smart Geo-Fencing:** Enforces a strict 5km service radius around stations to guarantee micro-fleet availability, reduce wait times, and maximize operational efficiency.

* **🚗 Pool vs. Private Selection:** Commuters can choose between an eco-friendly flat-rate GauX Pool or a premium distance-based GauX Private ride.

* **🆘 Discreet SOS System:** A built-in threat mitigation feature allowing users to silently broadcast their telemetry to GauX Security and emergency contacts without alerting the driver.

## 🛠️ Technology Stack

* **Frontend Framework:** Flutter (Dart)

* **State Management:** Provider

* **Mapping & Routing:** `flutter_map`, `latlong2`, OpenStreetMap (OSM), OSRM (Directions API), Nominatim (Geocoding/Search)

* **Architecture:** Feature-first modular architecture (Clean Architecture principles)

## 🚀 Getting Started

### Prerequisites

* Flutter SDK (latest stable release)

* Android Studio / VS Code

* A valid `.env` file in the root directory (see Environment Setup).

### Environment Setup

Create a `.env` file in the root of the project and add the following variable:

```
NOMINATIM_BASE_URL=https://nominatim.openstreetmap.org/search

```

### Installation

1. Clone the repository:

   ```
   git clone https://github.com/yourusername/gaux-app.git
   
   ```

2. Navigate to the project directory:

   ```
   cd gaux-app
   
   ```

3. Install dependencies:

   ```
   flutter pub get
   
   ```

4. Run the app on a connected emulator or physical device:

   ```
   flutter run
   
   ```

### 📦 Building for Release (APK)

To generate a fat APK for Android devices, run:

```
flutter build apk --release

```

*The output will be located at `build/app/outputs/flutter-apk/app-release.apk`.*

## 🧑‍⚖️ Demo Credentials for Judges

To bypass the onboarding flow and jump straight into the GauX Wallet Dashboard, please use the following credentials on the login screen:

* **Email:** `judge@gaux.co.za`

* **Password:** `Hackathon2026!`

## 🌍 The Vision

GauX isn't just a ride-hailing app; it is a dedicated transit extension. By restricting our boundaries to 5km and integrating tightly with local financial ecosystems like FNB, we aim to drastically reduce urban congestion, lower the carbon footprint of Gauteng's commuters, and provide a premium, secure extension to the world-class Gautrain service.

*Designed and engineered in Pretoria, South Africa.*
