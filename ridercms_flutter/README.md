# Ridercms Flutter App

A Flutter port of the Ridercms battery charging app — a complete mobile app for finding, charging, and collecting batteries at Ridercms stations.

## Screens

| Screen | File | Route |
|--------|------|-------|
| Onboarding / Splash | `lib/screens/splash_screen.dart` | `/` |
| Login / Sign Up | `lib/screens/login_screen.dart` | `/login` |
| Dashboard | `lib/screens/dashboard_screen.dart` | `/dashboard` |
| Find a Booth (Map) | `lib/screens/map_screen.dart` | `/map` |
| Scan Battery | `lib/screens/scan_screen.dart` | `/scan` |
| Slot Assigned | `lib/screens/slot_assigned_screen.dart` | `/slot-assigned` |
| Charging Session | `lib/screens/charging_screen.dart` | `/charging` |
| Battery Ready | `lib/screens/battery_ready_screen.dart` | `/battery-ready` |
| Payment | `lib/screens/payment_screen.dart` | `/payment` |
| Payment Processing | `lib/screens/payment_processing_screen.dart` | `/payment-processing` |
| Payment Success | `lib/screens/payment_success_screen.dart` | `/payment-success` |
| Collect Batteries | `lib/screens/collect_screen.dart` | `/collect` |
| Session Complete | `lib/screens/session_complete_screen.dart` | `/session-complete` |

## Tech Stack

- **Framework**: Flutter 3.x (Dart)
- **State Management**: `setState` (built-in)
- **Navigation**: Named routes via `MaterialApp`
- **Styling**: Custom theme in `lib/theme.dart`

## Color Palette

| Name | Hex |
|------|-----|
| Primary (Green) | `#00C896` |
| Primary Dark | `#00A87A` |
| Accent (Blue) | `#3B82F6` |
| Warning (Amber) | `#F59E0B` |
| Danger (Red) | `#EF4444` |
| Background Dark | `#0A0F1E` |
| Card Background | `#111827` |

## Getting Started

### Prerequisites

1. Install Flutter SDK: https://docs.flutter.dev/get-started/install
2. Install Android Studio or Xcode (for iOS)
3. Run `flutter doctor` to verify setup

### Run the App

```bash
# Navigate to the flutter project
cd ridercms_flutter

# Get dependencies
flutter pub get

# Run on connected device or emulator
flutter run

# Build for Android
flutter build apk

# Build for iOS
flutter build ios
```

## Project Structure

```
ridercms_flutter/
├── lib/
│   ├── main.dart              # App entry point + routes
│   ├── theme.dart             # Colors, theme data
│   ├── widgets/
│   │   └── common_widgets.dart  # Reusable widgets
│   └── screens/
│       ├── splash_screen.dart
│       ├── login_screen.dart
│       ├── dashboard_screen.dart
│       ├── map_screen.dart
│       ├── scan_screen.dart
│       ├── slot_assigned_screen.dart
│       ├── charging_screen.dart
│       ├── battery_ready_screen.dart
│       ├── payment_screen.dart
│       ├── payment_processing_screen.dart
│       ├── payment_success_screen.dart
│       ├── collect_screen.dart
│       └── session_complete_screen.dart
├── android/
│   └── app/
│       ├── build.gradle
│       └── src/main/AndroidManifest.xml
└── pubspec.yaml
```

## User Flow

```
Splash → Login → Dashboard
                    ↓
              Find Booth (Map)
                    ↓
              Scan Battery
                    ↓
              Slot Assigned (door opens)
                    ↓
              Charging Session (live timer)
                    ↓
              Battery Ready (notification)
                    ↓
              Payment (M-Pesa / Card / Wallet)
                    ↓
              Payment Processing
                    ↓
              Payment Success (doors open)
                    ↓
              Collect Batteries
                    ↓
              Session Complete
```
