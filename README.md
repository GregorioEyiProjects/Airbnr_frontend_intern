# Airbnbr

A new Flutter project inspired by Airbnb.

## Overview

This project is a cross-platform mobile and web application built with Flutter. It allows users to browse, favorite, and reserve rooms, with authentication and persistent storage using ObjectBox.

## Airbnb replica


## Features

- User registration and login (email/contact)
- Browse all rooms
- Room details with image carousel
- Add/remove favorite rooms (watchlist)
- Reserve/request to book rooms
- Persistent local storage with ObjectBox
- State management with Provider
- Navigation with GoRouter
- Responsive UI for mobile

## Project Structure

```
lib/
  database/           # API and local DB logic (ObjectBox)
  model/              # Data models (Room, User, FavRoom, etc.)
  provider/           # State management (Provider)
  views/              # UI screens (home, details, register, etc.)
  components/         # Reusable widgets
assets/               # Images, icons, SVGs
android/              # Android platform code
ios/                  # iOS platform code
web/                  # Web platform code
test/                 # Unit and widget tests
```

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart 3.5.4 or compatible (see [`pubspec.yaml`](pubspec.yaml))
- [ObjectBox CLI](https://docs.objectbox.io/getting-started-flutter) (for code generation)
- Firebase project (for authentication)

### Installation

1. **Clone the repository:**
   ```sh
   git clone <your-repo-url>
   cd airbnbr-frontend
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Generate ObjectBox code:**
   ```sh
   flutter pub run build_runner build
   ```

4. **Run the app:**
   - For mobile:
     ```sh
     flutter run
     ```
   - For web:
     ```sh
     flutter run -d chrome
     ```

### Configuration

- Update API endpoints in [`lib/database/db.dart`](lib/database/db.dart) as needed.
- Add your Firebase configuration files for Android/iOS/web.

## Useful Commands

- **Run tests:**
  ```sh
  flutter test
  ```
- **Build for release:**
  ```sh
  flutter build apk   # Android
  flutter build ios   # iOS
  flutter build web   # Web
  ```

## Dependencies

See [`pubspec.yaml`](pubspec.yaml) for the full list, including:
- `provider`
- `go_router`
- `objectbox`
- `firebase_auth`
- `cloud_firestore`
- `another_carousel_pro`
- `google_maps_flutter`
- and more...

## License

This project is for educational purposes.

---

For more details, see the [Flutter documentation](https://docs.flutter.dev/).
