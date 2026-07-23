# Premium GetX Flutter Boilerplate (Feature-First Architecture)

A production-ready, highly organized Flutter starter template built with **GetX**, **Clean Feature-First Architecture**, **Centralized Dependency Injection**, **Singleton Routing**, high-performance **Singleton Network Clients**, and deeply customizable **Premium Common UI Components**.

This template is meticulously structured for maximum code readability, rapid developer onboarding, and scalability, making it the perfect foundation for any enterprise-grade mobile application.

---

## 🚀 Architectural Overview

We follow an organized, domain-driven **Feature-First Architecture**. All custom UI widgets are unified under a standard **`Common`** design system (replacing standard platform-specific prefixes).

```text
lib/
├── core/                   # App-wide foundations & configurations
│   ├── bindings/           # Centralized global Dependency Injection
│   ├── config/             # App lifecycle observers & configurations
│   ├── constants/          # Static app constants (API, storage keys, colors, strings)
│   ├── errors/             # Global error handling logic & custom exceptions
│   ├── localization/       # Internationalization & translations
│   ├── network/            # Singleton HTTP and WebSocket Clients
│   ├── routing/            # Singleton navigation & routes registration
│   ├── theme/              # Curated light/dark theme config, radius, & typography
│   └── utils/              # Helper utilities
│       ├── extenstion/     # Screen, context, and widget layout extensions
│       └── helper/         # Logger, date formatters, and validators
│
├── component/              # Globally shared, highly customizable Common UI widgets
│   ├── dialogs/            # App dialogs & Common Snackbars
│   ├── layout/             # Lists, Grids, Dropdowns, Radios, Scaffolds, and CommonText
│   ├── loading/            # Common shimmers, page loaders & loading overlays
│   ├── pickers/            # Compressed Multi-Image, Date, Time, and Country pickers
│   └── states/             # Empty, Error, Offline, and Retry state views
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
Global services (like `ConnectivityService` or `SharedPreferencesService`) are registered as permanent dependencies.

```dart
class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.putAsync(() => AppLifecycleObserver().init());
    
    // Services
    Get.lazyPut(() => SharedPreferencesService.instance, fenix: true);
    Get.put(ConnectivityService(), permanent: true);
    Get.put(DialogService(), permanent: true);
    
    // Controllers
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => OnboardingController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
  }
}
```

### 2. Singleton Routing System
All route constants and screen mappings are neatly encapsulated within a single Singleton class in `lib/core/routing/app_routes.dart`. This removes clutter and makes route declaration clean and human-readable.

```dart
GetMaterialApp(
  initialRoute: AppRoutes.splash,
  getPages: AppRoutes.instance.routes,
  unknownRoute: AppRoutes.instance.unknownRoute,
);
```

### 3. High-Performance Network & Connectivity Clients
*   **`ApiClient` (Dio Singleton)**: 
    *   Exposes clean HTTP methods: `.get()`, `.post()`, `.put()`, `.patch()`, `.delete()`.
    *   **Multipart Uploads**: Built-in support for uploading forms/files via `multipartUpload` with progress callbacks.
    *   **Resiliency**: Automatic global API interception, authorization token injection, network logs, and standard `NetworkException` conversion.
*   **`ConnectivityService` (Connection Observer)**:
    *   Listens to dynamic internet status changes.
    *   Exposes reactive boolean status updates using GetX `RxBool` (`isConnected.value`).

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
    
    // Add inside List<GetPage> routes list:
    GetPage(name: chat, page: () => const ChatScreen()),
    ```
