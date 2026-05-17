# Premium GetX Flutter Boilerplate (Feature-First Architecture)

A production-ready, highly organized Flutter starter template built with **GetX**, **Clean Feature-First Architecture**, **Centralized Dependency Injection**, **Singleton Routing**, high-performance **Singleton Network Clients**, and deeply customizable **Premium UI Components**.

This template is meticulously structured for maximum code readability, rapid developer onboarding, and scalability, making it the perfect foundation for any enterprise-grade mobile application.

---

## 🚀 Architectural Overview

We have migrated from a traditional, cluttered folder structure to an organized, domain-driven **Feature-First Architecture**.

```text
lib/
├── core/                   # App-wide foundations & configurations
│   ├── bindings/           # Centralized global Dependency Injection
│   ├── config/             # App lifecycle observers & configurations
│   ├── constants/          # Static app constants (API, storage keys, etc.)
│   ├── errors/             # Global error handling logic & custom exceptions
│   ├── localization/       # Internationalization & translations
│   ├── network/            # Singleton HTTP and WebSocket Clients
│   ├── routing/            # Singleton navigation & routes registration
│   ├── theme/              # Curated light/dark design tokens & typography
│   └── utils/              # General helper classes & validators
│
├── component/              # Globally shared, highly customizable UI widgets
│   ├── dialogs/            # App dialogs & custom Snackbars
│   ├── layout/             # Lists, Grids, Dropdowns, Radios, and Scaffolds
│   ├── loading/            # Custom pagination loaders & shimmers
│   ├── pickers/            # Image, Date, Time, and Country pickers
│   └── states/             # Empty, Error, and Retry state views
│
├── features/               # Self-contained modules (domain layers)
│   ├── [feature_name]/     # Example: auth, home, profile
│   │   ├── data/           # Module-specific API integrations & data models
│   │   │   └── model/
│   │   └── screen/         # Flattened UI Presentation Layer
│   │       ├── controller/ # GetX Controllers for state management
│   │       ├── view/       # Screens and Views
│   │       └── widget/     # Widgets exclusive to this feature
```

---

## 📦 Key Core Architectures

### 1. Centralized Global Dependency Injection
All GetX controllers are managed in a single, robust centralized file: `lib/core/bindings/dependency_injection.dart`.
Using `Get.lazyPut(..., fenix: true)` ensures that controllers are memory-efficiently instantiated **only when needed** and automatically recreated when accessed again, eliminating memory leaks.

```dart
class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    // Add new controllers here!
  }
}
```

### 2. Singleton Routing System
All route constants and screen mappings are neatly encapsulated within a single Singleton class in `lib/core/routing/app_routes.dart`. This removes clutter and makes route declaration clean and human-readable.

```dart
// Access routing list directly
GetMaterialApp(
  initialRoute: AppRoutes.splash,
  getPages: AppRoutes.instance.routes,
  unknownRoute: AppRoutes.instance.unknownRoute,
);
```

### 3. High-Performance Singleton Network Clients
The network folder (`lib/core/network/`) features dual premium connection managers:

*   **`ApiClient` (Dio Singleton)**: 
    *   Exposes clean HTTP methods: `.get()`, `.post()`, `.put()`, `.patch()`, `.delete()`.
    *   **Multipart Uploads**: Built-in support for uploading forms/files via `multipartUpload` with real-time progress callbacks.
    *   **Downloads**: Integrated secure `download` helper.
    *   **Resiliency**: Automatic global API interception, authorization token injection, network logs, and standard `NetworkException` conversion.

*   **`SocketClient` (WebSocket/Socket.IO Singleton)**:
    *   Optimized transport connection (`websocket` transport by default).
    *   Built-in reactive status streaming via `connectionStatus` stream.
    *   Streamlined event listening/emission API: `on()`, `off()`, `emit()`, `emitWithAck()`.

---

## 🎨 Premium Reusable Components

All widgets in the `lib/component/` directory have been rewritten to support deep customizability, ensuring they fit any branding instantly.

### 1. Memory-Managed Lists & Grids
To prevent memory issues when dealing with large lists, these widgets strictly utilize lazy rendering.
*   **`AppListView` & `AppGridView`**: 
    *   Memory footprint is kept to $O(1)$ by utilizing `.builder` constructors.
    *   Built-in **pull-to-refresh** wrapper.
    *   Built-in **infinite scroll (pagination)** detection that automatically triggers your `onLoadMore` callback.
    *   Smart custom fallbacks for empty and loading states.

### 2. Picker Components
*   **`AppMultiImagePicker`**: Elegant image wrapper with built-in memory management. Allows selecting multiple photos, automatically resizes/compresses image quality to avoid RAM out-of-memory crashes, and displays them with a custom remove thumbnail UI.
*   **`AppDatePicker` & `AppTimePicker`**: iOS-style Cupertino select wheels wrapped inside modern Material rounded bottom-sheets for a premium hybrid feel.
*   **`AppCountryPicker`**: Searchable bottom-sheet to find countries, complete with country flags, ISO codes, and dialing prefixes.

