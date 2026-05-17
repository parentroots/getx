# GetX Template

A GitHub-ready, production-focused Flutter starter template built with GetX, Clean Architecture ideas, feature-first modules, reusable UI, dependency injection, theming, networking, storage, Firebase-ready bootstrap, and app-level utilities.

This is not a demo app. It is a neutral foundation you can clone for any future product.

## Why This Exists

Most new Flutter apps need the same infrastructure before real product work can start: routing, theme, API client, storage, reusable widgets, error states, loading states, dialogs, and a module pattern. This template gives you that foundation on day one so you can start building features immediately.

## Quick Start

1. Clone the repository.

```bash
git clone https://github.com/your-username/getx_template.git my_new_app
cd my_new_app
```

2. Install dependencies.

```bash
flutter pub get
```

3. Run the app.

```bash
flutter run
```

4. Set an API base URL when needed.

```bash
flutter run --dart-define=API_BASE_URL=https://api.example.com
```

## Rename App And Package

Update these places when cloning for a real app:

- `pubspec.yaml`: change `name` and `description`
- Android package: `android/app/build.gradle.kts` and `android/app/src/main/kotlin/...`
- iOS bundle id: Xcode project settings
- App display names in Android/iOS/macOS/windows folders
- `lib/app/app_config.dart`: default `appName`

You can also use a package rename tool, then review generated platform changes before committing.

## Where To Write Code

- UI screens: `lib/modules/<feature>/views`
- Page logic/state: `lib/modules/<feature>/controllers`
- Dependency setup for a feature: `lib/modules/<feature>/bindings`
- API repositories: `lib/modules/<feature>/repositories` or shared bases in `lib/data/repositories`
- Global API client/interceptors: `lib/core/network`
- Reusable widgets: `lib/widgets`
- Theme tokens: `lib/theme`
- App services: `lib/services`
- Routes: `lib/routes`

## Create A New Module

Example feature named `articles`:

```text
lib/modules/articles/
  bindings/articles_binding.dart
  controllers/articles_controller.dart
  repositories/articles_repository.dart
  views/articles_screen.dart
```

Add a route constant:

```dart
abstract final class AppRoutes {
  static const articles = '/articles';
}
```

Register the page:

```dart
GetPage(
  name: AppRoutes.articles,
  page: () => const ArticlesScreen(),
  binding: ArticlesBinding(),
),
```

## Controller + Binding Example

```dart
class ArticlesController extends BaseController {
  ArticlesController(this._repository);

  final ArticlesRepository _repository;
  final articles = <Article>[].obs;

  Future<void> loadArticles() async {
    await runBusy(() async {
      articles.assignAll(await _repository.fetchArticles());
    });
  }
}

class ArticlesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ArticlesRepository(Get.find()));
    Get.lazyPut(() => ArticlesController(Get.find()));
  }
}
```

## API Repository Example

```dart
class ArticlesRepository extends BaseRepository {
  ArticlesRepository(super.apiClient);

  Future<List<Article>> fetchArticles() async {
    final response = await apiClient.get<List<dynamic>>('/articles');
    return (response.data ?? [])
        .map((item) => Article.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
```

## Snackbar, Dialog, And Storage

```dart
Get.find<DialogService>().showSnack(
  title: 'Saved',
  message: 'Your changes were saved.',
);

final confirmed = await Get.find<DialogService>().confirm(
  title: 'Delete item',
  message: 'This action cannot be undone.',
);

await Get.find<SharedPreferencesService>().setBool('seen_intro', true);
await Get.find<TokenManager>().saveTokens(accessToken: token);
```

## Architecture Rules

- Keep screens focused on UI composition.
- Put state and user actions in controllers.
- Put API and persistence logic in repositories/services.
- Register dependencies in bindings.
- Keep shared widgets generic and app-agnostic.
- Add business-specific code inside the module that owns it.
- Do not put API calls directly in widgets.
- Do not create giant controllers; split feature services or repositories when logic grows.

## Documentation

- [How to use the template](docs/how_to_use_template.md)
- [Architecture](docs/architecture.md)
- [Folder structure](docs/folder_structure.md)
- [How to add a feature](docs/how_to_add_feature.md)
- [Networking](docs/networking.md)
- [State management](docs/state_management.md)
- [Theme system](docs/theme_system.md)

## Useful Commands

```bash
dart format lib test
flutter analyze
flutter test
flutter run --dart-define=API_BASE_URL=https://api.example.com
```

## Firebase

Firebase is intentionally ready but not locked to any project. Configure it only when your app needs Firebase:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Then update `lib/services/firebase/firebase_service.dart` to use the generated `firebase_options.dart`.