3.  **Register the Controller**: Add your controller inside the centralized file `lib/core/bindings/dependency_injection.dart`:
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
        return CommonScaffold(
          appBar: const CommonTopBar(title: 'Chat'),
          body: ...
        );
      }
    }
    ```

---

## 🎨 Common Custom Widgets Encyclopedia

All widgets are prefix-unified under the **`Common`** namespace. They are designed to enforce responsive layouts, dark/light compatibility, and micro-animations.

---

### 📁 Category 1: Form Fields, Inputs & Toggles

#### 1. `CommonButton`
💡 **Purpose**: Custom button supporting Filled, Outlined, and Text styles, leading/trailing icons, and a built-in loading spinner to handle async operations.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `titleText` | `String` | *Required* | Text to display on the button. |
| `onTap` | `VoidCallback?` | `null` | Tap callback. If null, the button is disabled. |
| `isLoading` | `bool` | `false` | Renders a loading spinner and disables taps. |
| `buttonColor` | `Color?` | `AppColors.primary` | Background color. |
| `titleColor` | `Color?` | `Colors.white` | Text color. |
| `buttonRadius` | `double?` | `12.0` | Rounded corners. |
| `buttonWidth` | `double?` | `double.infinity` | Set custom width bounds. |

🚀 **Usage**:
```dart
CommonButton(
  titleText: 'Proceed to Checkout',
  isLoading: controller.isSubmitting.value,
  onTap: () => controller.checkout(),
)
```

#### 2. `CommonTextField`
💡 **Purpose**: Highly customizable input text field component featuring automated password visibility toggles, autofocus, and error border styling.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `controller` | `TextEditingController?` | `null` | Text controller. |
| `label` | `String?` | `null` | Label text shown above. |
| `hint` | `String?` | `null` | Placeholder hint. |
| `obscureText` | `bool` | `false` | Hides input text. |
| `prefixIcon` | `IconData?` | `null` | Leading icon. |
| `validator` | `String? Function(String?)?` | `null` | Validation logic callback. |

🚀 **Usage**:
```dart
CommonTextField(
  label: 'Password',
  hint: 'Enter your password',
  obscureText: controller.obscurePassword.value,
  prefixIcon: Icons.lock_outline,
  validator: (val) => val!.length < 6 ? 'Password is too short' : null,
)
```

#### 3. `Pinput` (OTP Input Field)
💡 **Purpose**: Animated pin entry for OTP/verification screens. Integrates the `pinput` package with custom theme overrides matching the app's visual system.
🚀 **Usage**:
```dart
Pinput(
  length: 6,
  controller: controller.otpController,
  defaultPinTheme: defaultPinTheme,
  focusedPinTheme: focusedPinTheme,
  showCursor: true,
  hapticFeedbackType: HapticFeedbackType.lightImpact,
  keyboardType: TextInputType.number,
)
```

#### 4. `CommonPhoneTextField`
💡 **Purpose**: Input designed specifically for international mobile numbers. It includes a built-in searchable country dialing-prefix selector bottom sheet.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `controller` | `TextEditingController` | *Required* | Phone input controller. |
| `label` | `String` | `'Phone Number'` | Outer label descriptor. |
| `initialCountryCode` | `String` | `'BD'` | Preselected ISO country code. |

🚀 **Usage**:
```dart
CommonPhoneTextField(
  controller: controller.phoneController,
  initialCountryCode: 'BD',
)
```

#### 5. `CommonSearchBar`
💡 **Purpose**: Sleek search panel that manages its own inner controller and includes a one-click trailing "Clear" button.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `onChanged` | `ValueChanged<String>?` | `null` | Triggered on character changes. |
| `hintText` | `String` | `'Search'` | Input placeholder text. |

🚀 **Usage**:
```dart
CommonSearchBar(
  hintText: 'Search items...',
  onChanged: (query) => controller.search(query),
)
```

#### 6. `CommonRatingBar`
💡 **Purpose**: Displays ratings. Supports interactive star-based selection and static, read-only star previews.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `rating` | `double` | *Required* | Rating score to display. |
| `onRatingChanged` | `ValueChanged<double>?` | `null` | Interactive selector callback. If null, becomes read-only. |

🚀 **Usage**:
```dart
CommonRatingBar(
  rating: controller.rating.value,
  onRatingChanged: (newRating) => controller.submitRating(newRating),
)
```

#### 7. `CommonSwitch`
💡 **Purpose**: Premium custom toggle switch featuring smooth spring animation and customizable track/thumb sizes.
🚀 **Usage**:
```dart
CommonSwitch(
  value: controller.isDarkTheme.value,
  onChanged: (status) => controller.changeTheme(status),
)
```

#### 8. `CommonTabBar`
💡 **Purpose**: Animated category sliding selector. Built with custom physics, featuring a beautiful sliding background block indicator.
🚀 **Usage**:
```dart
CommonTabBar(
  tabs: const ['Ongoing', 'Completed', 'Canceled'],
  selectedIndex: controller.activeTab.value,
  onTabChanged: (index) => controller.switchTab(index),
)
```

#### 9. `CommonDropdown<T>`
💡 **Purpose**: Highly styled, customizable dropdown selector wrapper with custom layout themes.
🚀 **Usage**:
```dart
CommonDropdown<String>(
  hint: "Select Option",
  items: ["Option 1", "Option 2", "Option 3"],
  value: controller.selectedOption.value,
  onChanged: (val) => controller.selectedOption.value = val,
)
```

#### 10. `CommonRadio<T>`
💡 **Purpose**: Clean custom radio buttons that enforce visual consistency across Android/iOS platforms.
🚀 **Usage**:
```dart
CommonRadio<int>(
  value: 1,
  groupValue: controller.selectedRadio.value,
  onChanged: (val) => controller.selectedRadio.value = val,
  label: "Male",
)
```

---

### 📁 Category 2: View Layouts, Scaffold & Typography

#### 11. `CommonScaffold`
💡 **Purpose**: Multi-device viewport standardizer. Auto-constrains content width for desktop screens and configures safe-areas and uniform edge padding.
🚀 **Usage**:
```dart
CommonScaffold(
  appBar: const CommonAppBar(title: 'Settings'),
  body: Column(...),
)
```

#### 12. `CommonAppBar`
💡 **Purpose**: Unified Top App Bar that automatically shows back-nav arrow buttons based on navigation history.
🚀 **Usage**:
```dart
CommonAppBar(
  title: 'Edit Profile',
  showBack: true,
)
```

#### 13. `CommonBottomNavBar`
💡 **Purpose**: Premium custom floating bottom navigation bar built with backdrop glassmorphism blurs and animated width-expanding page tab indicators.
🚀 **Usage**:
```dart
CommonScaffold(
  bottomNavigationBar: const CommonBottomNavBar(),
  body: Obx(() => controller.currentPage),
)
```

#### 14. `CommonDrawer`
💡 **Purpose**: Modern navigation drawer supporting profile headers, animated item selected indicators, and link redirections.
🚀 **Usage**:
```dart
CommonScaffold(
  drawer: const CommonDrawer(),
  body: MainContentWidget(),
)
```

#### 15. `CommonText`
💡 **Purpose**: Typography standardization widget. Enforces standard Flutter `TextStyle` styling, font sizing, font weights, and light/dark theme color scaling.
🚀 **Usage**:
```dart
CommonText(
  'User Account Staged',
  style: context.textTheme.headlineMedium,
  fontWeight: FontWeight.bold,
)
```

#### 16. `CommonCard`
💡 **Purpose**: Simple structured wrapper offering standard elevation, borders, padding, and uniform card layout formats.
🚀 **Usage**:
```dart
CommonCard(
  child: Text('Card Content'),
)
```

#### 17. `CommonImage`
💡 **Purpose**: Dynamic multi-source image loader that supports asset images, vector SVGs, and network URLs with automatic caching and shimmers.
🚀 **Usage**:
```dart
CommonImage(
  src: 'https://images.unsplash.com/...',
  height: 200,
  borderRadius: BorderRadius.circular(16),
)
```

#### 18. `CommonSvgIcon`
💡 **Purpose**: Renders asset-based SVG images cleanly, injecting custom colors via single-filter color blending.
🚀 **Usage**:
```dart
CommonSvgIcon(
  asset: 'assets/icons/verified.svg',
  color: Colors.blue,
)
```

#### 19. `CommonListView<T>`
💡 **Purpose**: Scroll list with built-in pull-to-refresh, empty states, and infinite pagination loading indicators.
🚀 **Usage**:
```dart
CommonListView<String>(
  items: controller.itemsList,
  onRefresh: () => controller.refresh(),
  onLoadMore: () => controller.loadNextPage(),
  itemBuilder: (context, item, index) => ListTile(title: Text(item)),
)
```

#### 20. `CommonGridView<T>`
💡 **Purpose**: Lazy-loaded paginated grid built with integrated pull-to-refresh and separation properties.
🚀 **Usage**:
```dart
CommonGridView<String>(
  items: controller.itemsList,
  crossAxisCount: 2,
  itemBuilder: (context, item, index) => GridItem(item),
)
```

---

### 📁 Category 3: Interactive Pickers & Bottom Sheets

#### 21. `CommonCountryPicker`
💡 **Purpose**: Searchable modal bottom sheet selector for global countries, highlighting queries and matching check indicators.
🚀 **Usage**:
```dart
final result = await CommonCountryPicker.show(
  context: context,
  selectedCountryCode: selected?.code,
);
```

#### 22. `CommonDatePicker`
💡 **Purpose**: Premium iOS-style Cupertino date selection wheel in a modern, dark-mode compatible bottom sheet drawer.
🚀 **Usage**:
```dart
final result = await CommonDatePicker.show(
  context: context,
  initialDate: DateTime.now(),
);
```

#### 23. `CommonTimePicker`
💡 **Purpose**: Cupertino hour/minute time wheel inside a modern dark-mode compatible bottom sheet, returning a standard `TimeOfDay`.
🚀 **Usage**:
```dart
final selectedTime = await CommonTimePicker.show(
  context: context,
  initialTime: TimeOfDay.now(),
);
```

#### 24. `CommonMultiImagePicker`
💡 **Purpose**: Compressed multi-file image selector with thumbnail grids, delete hooks, and memory-safe resolution downscaling.
🚀 **Usage**:
```dart
CommonMultiImagePicker(
  maxImages: 5,
  onImagesChanged: (files) => controller.selectedImages.assignAll(files),
)
```

---

### 📁 Category 4: Dialogs & Notifications

#### 25. `CommonDialog`
💡 **Purpose**: Premium alert and choice dialog supporting success, error, warning, info, and confirmation variants.
🚀 **Usage**:
```dart
final confirmed = await CommonDialog.showConfirmation(
  context: context,
  title: 'Delete Item?',
  subtitle: 'Confirm permanent deletion.',
);
```

#### 26. `CommonSnackbar`
💡 **Purpose**: Custom floating alert notification panel built on top of `Get.snackbar` featuring colored feedback bars.
🚀 **Usage**:
```dart
CommonSnackbar.showSuccess(title: 'Success', message: 'Action completed.');
```

#### 27. `LoadingDialog`
💡 **Purpose**: Modal overlay layout that blocks touch gestures during heavy asynchronous processing events.
🚀 **Usage**:
```dart
showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => const LoadingDialog(message: 'Processing...'),
);
```

---

### 📁 Category 5: Loading Indicators, Shimmers & Skeletons

#### 28. `ShimmerBox`
💡 **Purpose**: Core rectangular skeleton block used to create loading placeholder cards.
🚀 **Usage**:
```dart
ShimmerBox(width: 120, height: 16)
```

#### 29. `CommonShimmerCard`
💡 **Purpose**: Pre-formatted card placeholders that match list items layout definitions.
🚀 **Usage**:
```dart
const CommonShimmerCard()
```

#### 30. `LoadingOverlay`
💡 **Purpose**: Translucent full-screen overlay panel showing custom spinner messages.
🚀 **Usage**:
```dart
LoadingOverlay(message: 'Uploading...')
```

#### 31. `PaginationLoader`
💡 **Purpose**: Subtle foot loader shown at list margins during page pagination.
🚀 **Usage**:
```dart
PaginationLoader()
```

---

### 📁 Category 6: Empty, Offline & Error Fallback Views

#### 32. `EmptyStateWidget`
💡 **Purpose**: Fallback illustration displayed when collection elements return empty lists.
🚀 **Usage**:
```dart
EmptyStateWidget(
  title: 'No Data',
  description: 'Try adding elements.',
)
```

#### 33. `ErrorStateWidget`
💡 **Purpose**: Retry illustration display presented when data fetching fails.
🚀 **Usage**:
```dart
ErrorStateWidget(
  errorMessage: 'Something went wrong.',
  onRetry: () => controller.reload(),
)
```

#### 34. `NoInternetWidget`
💡 **Purpose**: View shown automatically when device internet connectivity is offline.
🚀 **Usage**:
```dart
NoInternetWidget(onRetry: () => controller.retry())
```

#### 35. `RetryWidget`
💡 **Purpose**: Simple inline action trigger to re-perform failed processes.
🚀 **Usage**:
```dart
RetryWidget(onRetry: () => controller.retry())
```

---

## 📱 Premium High-Readability Extensions

Unified extension methods reduce widget layout tree nesting:

### 1. Spacing Extensions (`lib/core/utils/extenstion/screen_extensions.dart`)
Append `.height` or `.width` to integers or doubles for responsive layout spacing:
- `16.height` — Responsive `SizedBox(height: 16.h)`
- `24.width` — Responsive `SizedBox(width: 24.w)`

### 2. Context Extensions (`lib/core/utils/extenstion/context_extensions.dart`)
Directly access themes, color schemes, and screen dimension constraints from the current context:
- `context.theme` — Quick access to `Theme.of(context)`
- `context.colorScheme` — Quick access to the color scheme tokens
- `context.screenWidth` — Current display width

### 3. Widget Layout Extensions (`lib/core/utils/extenstion/widget_extensions.dart`)
Add responsiveness, paddings, and alignment inline without wrapping widgets manually:
- `widget.paddingAll(16.h)`
- `widget.paddingSymmetric(horizontal: 20.w)`
- `widget.visible(condition)`

#### Example usage:
```dart
import 'package:getx_template/core/utils/extenstion/screen_extensions.dart';
import 'package:getx_template/core/utils/extenstion/context_extensions.dart';
import 'package:getx_template/core/utils/extenstion/widget_extensions.dart';

