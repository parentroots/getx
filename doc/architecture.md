# Architecture

This template uses a practical Clean Architecture style with feature-first organization.

## Layers

## Presentation

Presentation code lives inside each module:

```text
lib/modules/<feature>/views
lib/modules/<feature>/controllers
lib/modules/<feature>/bindings
```

Views build widgets. Controllers hold state and user actions. Bindings register dependencies for routes.

## Data

Data access belongs in repositories and services.

```text
lib/modules/<feature>/repositories
lib/core/network
lib/services
lib/data
```

Repositories call APIs, map responses, and hide persistence details from controllers.

## Core

Core contains infrastructure used across the whole app:

```text
lib/core/constants
lib/core/errors
lib/core/extensions
lib/core/network
lib/core/utils
```

Core must stay generic. Do not put feature-specific business rules here.

## Rules

- Views do not call APIs.
- Views do not write directly to storage.
- Controllers do not know Dio details.
- Repositories do not show snackbars or dialogs.
- Bindings own dependency registration.
- Shared widgets must be reusable across app domains.
- Feature-specific code stays inside its feature module.

## Request Flow

```text
View -> Controller -> Repository -> ApiClient -> Backend
View <- Controller <- Repository <- ApiClient <- Backend
```

Example:

```dart
class ProfileController extends BaseController {
  ProfileController(this._repository);

  final ProfileRepository _repository;
  final profile = Rxn<Profile>();

  Future<void> loadProfile() async {
    await runWithLoading(() async {
      profile.value = await _repository.getProfile();
    });
  }
}
```

The controller manages loading/error state. The repository handles the API.

## Dependency Injection

Global services are registered in `lib/bindings/initial_binding.dart`.

Feature dependencies are registered in each feature binding:

```dart
class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileRepository(Get.find()));
    Get.lazyPut(() => ProfileController(Get.find()));
  }
}
```

This keeps features lazy and prevents unnecessary objects from being created at app startup.
