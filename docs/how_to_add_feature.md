# How To Add A Feature

This walkthrough creates a generic `articles` feature. Replace `articles` with your real feature name.

## 1. Create Folders

```text
lib/modules/articles/
  bindings/
  controllers/
  repositories/
  views/
```

## 2. Create Repository

```dart
import 'package:getx_template/data/repositories/base_repository.dart';

class ArticlesRepository extends BaseRepository {
  ArticlesRepository(super.apiClient);

  Future<List<Map<String, dynamic>>> fetchArticles() async {
    final response = await apiClient.get<List<dynamic>>('/articles');
    return (response.data ?? [])
        .cast<Map<String, dynamic>>();
  }
}
```

## 3. Create Controller

```dart
import 'package:get/get.dart';
import 'package:getx_template/shared/controllers/base_controller.dart';

class ArticlesController extends BaseController {
  ArticlesController(this._repository);

  final ArticlesRepository _repository;
  final articles = <Map<String, dynamic>>[].obs;

  @override
  void onReady() {
    super.onReady();
    loadArticles();
  }

  Future<void> loadArticles() async {
    await runBusy(() async {
      articles.assignAll(await _repository.fetchArticles());
    });
  }
}
```

## 4. Create Binding

```dart
import 'package:get/get.dart';

class ArticlesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ArticlesRepository(Get.find()));
    Get.lazyPut(() => ArticlesController(Get.find()));
  }
}
```

## 5. Create Screen

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/widgets/app_app_bar.dart';
import 'package:getx_template/widgets/layout/responsive_scaffold.dart';
import 'package:getx_template/widgets/states/empty_state_widget.dart';

class ArticlesScreen extends GetView<ArticlesController> {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      appBar: const AppTopBar(title: 'Articles'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.articles.isEmpty) {
          return EmptyStateWidget(
            title: 'No articles',
            message: 'Articles will appear here.',
            actionLabel: 'Retry',
            onAction: controller.loadArticles,
          );
        }

        return ListView.builder(
          itemCount: controller.articles.length,
          itemBuilder: (context, index) {
            final article = controller.articles[index];
            return ListTile(
              title: Text(article['title']?.toString() ?? 'Untitled'),
            );
          },
        );
      }),
    );
  }
}
```

## 6. Add Route Constant

In `lib/routes/app_routes.dart`:

```dart
static const articles = '/articles';
```

## 7. Register Page

In `lib/routes/app_pages.dart`:

```dart
GetPage(
  name: AppRoutes.articles,
  page: () => const ArticlesScreen(),
  binding: ArticlesBinding(),
),
```

## 8. Navigate To Feature

```dart
Get.toNamed(AppRoutes.articles);
```

## Feature Checklist

- UI is in `views`.
- State and user actions are in `controllers`.
- API/data work is in `repositories`.
- Dependencies are in `bindings`.
- Route is registered in `routes`.
- Reusable UI is moved to `lib/widgets` only when it can help multiple features.