@override
Widget build(BuildContext context) {
  return Column(
    children: [
      CommonText(
        'Workspace Settings',
        style: context.textTheme.headlineMedium,
        color: context.colorScheme.primary,
      ),
      12.height,
      CommonText(
        'Subheading',
        style: context.textTheme.bodyMedium,
      ).paddingSymmetric(horizontal: 16.w),
    ],
  );
}
```

---

## 🔐 System Services & Helpers

### 1. System Permissions Utility (`PermissionHelper`)
Managed under `lib/services/permissions/permission_helper.dart`, this helper allows silent checking of permission states before request triggers:
```dart
// Check if access is already granted
final bool isAlreadyGranted = await PermissionHelper.check(Permission.camera);

if (!isAlreadyGranted) {
  // Triggers native system prompt dialog
  final bool status = await PermissionHelper.camera();
  if (!status) {
    // If permanently denied, prompt user to redirect to App System Settings
    await openAppSettings();
  }
}
```

### 2. URL & Intent Launcher Helper (`UrlLauncherHelper`)
Easily trigger email intents, website URLs, and external applications securely:
```dart
UrlLauncherHelper.email("support@example.com");
UrlLauncherHelper.open("https://pub.dev");
```

---

## 🔧 Useful Commands

```bash
# Fetch package dependencies
flutter pub get

# Format your codebase
dart format lib/

# Run static analysis check
flutter analyze

# Launch application on emulator / device
flutter run
```

---
*Happy coding! This template is designed to give you standard-setting performance and premium user experience from day one.*
