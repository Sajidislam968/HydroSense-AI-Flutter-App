# HydroSense AI — Flutter App

Flutter (Material 3) UI prototype for HydroSense AI, an intelligent hydroponic
monitoring platform. It demonstrates sensor dashboards, analytics, growth
predictions, alerts, node management, and profile settings using sample data.

## Getting started

```bash
flutter pub get
flutter analyze
```

Requires Flutter 3.19+ (Dart 3.3+).

This source snapshot does not include Android, iOS, web, or desktop platform
folders. To run it on Android or iOS, generate the native project files first:

```bash
flutter create --platforms=android,ios .
flutter run
```

## Folder structure

```
lib/
 ├── main.dart                    # App entry point, MaterialApp + theme
 ├── theme/
 │    └── app_theme.dart          # Color tokens, ThemeData (Material 3)
 ├── models/
 │    └── models.dart             # AlertItem, NodeInfo, Severity enum
 ├── widgets/                     # Reusable components
 │    ├── sensor_card.dart        # Live sensor reading card (grid tile)
 │    ├── status_pill.dart        # Color-coded status chip
 │    ├── dashboard_card.dart     # Generic elevated rounded card
 │    ├── custom_button.dart      # Primary / outline / text button
 │    └── bottom_nav.dart         # Shared BottomNavigationBar + badge
 └── screens/
      ├── splash_screen.dart      # Animated splash → Login
      ├── login_screen.dart       # Demo sign-in screen
      ├── home_screen.dart        # HomeShell (bottom nav host) + Home dashboard
      ├── analytics_screen.dart   # Range toggle, sensor charts
      ├── prediction_screen.dart  # AI growth gauge, confidence, recs
      ├── alerts_screen.dart      # Severity-filtered alert list
      ├── sensor_detail_screen.dart # Per-sensor gauge + trend + stats
      ├── nodes_screen.dart       # Connected ESP32 nodes
      └── profile_screen.dart     # Account, preferences, logout
test/
 └── sensor_detail_screen_test.dart # Per-sensor reading widget test
```

## Navigation

- `SplashScreen` → auto-navigates to `LoginScreen` after ~2.2s.
- `LoginScreen` → on submit, pushes `HomeShell` (replaces stack).
- `HomeShell` hosts **Home / Analytics / Prediction / Alerts / Profile**
  behind one `BottomNavBar`, using `IndexedStack` to preserve each tab's
  scroll position and state.
- `SensorDetailScreen` and `ConnectedNodesScreen` are pushed on top of the
  shell (e.g. tapping a sensor card, or "Device Management" in Profile).

## Notes for integration

- This is a UI prototype, not a production-ready app. Sensor readings,
  predictions, alerts, account details, and node status are static sample data.
- Login, Google sign-in, password recovery, account creation, profile
  preferences, and node management are not connected to backend services.
  Connect authentication and your ESP32 cloud API before using real accounts
  or devices.
- Run the widget tests with `flutter test`.
- Charts are drawn with lightweight `CustomPainter`s (no chart package
  dependency) — swap in `fl_chart` or `syncfusion_flutter_charts` if you
  need interactivity/tooltips.
- Color tokens and radii live in `lib/theme/app_theme.dart` — update
  `AppColors`/`AppRadius` to re-skin the whole app consistently.
## Output
<img width="328" height="744" alt="image" src="https://github.com/user-attachments/assets/67a2a376-2301-42c7-a0b3-4ac8f9e2f04d" />
<img width="328" height="744" alt="image" src="https://github.com/user-attachments/assets/3c84e0f6-6c35-44c5-8f79-c03c88c475e2" />