### 3. Customizable UI Fields & Controls
*   **`AppButton`**: Supports standard, outlined, text button styles, customizable heights, rounded corners, icons (left/right alignment), custom colors, and built-in loading indicator spinner state.
*   **`AppTextField`**: Premium typography styling containing custom borders (enabled, focused, error), custom prefix/suffix icons, hidden text toggles, and validators.
*   **`AppText`**: Unified app typography system supporting pre-configured design variants (`display`, `header`, `title`, `body`, `caption`, `overline`) and standard weights (`light`, `regular`, `medium`, `bold`) with custom font size, color, overflow, alignments, and decoration overrides.
*   **`AppRadio` & `AppMultiRadio`**: Grouped lists of radio selections with active colors, custom text styles, and drag layouts.
*   **`AppDropdown`**: Customized Material design drop-down selection list.

### 4. Custom AppSnackbar
A clean, floating snackbar utilizing `Get.snackbar` to deliver beautiful context-aware alerts.
```dart
AppSnackbar.showSuccess(title: 'Saved', message: 'Profile updated successfully.');
AppSnackbar.showError(title: 'Failed', message: 'Incorrect password entered.');
```

---

## 🚀 How to Add a New Feature

Adding a new module (e.g., `chat`) is extremely simple:

1.  **Create folders**:
    ```text
    lib/features/chat/
    ├── data/
    │   └── model/
    └── screen/
        ├── controller/ (chat_controller.dart)
        ├── view/       (chat_screen.dart)
        └── widget/     (local_widget.dart)
    ```
2.  **Declare routing**: Add your route to `lib/core/routing/app_routes.dart`:
    ```dart
    static const String chat = '/chat';
    
    // Add inside final List<GetPage> routes list:
    GetPage(name: chat, page: () => const ChatScreen()),
    ```
3.  **Register the Controller**: Add your new controller inside the centralized file `lib/core/bindings/dependency_injection.dart`:
    ```dart
    Get.lazyPut(() => ChatController(), fenix: true);
    ```
4.  **Inject the Controller inside your View**:
    ```dart
    class ChatScreen extends StatelessWidget {
      const ChatScreen({super.key});

      @override
      Widget build(BuildContext context) {
        final controller = Get.find<ChatController>();
        return ResponsiveScaffold(
          appBar: const AppTopBar(title: 'Chat'),
          body: ...
        );
      }
    }
    ```

---

## 📱 Premium High-Readability Extensions

We have added unified Dart extensions to make your code extremely clean, concise, flat, and readable.

### 1. Spacing Extensions (`lib/core/utils/screen_extensions.dart`)
Instead of nesting `SizedBox` widgets, append `.height` or `.width` directly to any number:
- `16.height` — Returns a responsive `SizedBox(height: 16.h)`
- `24.width` — Returns a responsive `SizedBox(width: 24.w)`

### 2. Context Extensions (`lib/core/utils/context_extensions.dart`)
Quickly access your Material Design theme, color palettes, and device constraints directly from `context`:
- `context.theme` — Quick access to `Theme.of(context)`
- `context.colorScheme` — Quick access to `Theme.of(context).colorScheme`
- `context.textTheme` — Quick access to `Theme.of(context).textTheme`
- `context.screenWidth` — Device width
- `context.screenHeight` — Device height

### 3. Widget Padding & Layout Extensions (`lib/core/utils/widget_extensions.dart`)
Instantly add responsive paddings or conditional visibility directly inline, avoiding deep layout tree nesting:
- `widget.paddingAll(16.h)` — Wraps with `EdgeInsets.all(16.h)`
- `widget.paddingSymmetric(horizontal: 20.w, vertical: 10.h)` — Wraps with `EdgeInsets.symmetric`
- `widget.visible(isPremiumUser)` — Shows widget only if condition is met

#### Example usage:
```dart
import 'package:getx_template/core/utils/screen_extensions.dart';
import 'package:getx_template/core/utils/context_extensions.dart';
import 'package:getx_template/core/utils/widget_extensions.dart';

@override
Widget build(BuildContext context) {
  return Column(
    children: [
      AppText(
        'Workspace Settings',
        variant: TextVariant.header,
        color: context.colorScheme.primary, // context.colorScheme!
      ),
      12.height, // 12.height spacer!
      const AppText('Subheading', variant: TextVariant.body)
          .paddingSymmetric(horizontal: 16.w), // inline padding!
    ],
  );
}
```

---

## 🔧 Useful Commands

```bash
# Get all package dependencies
flutter pub get

# Format your code layout
dart format lib/

# Check your code for compilation issues or warnings
flutter analyze

# Run your project on a chosen emulator or device
flutter run
```

---
*Happy coding! This premium template is designed to give you standard-setting performance and UI on day one.*
