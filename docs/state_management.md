# State Management

This template uses GetX for navigation, dependency injection, bindings, and reactive state.

## Core Concepts

## Controller

A controller owns screen state and user actions.

```dart
class LoginController extends BaseController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    await runBusy(() async {
      // call repository here
    });
  }
}
```

## Binding

A binding registers dependencies for a route.

```dart
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginRepository(Get.find()));
    Get.lazyPut(() => LoginController(Get.find()));
  }
}
```

## View

A view builds UI and listens to controller state.

```dart
class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppButton(
        label: 'Login',
        isLoading: controller.isLoading.value,
        onPressed: controller.login,
      );
    });
  }
}
```

## Reactive Variables

Use `.obs` for reactive state:

```dart
final count = 0.obs;
final isEnabled = true.obs;
final items = <String>[].obs;
```

Update values:

```dart
count.value++;
isEnabled.toggle();
items.assignAll(['A', 'B']);
```

Read values in UI with `Obx`:

```dart
Obx(() => Text('${controller.count.value}'))
```

## BaseController

`BaseController` provides:

- `isLoading`
- `errorMessage`
- `runBusy`

Example:

```dart
Future<void> loadData() async {
  await runBusy(() async {
    data.value = await repository.loadData();
  });
}
```

## Rules

- Do not put business logic in widgets.
- Do not create one controller for the whole app.
- Keep each controller focused on one screen or tightly related flow.
- Use services for platform/global behavior.
- Use repositories for data access.
- Dispose `TextEditingController`, `FocusNode`, and subscriptions in `onClose`.
