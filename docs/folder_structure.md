# Folder Structure

The project is organized for long-term growth.

```text
lib/
  app/
  bindings/
  core/
  data/
  localization/
  modules/
  routes/
  services/
  shared/
  theme/
  utils/
  widgets/
```

## app

App shell and configuration.

- `app.dart`: `GetMaterialApp` setup
- `app_config.dart`: app name, API base URL, feature flags
- `app_lifecycle_observer.dart`: app lifecycle hooks

## bindings

Global dependency injection.

- `initial_binding.dart`: registers services used across the app

## core

Reusable infrastructure.

- `constants`: app constants and keys
- `errors`: exception and global error handling
- `extensions`: Dart and Flutter extensions
- `network`: Dio client, interceptors, token manager, network info
- `utils`: validators, logger, dates, debounce

## data

Shared data abstractions.

- `models`: generic models such as pagination wrappers
- `repositories`: base repository contracts

## localization

Translation keys and maps.

Use this when adding multilingual support with GetX translations.

## modules

Feature-first app modules.

Each module should normally contain:

```text
bindings/
controllers/
views/
repositories/
models/
```

Only add folders the feature actually needs.

## routes

Named route constants and page registration.

- `app_routes.dart`: route names
- `app_pages.dart`: route-to-screen mapping

## services

App-wide services, usually wrappers around plugins or platform capabilities.

Examples:

- connectivity
- dialogs
- Firebase
- notifications
- permissions
- file/image pickers
- storage
- launchers

## shared

Shared controllers and contracts.

`BaseController` provides loading and error state helpers.

## theme

Design system tokens.

- colors
- typography
- spacing
- radius
- dimensions
- light/dark theme

## utils

Cross-cutting helpers that are not widgets and not services.

## widgets

Reusable UI primitives.

Examples:

- `AppButton`
- `AppTextField`
- `AppCard`
- `AppNetworkImage`
- `LoadingOverlay`
- `EmptyStateWidget`
- `ErrorStateWidget`
- `NoInternetWidget`
