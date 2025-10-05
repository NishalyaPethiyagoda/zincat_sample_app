# zincat_sample_app

A small Flutter blog-post sample app. It fetches posts and comments from a JSON placeholder API and demonstrates a simple BLoC + Repository architecture and a centralized navigation helper.

This README explains how to set up the project locally, run it, and troubleshoot common issues.

## Prerequisites

- Flutter SDK (the project requests `sdk: ^3.9.2` in `pubspec.yaml`). Install from https://flutter.dev.
- Git (to clone the repository).
- An editor such as VS Code or Android Studio with Flutter and Dart plugins.

Tested on: Android (developer environment)

## Quick start

1. Clone the repo:

```powershell
git clone https://github.com/NishalyaPethiyagoda/zincat_sample_app.git
cd zincat_sample_app
```

2. Get dependencies:

```powershell
flutter pub get
```

3. Run the app (example - Android emulator or connected device):

```powershell
flutter run
```

## What the project contains

- `lib/main.dart` — application entry. The app uses a navigator helper and bloc providers.
- `lib/navigation/global_navigator.dart` — centralized navigator 
- `lib/network/http_methods.dart` — small HTTP helper that calls `https://jsonplaceholder.typicode.com`.
- `lib/screens/home` — home screen + BLoC + repository for loading posts.
- `lib/screens/blog_detail` — blog detail screen + BLoC + repository for displaying post and comments.
- `lib/widgets` — reusable widgets such as `BlogDashboardCard` and `CustomPopup`.

The app follows a lightweight Repository + BLoC pattern. Network code is in `HttpMethods`, repositories call it and return typed models, and BLoCs manage UI state.

## Developer notes

dependencies.
- API base URL is defined in `lib/network/http_methods.dart` as `https://jsonplaceholder.typicode.com`.