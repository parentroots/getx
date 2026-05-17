# How To Use This Template

This guide explains the normal workflow after cloning the template for a new Flutter app.

## 1. Clone The Template

```bash
git clone https://github.com/your-username/getx_template.git my_new_app
cd my_new_app
```

If you use GitHub's "Use this template" button, create a new repository from it, then clone that new repository.

## 2. Install Dependencies

```bash
flutter pub get
```

If dependencies fail to resolve, check your Flutter and Dart versions:

```bash
flutter --version
```

The template is designed for modern Flutter and Dart 3.

## 3. Run The App

```bash
flutter run
```

The first screen is `SplashScreen`. It decides whether to show onboarding or the authentication welcome screen.

## 4. Rename The App

Update:

- `pubspec.yaml` project `name`
- `lib/app/app_config.dart` default `appName`
- Android application id and Kotlin package
- iOS/macOS bundle identifiers
- App display names for each platform

After renaming, run:

```bash
flutter clean
flutter pub get
flutter run
```

## 5. Set Environment Values

Use Dart defines:

```bash
flutter run --dart-define=API_BASE_URL=https://api.example.com
```

The value is read in `lib/app/app_config.dart`.

## 6. Start Building Your App

Create one module per feature under `lib/modules`.

Example:

```text
lib/modules/payments/
  bindings/payments_binding.dart
  controllers/payments_controller.dart
  repositories/payments_repository.dart
  views/payments_screen.dart
```

## Where Things Go

- Write UI in `views`.
- Write screen state and button actions in `controllers`.
- Write API calls in `repositories`.
- Register controllers/repositories in `bindings`.
- Put reusable UI in `lib/widgets`.
- Put app-wide services in `lib/services`.
- Put theme tokens in `lib/theme`.

## Beginner Mental Model

A screen should ask the controller what to show. The controller should ask a repository or service for data. The repository should use `ApiClient` for network calls. This keeps UI, logic, and data access separate.
