# Premium GetX Flutter Boilerplate 🚀

[![GetX Boilerplate CLI](https://img.shields.io/pub/v/getx_boilerplate_cli?color=blue&logo=dart&label=getx_boilerplate_cli)](https://pub.dev/packages/getx_boilerplate_cli)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%E2%9D%A4-red.svg?logo=flutter)](https://flutter.dev)

A production-ready, highly organized Flutter starter template built with **GetX**, **Clean Feature-First Architecture**, **Centralized Dependency Injection**, **Singleton Routing**, high-performance **Singleton Network Clients**, and deeply customizable **Premium Common UI Components**.

This template is meticulously structured for maximum code readability, rapid developer onboarding, and scalability, making it the perfect foundation for any enterprise-grade mobile application.

---


## ⚡ Quick Start with CLI

Instead of manual cloning and search-and-replace, you can use our official **GetX Boilerplate CLI** from pub.dev to instantly scaffold a new project with this template, automatically configured with your custom project name:

### 1. Install the CLI globally
```bash
dart pub global activate getx_boilerplate_cli
```

### 2. Scaffold a new project
```bash
getx_boilerplate_cli create my_awesome_app
```

This will automatically:
* Clone the latest template from GitHub.
* Clear git history to start a new project.
* Rename all package imports and declarations from `getx_template` to `my_awesome_app`.
* Run `flutter pub get` so you are ready to code immediately!

---

## 🚀 Architectural Overview

We follow an organized, domain-driven **Feature-First Architecture**. All custom UI widgets are unified under a standard **`Common`** design system (replacing standard platform-specific prefixes).

```text
lib/
├── component/              # Globally shared, highly customizable Common UI widgets
│   ├── dialogs/            # App dialogs & Common Snackbars (e.g. LoadingDialog)
│   ├── layout/             # Scaffolds, dropdowns, lists, radios, grids, and common text
│   ├── loading/            # Common shimmers, page loaders, and loading overlays
│   ├── pickers/            # Multi-image picker, date/time pickers, and country picker
│   └── states/             # Empty, Error, Offline, and Retry state views
│
├── core/                   # Core app configuration and bindings
│   ├── bindings/           # Centralized global Dependency Injection (dependency_injection.dart)
│   ├── config/             # App lifecycle observer and general config
│   ├── localization/       # App translations and locale keys (internationalization)
│   ├── network/            # HTTP client (ApiClient) and WebSocket client (SocketClient)
│   ├── routing/            # Singleton navigation & routes registration (AppRoutes)
│   └── theme/              # Curated light/dark themes, radius, spacing, and typography config
│
├── data/                   # Global data layer
│   ├── models/             # Global data models (e.g. UserModel, PaginatedResponse)
│   └── repositories/       # Central repositories for data and APIs (e.g. AuthRepository)
│
├── features/               # Self-contained modules (feature-first)
│   └── [feature_name]/     # Example: auth, home, profile, settings, splash, message
│       ├── data/           # Data layer for the feature
│       └── presentation/   # Presentation Layer for the feature
│           ├── controller/ # GetX Controllers for feature-specific state management
│           ├── screen/     # Screens and Views for this feature
│           └── widget/     # Reusable widgets specific to this feature
│
├── services/               # Device/system level infrastructure services
│   ├── connectivity/       # Connectivity observer (ConnectivityService)
│   ├── dialog/             # Dialog service (DialogService)
│   ├── firebase/           # Firebase initialization & cloud messaging service
│   ├── launcher/           # URL & intent launcher helper (UrlLauncherHelper)
│   ├── notification/       # Local notifications service
│   ├── permissions/        # Runtime permissions helper (PermissionHelper)
│   ├── pickers/            # Device file picker and image picker helpers
│   └── storage/            # Secure Storage & SharedPreferences services
│
├── shared/                 # Shared logic and controller base classes
│   └── controllers/        # BaseController for features
│
└── utils/                  # Application helper utilities
    ├── app_log/            # Comprehensive logging utilities (Logger, performance logger)
    ├── constants/          # Static app constants (assets, colors, strings, storage keys)
    ├── errors/             # Error exception formatting & global error handling
    ├── extensions/         # Spacing, context, context/widget helpers (screen_extensions, etc.)
    └── helper/             # Date formatters, debouncer, and validators
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
    └── screen/
        ├── controller/ (chat_controller.dart)
        └── view/       (chat_screen.dart)
    ```
    *Note: Global data models or repositories are managed under the central `lib/data/` directory.*
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
          appBar: const CommonAppBar(title: 'Chat'),
          body: ...
        );
      }
    }
    ```

## 🎨 Common Custom Widgets Encyclopedia

All widgets are prefix-unified under the **`Common`** namespace. They are designed to enforce responsive layouts, dark/light compatibility, and micro-animations.

---

### 📁 Category 1: Form Fields, Inputs & Toggles

#### 1. `CommonButton`
💡 **Purpose**: Custom button supporting Filled, Outlined, and Text styles, leading/trailing widgets, gradients, and a built-in loading spinner to handle async operations.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `titleText` | `String` | *Required* | Text to display on the button. |
| `onTap` | `VoidCallback?` | `null` | Tap callback. If null, the button behaves as disabled. |
| `titleColor` | `Color?` | `null` | Text color. |
| `buttonColor` | `Color?` | `null` | Background color. |
| `titleSize` | `double?` | `null` | Font size of the text. |
| `buttonRadius` | `double?` | `null` | Corner rounding radius. |
| `alignment` | `MainAxisAlignment` | `MainAxisAlignment.center` | Horizontal alignment of contents inside the button. |
| `titleWeight` | `FontWeight?` | `null` | Font weight of the text. |
| `buttonHeight` | `double?` | `null` | Custom height constraint. |
| `borderWidth` | `double?` | `null` | Border outline thickness. |
| `isLoading` | `bool` | `false` | Renders a loading spinner and disables taps. |
| `buttonWidth` | `double?` | `null` | Custom width (defaults to `double.infinity`). |
| `borderColor` | `Color?` | `null` | Outline border color. |
| `prefix` | `Widget?` | `null` | General leading widget (e.g. icon). |
| `suffix` | `Widget?` | `null` | General trailing widget (e.g. icon). |
| `elevation` | `double?` | `null` | Shadow elevation. |
| `gradient` | `Gradient?` | `null` | Background gradient decoration. |
| `padding` | `EdgeInsetsGeometry?` | `null` | Custom inner padding. |
| `titleGradient` | `Gradient?` | `null` | Text gradient decoration. |
| `titleSpacing` | `double` | `0.5` | Text letter spacing. |
| `border` | `bool` | `false` | Enforce outline border rendering. |
| `isEnabled` | `bool` | `true` | Enable button interactions. |

🚀 **Usage**:
```dart
CommonButton(
  titleText: 'Proceed to Checkout',
  isLoading: controller.isSubmitting.value,
  onTap: () => controller.checkout(),
)
```

#### 2. `CommonTextField`
💡 **Purpose**: Highly customizable input text field component featuring automated password visibility toggles, autofocus, custom colors, and error border styling.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `label` | `String?` | `null` | Label shown above or floating inside input frame. |
| `hint` | `String?` | `null` | Hint text displayed inside input. |
| `controller` | `TextEditingController?` | `null` | Text controller. |
| `initialValue` | `String?` | `null` | Prepopulated initial text. |
| `validator` | `String? Function(String?)?` | `null` | Text validation callback. |
| `prefixIcon` | `IconData?` | `null` | Leading icon. |
| `suffixIcon` | `IconData?` | `null` | Trailing icon. |
| `obscureText` | `bool` | `false` | Hides input text (e.g. password). |
| `keyboardType` | `TextInputType?` | `null` | Keyboard layout type. |
| `textInputAction` | `TextInputAction?` | `null` | Keyboard action key. |
| `onChanged` | `ValueChanged<String>?` | `null` | Text change callback. |
| `onSubmitted` | `ValueChanged<String>?` | `null` | Submit key action callback. |
| `onTap` | `VoidCallback?` | `null` | Tap callback. |
| `focusNode` | `FocusNode?` | `null` | Custom focus management node. |
| `readOnly` | `bool` | `false` | Is read-only input. |
| `autoFocus` | `bool` | `false` | Is auto-focused. |
| `maxLines` | `int?` | `1` | Maximum lines. |
| `minLines` | `int?` | `null` | Minimum lines. |
| `maxLength` | `int?` | `null` | Character limit. |
| `inputFormatters` | `List<TextInputFormatter>?` | `null` | Input format filtering rules. |
| `textAlign` | `TextAlign` | `TextAlign.start` | Text alignment style. |
| `fillColor` | `Color?` | `null` | Custom background fill color. |
| `filled` | `bool` | `true` | Should background be filled. |
| `borderColor` | `Color?` | `null` | Default outline border color. |
| `focusBorderColor` | `Color?` | `null` | Focused state border color. |
| `errorBorderColor` | `Color?` | `null` | Error state border color. |
| `borderRadius` | `double` | `16.0` | Corner rounding radius. |
| `contentPadding` | `EdgeInsetsGeometry?` | `null` | Inner padding constraints. |
| `textStyle` | `TextStyle?` | `null` | Input text styling. |
| `hintStyle` | `TextStyle?` | `null` | Hint text styling. |
| `labelStyle` | `TextStyle?` | `null` | Label text styling. |
| `errorStyle` | `TextStyle?` | `null` | Error text styling. |
| `prefixWidget` | `Widget?` | `null` | Custom leading widget. |
| `suffixWidget` | `Widget?` | `null` | Custom trailing widget. |
| `textCapitalization` | `TextCapitalization` | `TextCapitalization.none` | Capitalization format. |
| `autocorrect` | `bool` | `true` | Enable device autocorrect. |
| `enableSuggestions` | `bool` | `true` | Show typing suggestions. |
| `autofillHints` | `Iterable<String>?` | `null` | Autofill category prompts. |
| `showPasswordToggle` | `bool` | `true` | Show password hide/reveal suffix icon. |
| `autoValidateMode` | `AutovalidateMode` | `AutovalidateMode.onUserInteraction` | Field validation mode. |

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

#### 3. `CommonPhoneTextField`
💡 **Purpose**: Input designed specifically for international mobile numbers. It includes a built-in searchable country dialing-prefix selector bottom sheet.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `controller` | `TextEditingController` | *Required` | Text controller. |
| `label` | `String` | `'Phone Number'` | Label shown above or inside input frame. |
| `hintText` | `String?` | `null` | Input placeholder. |
| `onChanged` | `ValueChanged<PhoneNumber>?` | `null` | Callback when phone input changes. |
| `onCountryChanged` | `void Function(Country)?` | `null` | Callback when selected country prefix switches. |
| `validator` | `String? Function(PhoneNumber?)?` | `null` | Validation callback. |
| `initialCountryCode` | `String` | `'BD'` | Preselected ISO country code. |
| `fillColor` | `Color?` | `null` | Custom background color. |
| `borderColor` | `Color?` | `null` | Outline border color. |
| `borderRadius` | `double` | `12.0` | Corner rounding radius. |

🚀 **Usage**:
```dart
CommonPhoneTextField(
  controller: controller.phoneController,
  initialCountryCode: 'BD',
)
```

#### 4. `CommonSearchBar`
💡 **Purpose**: Sleek search panel that manages its own inner controller, integrates a built-in debouncer, and includes a one-click trailing "Clear" button.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `controller` | `TextEditingController?` | `null` | Optional text controller. If omitted, a local controller is managed internally. |
| `onChanged` | `ValueChanged<String>?` | `null` | Callback triggered when search text changes (debounced). |
| `onSubmitted` | `ValueChanged<String>?` | `null` | Callback triggered when submit key is pressed. |
| `onCleared` | `VoidCallback?` | `null` | Callback triggered when search input is cleared. |
| `hintText` | `String` | `'Search'` | Hint placeholder text. |
| `debounceMilliseconds` | `int` | `400` | Debounce threshold delay in milliseconds. |
| `backgroundColor` | `Color?` | `null` | Background fill color. |
| `elevation` | `double` | `0.0` | Shadow elevation. |
| `borderRadius` | `double` | `12.0` | Rounding corner radius. |
| `padding` | `EdgeInsetsGeometry?` | `null` | Inner padding. |
| `margin` | `EdgeInsetsGeometry?` | `null` | Outer margin. |
| `width` | `double?` | `null` | Explicit width size. |
| `height` | `double` | `48.0` | Explicit height size. |
| `autoFocus` | `bool` | `false` | Is auto-focused. |
| `enabled` | `bool` | `true` | Enable interactions. |
| `focusNode` | `FocusNode?` | `null` | Custom focus node. |
| `textStyle` | `TextStyle?` | `null` | Text style. |
| `hintStyle` | `TextStyle?` | `null` | Hint text style. |
| `leading` | `Widget?` | `null` | Custom leading widget. |
| `trailing` | `Widget?` | `null` | Custom trailing widget. |

🚀 **Usage**:
```dart
CommonSearchBar(
  hintText: 'Search items...',
  onChanged: (query) => controller.search(query),
)
```

#### 5. `CommonRatingBar`
💡 **Purpose**: Displays ratings. Supports interactive star-based selection and static, read-only star previews.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `rating` | `double` | *Required* | Active rating score (e.g. 4.5). |
| `onRatingChanged` | `ValueChanged<double>?` | `null` | Interactive selection callback. If null, becomes read-only. |
| `itemCount` | `int` | `5` | Total number of rating icons. |
| `size` | `double` | `24.0` | Sizing of each icon. |
| `spacing` | `double` | `4.0` | Spacing between icons. |
| `filledColor` | `Color` | `Colors.amber` | Color of filled icons. |
| `unfilledColor` | `Color` | `const Color(0xFFE0E0E0)` | Color of unfilled/empty icons. |
| `filledIcon` | `IconData` | `Icons.star_rounded` | Icon for filled parts. |
| `unfilledIcon` | `IconData` | `Icons.star_border_rounded` | Icon for unfilled parts. |
| `allowHalf` | `bool` | `true` | Enable half-star selections. |

🚀 **Usage**:
```dart
CommonRatingBar(
  rating: controller.rating.value,
  onRatingChanged: (newRating) => controller.submitRating(newRating),
)
```

#### 6. `CommonSwitch`
💡 **Purpose**: Premium custom toggle switch featuring smooth spring animation and customizable track/thumb sizes.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `value` | `bool` | *Required* | Toggle active status. |
| `onChanged` | `ValueChanged<bool>?` | `null` | Value select callback. If null, switch behaves as disabled. |
| `activeColor` | `Color?` | `null` | Track color when active. |
| `inactiveColor` | `Color?` | `null` | Track color when inactive. |
| `thumbColor` | `Color` | `Colors.white` | Default thumb knob color. |
| `activeThumbColor` | `Color?` | `null` | Thumb knob color when active. |
| `width` | `double?` | `null` | Custom width. |
| `height` | `double?` | `null` | Custom height. |
| `enableHaptic` | `bool` | `true` | Trigger haptic feedback on toggles. |
| `activeThumbIcon` | `Widget?` | `null` | Icon inside thumb when active. |
| `inactiveThumbIcon` | `Widget?` | `null` | Icon inside thumb when inactive. |

🚀 **Usage**:
```dart
CommonSwitch(
  value: controller.isDarkTheme.value,
  onChanged: (status) => controller.changeTheme(status),
)
```

#### 7. `CommonTabBar`
💡 **Purpose**: Animated category sliding selector. Built with custom physics, featuring a beautiful sliding background block indicator.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `tabs` | `List<String>?` | `null` | Simple tab string labels. |
| `tabItems` | `List<CommonTabItem>?` | `null` | Rich tab item models supporting icons and badges. |
| `selectedIndex` | `int` | *Required* | Selected tab index. |
| `onTabChanged` | `ValueChanged<int>` | *Required* | Tab select callback. |
| `height` | `double` | `46.0` | Height of the tab bar. |
| `borderRadius` | `double` | `12.0` | Rounded corner radius. |
| `backgroundColor` | `Color?` | `null` | Container background color. |
| `indicatorColor` | `Color?` | `null` | Indicator sliding background color. |
| `activeTextColor` | `Color?` | `null` | Active tab text color. |
| `inactiveTextColor` | `Color?` | `null` | Inactive tab text color. |
| `borderColor` | `Color?` | `null` | Border outline color. |
| `borderWidth` | `double?` | `null` | Border thickness. |
| `padding` | `EdgeInsetsGeometry?` | `null` | Custom outer padding. |
| `tabStyle` | `CommonTabStyle` | `CommonTabStyle.pill` | Sliding indicator style. |
| `enableHaptic` | `bool` | `true` | Enable haptic feedback. |

🚀 **Usage**:
```dart
CommonTabBar(
  tabs: const ['Ongoing', 'Completed', 'Canceled'],
  selectedIndex: controller.activeTab.value,
  onTabChanged: (index) => controller.switchTab(index),
)
```

#### 8. `CommonDropdown<T>`
💡 **Purpose**: Highly styled, customizable dropdown selector wrapper with custom layout themes.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `items` | `List<T>` | *Required* | Dropdown elements list options. |
| `value` | `T?` | *Required* | Currently selected value. |
| `onChanged` | `void Function(T?)` | *Required* | Value select change callback. |
| `itemBuilder` | `DropdownMenuItem<T> Function(T)` | *Required* | Callback to build each option widget. |
| `label` | `String?` | `null` | Title text shown above. |
| `hint` | `String?` | `null` | Placeholder text. |
| `validator` | `String? Function(T?)?` | `null` | Custom validation callback. |
| `prefixIcon` | `IconData?` | `null` | Leading icon. |
| `fillColor` | `Color?` | `null` | Custom field fill background color. |
| `borderColor` | `Color?` | `null` | Default outline border color. |
| `focusBorderColor` | `Color?` | `null` | Focused state border color. |
| `errorBorderColor` | `Color?` | `null` | Error state border color. |
| `borderRadius` | `double` | `12.0` | Corner radius. |
| `contentPadding` | `EdgeInsetsGeometry?` | `null` | Inner padding. |

🚀 **Usage**:
```dart
CommonDropdown<String>(
  hint: "Select Option",
  items: ["Option 1", "Option 2", "Option 3"],
  value: controller.selectedOption.value,
  onChanged: (val) => controller.selectedOption.value = val,
)
```

#### 9. `CommonRadio<T>`
💡 **Purpose**: Clean custom radio buttons that enforce visual consistency across platforms.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `value` | `T` | *Required* | Value represented by this radio. |
| `groupValue` | `T?` | *Required* | Selected value of the group. |
| `onChanged` | `ValueChanged<T?>` | *Required* | Selected state callback. |
| `title` | `String` | *Required* | Title text label. |
| `subtitle` | `String?` | `null` | Subtitle text description. |
| `activeColor` | `Color?` | `null` | Color when selected. |
| `tileColor` | `Color?` | `null` | Background tile color. |
| `selectedTileColor` | `Color?` | `null` | Selected tile background color. |
| `shape` | `ShapeBorder?` | `null` | Custom border shape. |
| `contentPadding` | `EdgeInsetsGeometry?` | `null` | Inner padding. |

🚀 **Usage**:
```dart
CommonRadio<int>(
  value: 1,
  groupValue: controller.selectedRadio.value,
  onChanged: (val) => controller.selectedRadio.value = val,
  title: "Male",
)
```

---

### 📁 Category 2: View Layouts, Scaffold & Typography

#### 10. `CommonScaffold`
💡 **Purpose**: Multi-device viewport standardizer. Auto-constrains content width for desktop screens and configures safe-areas and uniform edge padding.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `body` | `Widget` | *Required* | Viewport body content. |
| `appBar` | `PreferredSizeWidget?` | `null` | Top navigation app bar. |
| `bottomNavigationBar` | `Widget?` | `null` | Bottom navigation bar. |
| `floatingActionButton` | `Widget?` | `null` | Floating action button. |
| `drawer` | `Widget?` | `null` | Left drawer slide menu. |
| `safeArea` | `bool` | `true` | Enforce rendering within screen safe boundary. |
| `padding` | `EdgeInsetsGeometry` | `const EdgeInsets.all(AppSpacing.md)` | Inner padding surrounding the body. |
| `scaffoldKey` | `GlobalKey<ScaffoldState>?` | `null` | Scaffold key for managing overlay/drawer states. |

🚀 **Usage**:
```dart
CommonScaffold(
  appBar: const CommonAppBar(title: 'Settings'),
  body: Column(...),
)
```

#### 11. `CommonAppBar`
💡 **Purpose**: Unified Top App Bar that automatically shows back-nav arrow buttons based on navigation history.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `title` | `String?` | `null` | Simple title string. |
| `titleWidget` | `Widget?` | `null` | Custom title widget (overrides `title`). |
| `titleStyle` | `TextStyle?` | `null` | Title text styling. |
| `titleWeight` | `FontWeight` | `FontWeight.bold` | Title font weight. |
| `titleColor` | `Color?` | `null` | Title text color. |
| `titleFontSize` | `double?` | `null` | Title font size. |
| `titleSpacing` | `double?` | `null` | Horizontal spacing between leading and title. |
| `centerTitle` | `bool?` | `null` | Force center alignment. |
| `leading` | `Widget?` | `null` | Custom leading widget. |
| `leadingWidth` | `double?` | `null` | Width constraint of leading. |
| `showBack` | `bool` | `true` | Auto-renders back navigate button if nav stack exists. |
| `backButtonWidget` | `Widget?` | `null` | Custom back button replacement widget. |
| `actions` | `List<Widget>?` | `null` | Trailing action list. |
| `backgroundColor` | `Color?` | `null` | Bar background color. |
| `foregroundColor` | `Color?` | `null` | Forefront icons/labels color. |
| `elevation` | `double?` | `null` | Shadow elevation. |
| `scrolledUnderElevation` | `double?` | `null` | Shadow elevation when scroll overlaps. |
| `shadowColor` | `Color?` | `null` | Shadow color. |
| `surfaceTintColor` | `Color?` | `null` | Surface tint overlay. |
| `shape` | `ShapeBorder?` | `null` | Outer border shape. |
| `toolbarHeight` | `double?` | `null` | Sizing height of toolbar. |
| `toolbarTextStyle` | `TextStyle?` | `null` | Text style for toolbar items. |
| `titleTextStyle` | `TextStyle?` | `null` | Text style for appbar title. |
| `padding` | `EdgeInsetsGeometry?` | `null` | Inner padding. |
| `bottom` | `PreferredSizeWidget?` | `null` | Bottom segment widget (e.g. TabBar). |
| `systemOverlayStyle` | `SystemUiOverlayStyle?` | `null` | Status bar overlay configuration. |
| `primary` | `bool` | `true` | Should render inside primary layout. |
| `excludeHeaderSemantics` | `bool` | `false` | Accessibility header check. |
| `forceMaterialTransparency` | `bool` | `false` | Make material background completely transparent. |
| `clipBehavior` | `Clip?` | `null` | Clip behavior style. |

🚀 **Usage**:
```dart
CommonAppBar(
  title: 'Edit Profile',
  showBack: true,
)
```

#### 12. `CommonText`
💡 **Purpose**: Typography standardization widget. Enforces standard Flutter `TextStyle` styling, font sizing, font weights, and light/dark theme color scaling.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `text` | `String` | *Positional, Required* | The text string to display. |
| `style` | `TextStyle?` | `null` | Base text style. |
| `fontWeight` | `FontWeight?` | `null` | Font weight override. |
| `color` | `Color?` | `null` | Font color override. |
| `fontSize` | `double?` | `null` | Font size override. |
| `textAlign` | `TextAlign?` | `null` | Horizontal text alignment style. |
| `maxLines` | `int?` | `null` | Max lines limit. |
| `overflow` | `TextOverflow?` | `null` | Overflow behavior layout (ellipsis, clip, etc.). |
| `height` | `double?` | `null` | Line height multiplier. |
| `fontStyle` | `FontStyle?` | `null` | Font style (italic, normal). |
| `decoration` | `TextDecoration?` | `null` | Decoration line style (underline, strike-through, etc.). |

🚀 **Usage**:
```dart
CommonText(
  'User Account Staged',
  style: context.textTheme.headlineMedium,
  fontWeight: FontWeight.bold,
)
```

#### 13. `CommonCard`
💡 **Purpose**: Simple structured wrapper offering standard elevation, borders, padding, and uniform card layout formats.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `child` | `Widget` | *Required* | Child content widget. |
| `padding` | `EdgeInsetsGeometry?` | `null` | Inner padding. |
| `margin` | `EdgeInsetsGeometry?` | `null` | Outer margin. |
| `color` | `Color?` | `null` | Background fill color. |
| `shadowColor` | `Color?` | `null` | Drop shadow color. |
| `surfaceTintColor` | `Color?` | `null` | Surface tint overlay color. |
| `elevation` | `double?` | `null` | Shadow elevation depth. |
| `borderRadius` | `BorderRadius?` | `null` | Corner rounding radius shape. |
| `borderColor` | `Color?` | `null` | Outline border color. |
| `borderWidth` | `double?` | `null` | Outline border thickness. |
| `shape` | `ShapeBorder?` | `null` | Custom card border shape. |
| `clipBehavior` | `Clip?` | `null` | Clip behavior layout. |
| `width` | `double?` | `null` | Width layout constraint. |
| `height` | `double?` | `null` | Height layout constraint. |
| `gradient` | `Gradient?` | `null` | Background gradient decoration. |
| `onTap` | `VoidCallback?` | `null` | Tap click callback (adds splash ink). |
| `onLongPress` | `VoidCallback?` | `null` | Long press callback. |
| `splashColor` | `Color?` | `null` | Inktap ripple splash color. |

🚀 **Usage**:
```dart
CommonCard(
  child: Text('Card Content'),
)
```

#### 14. `CommonImage`
💡 **Purpose**: Dynamic multi-source image loader that supports asset images, vector SVGs, and network URLs with automatic caching and shimmers.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `src` | `String` | *Required* | Source string for the image (assets, HTTP/HTTPS URLs, and SVGs). |
| `width` | `double?` | `null` | Width layout size. |
| `height` | `double?` | `null` | Height layout size. |
| `fit` | `BoxFit` | `BoxFit.cover` | Image scale fitting style. |
| `borderRadius` | `BorderRadius` | `BorderRadius.zero` | Border corner rounding clip bounds. |

🚀 **Usage**:
```dart
CommonImage(
  src: 'https://images.unsplash.com/...',
  height: 200,
  borderRadius: BorderRadius.circular(16),
)
```

#### 15. `CommonSvgIcon`
💡 **Purpose**: Renders asset-based SVG images cleanly, injecting custom colors via single-filter color blending.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `asset` | `String` | *Required* | File path to the SVG asset. |
| `size` | `double` | `24` | Sizing constraints of the icon width/height. |
| `color` | `Color?` | `null` | Color filter overlay. |
| `semanticLabel` | `String?` | `null` | Optional accessibility semantic label screen-reader text. |

🚀 **Usage**:
```dart
CommonSvgIcon(
  asset: 'assets/icons/verified.svg',
  color: Colors.blue,
)
```

#### 16. `CommonListView<T>`
💡 **Purpose**: Scroll list with built-in pull-to-refresh, empty states, and infinite pagination loading indicators.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `items` | `List<T>` | `const []` | The list of items to render (used in Manual Mode). |
| `itemBuilder` | `Widget Function(BuildContext, T, int)` | *Required* | Callback to build each item widget. |
| `onRefresh` | `Future<void> Function()?` | `null` | Callback triggered on pull-to-refresh swipe. |
| `onLoadMore` | `Future<void> Function()?` | `null` | Callback triggered when list reaches the bottom to load the next page (Manual Mode). |
| `onLoadPage` | `Future<PaginatedResponse<T>?> Function(int page)?` | `null` | Async callback to fetch a specific page of results (Autonomous Mode). |
| `isLoading` | `bool` | `false` | Controls the loading state spinner. |
| `hasMore` | `bool` | `false` | Indicates if there are more items to paginate/load. |
| `enablePagination` | `bool` | `false` | Enforce pagination behavior. |
| `currentPage` | `int?` | `null` | Tracking index page value. |
| `lastPage` | `int?` | `null` | Total pages boundary. |
| `total` | `int?` | `null` | Total elements count. |
| `emptyWidget` | `Widget?` | `null` | Custom replacement fallback widget when items list is empty. |
| `separatorWidget` | `Widget?` | `null` | Custom separator widget between list items. |
| `padding` | `EdgeInsetsGeometry` | `const EdgeInsets.all(16.0)` | List padding margin constraints. |
| `scrollPhysics` | `ScrollPhysics` | `const AlwaysScrollableScrollPhysics()` | Custom scroll physics. |
| `scrollDirection` | `Axis` | `Axis.vertical` | Scroll orientation layout (vertical, horizontal). |

🚀 **Usage**:
```dart
CommonListView<String>(
  items: controller.itemsList,
  onRefresh: () => controller.refresh(),
  onLoadMore: () => controller.loadNextPage(),
  itemBuilder: (context, item, index) => ListTile(title: Text(item)),
)
```

#### 17. `CommonGridView<T>`
💡 **Purpose**: Lazy-loaded paginated grid built with integrated pull-to-refresh and separation properties.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `items` | `List<T>` | *Required* | The list of items to render. |
| `itemBuilder` | `Widget Function(BuildContext, T, int)` | *Required* | Builder function to render each grid item. |
| `crossAxisCount` | `int` | `2` | Number of columns in the grid. |
| `childAspectRatio` | `double` | `1.0` | Ratio of cross-axis to main-axis extent. |
| `crossAxisSpacing` | `double` | `16.0` | Horizontal spacing gap between items. |
| `mainAxisSpacing` | `double` | `16.0` | Vertical spacing gap between items. |
| `onRefresh` | `Future<void> Function()?` | `null` | Pull-to-refresh swipe callback. |
| `onLoadMore` | `Future<void> Function()?` | `null` | Load more scroll callback. |
| `isLoading` | `bool` | `false` | Controls loading state visibility spinner. |
| `hasMore` | `bool` | `false` | Indicates if more elements exist to paginate. |
| `emptyWidget` | `Widget?` | `null` | Fallback view shown when items list is empty. |
| `padding` | `EdgeInsetsGeometry` | `const EdgeInsets.all(16.0)` | Inner grid padding edges. |
| `scrollPhysics` | `ScrollPhysics` | `const AlwaysScrollableScrollPhysics()` | Custom scroll physics. |

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

#### 18. `CommonDatePicker`
💡 **Purpose**: Premium iOS-style Cupertino date selection wheel in a modern, dark-mode compatible bottom sheet drawer.
⚙️ **Parameters (via static method `.show`)**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `context` | `BuildContext` | *Required* | BuildContext scope. |
| `initialDate` | `DateTime?` | `null` | Initially focused date on display. |
| `minimumDate` | `DateTime?` | `null` | Minimum selectable date. |
| `maximumDate` | `DateTime?` | `null` | Maximum selectable date. |
| `title` | `String` | `'Select Date'` | Header title text. |
| `confirmText` | `String` | `'Done'` | Confirmation button text label. |
| `cancelText` | `String` | `'Cancel'` | Cancellation button text label. |
| `confirmColor` | `Color?` | `null` | Color of confirmation button text. |
| `cancelColor` | `Color?` | `null` | Color of cancellation button text. |

🚀 **Usage**:
```dart
final result = await CommonDatePicker.show(
  context: context,
  initialDate: DateTime.now(),
);
```

#### 19. `CommonTimePicker`
💡 **Purpose**: Cupertino hour/minute time wheel inside a modern dark-mode compatible bottom sheet, returning a standard `TimeOfDay`.
⚙️ **Parameters (via static method `.show`)**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `context` | `BuildContext` | *Required* | BuildContext scope. |
| `initialTime` | `TimeOfDay?` | `null` | Initially focused time on display. |
| `title` | `String` | `'Select Time'` | Header title text. |
| `confirmText` | `String` | `'Done'` | Confirmation button text label. |
| `cancelText` | `String` | `'Cancel'` | Cancellation button text label. |
| `confirmColor` | `Color?` | `null` | Color of confirmation button text. |
| `cancelColor` | `Color?` | `null` | Color of cancellation button text. |
| `minuteInterval` | `int` | `1` | The granularity of the minutes selector. |

🚀 **Usage**:
```dart
final selectedTime = await CommonTimePicker.show(
  context: context,
  initialTime: TimeOfDay.now(),
);
```

#### 20. `CommonCountryPicker`
💡 **Purpose**: Searchable modal bottom sheet selector for global countries, highlighting queries and matching check indicators.
⚙️ **Parameters (via static method `.show`)**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `context` | `BuildContext` | *Required* | BuildContext scope. |
| `customCountries` | `List<CountryModel>?` | `null` | Custom list of country options to choose from. |
| `selectedCountryCode` | `String?` | `null` | Country ISO code to prepopulate/select. |
| `title` | `String` | `'Select Country'` | Header title text. |
| `searchHint` | `String` | `'Search by name...'` | Search input field placeholder text. |
| `primaryColor` | `Color?` | `null` | Focus/highlight theme color. |

🚀 **Usage**:
```dart
final result = await CommonCountryPicker.show(
  context: context,
  selectedCountryCode: selected?.code,
);
```

#### 21. `CommonMultiImagePicker`
💡 **Purpose**: Compressed multi-file image selector with thumbnail grids, delete hooks, and memory-safe resolution downscaling.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `onImagesChanged` | `Function(List<File>)` | *Required* | Callback triggered when the list of selected files updates. |
| `initialImages` | `List<File>` | `const []` | Initially prepopulated files list. |
| `maxImages` | `int` | `10` | Maximum image files allowed. |
| `imageQuality` | `int` | `70` | Quality compression factor (1-100) for memory optimization. |
| `maxWidth` | `double` | `1080` | Width boundary scale constraint to compress large images. |
| `maxHeight` | `double` | `1080` | Height boundary scale constraint to compress large images. |
| `crossAxisCount` | `int` | `3` | Grid column layout count. |
| `spacing` | `double` | `8.0` | Grid spacing gap. |
| `imageSize` | `double` | `100.0` | Thumbnail dimension bounding size. |
| `addButtonWidget` | `Widget?` | `null` | Custom replacement widget for the "add image" card. |
| `errorColor` | `Color` | `Colors.red` | Icon and error message highlight color. |

🚀 **Usage**:
```dart
CommonMultiImagePicker(
  maxImages: 5,
  onImagesChanged: (files) => controller.selectedImages.assignAll(files),
)
```

---

### 📁 Category 4: Dialogs & Notifications

#### 22. `CommonDialog`
💡 **Purpose**: Premium alert and choice dialog supporting success, error, warning, info, and confirmation variants.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `title` | `String` | *Required* | Dialog header title. |
| `subtitle` | `String` | *Required* | Dialog detailed message text. |
| `type` | `DialogType` | `DialogType.confirmation` | Dialog type configuration. |
| `image` | `Widget?` | `null` | Optional illustration widget rendered in the header. |
| `icon` | `IconData?` | `null` | Custom icon displayed inside circular background. |
| `iconColor` | `Color?` | `null` | Color overlay of the circular icon. |
| `primaryButtonText` | `String?` | `null` | Label text of the main action button. |
| `secondaryButtonText` | `String?` | `null` | Label text of the secondary/cancel button. |
| `onPrimaryTap` | `VoidCallback?` | `null` | Tap callback of the main action button. |
| `onSecondaryTap` | `VoidCallback?` | `null` | Tap callback of the secondary button. |
| `onClose` | `VoidCallback?` | `null` | Dialog closed hook. |
| `showCloseButton` | `bool` | `true` | Renders a closing top-right cross icon button. |
| `titleFontSize` | `double` | `20` | Font size of the title. |
| `subtitleFontSize` | `double` | `14` | Font size of the subtitle. |
| `titleColor` | `Color?` | `null` | Title color overlay. |
| `subtitleColor` | `Color?` | `null` | Subtitle color overlay. |
| `titleFontWeight` | `FontWeight` | `FontWeight.w600` | Title font weight. |

🚀 **Usage**:
```dart
final confirmed = await CommonDialog.showConfirmation(
  context: context,
  title: 'Delete Item?',
  subtitle: 'Confirm permanent deletion.',
);
```

#### 23. `CommonSnackbar`
💡 **Purpose**: Custom floating alert notification panel built on top of `Get.snackbar` featuring colored feedback bars.
⚙️ **Parameters (via static method `.show`)**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `title` | `String` | *Required* | Snackbar header label. |
| `message` | `String` | *Required* | Detail description body text. |
| `type` | `SnackbarType` | `SnackbarType.info` | Accent style type (success, error, warning, info). |
| `position` | `SnackPosition` | `SnackPosition.TOP` | Layout positioning anchor. |
| `duration` | `Duration` | `const Duration(seconds: 3)` | Visible duration time span. |
| `icon` | `Widget?` | `null` | Custom icon prefix. |
| `isDismissible` | `bool` | `true` | Swipe to dismiss active. |

🚀 **Usage**:
```dart
CommonSnackbar.showSuccess(title: 'Success', message: 'Action completed.');
```

#### 24. `LoadingDialog`
💡 **Purpose**: Modal overlay layout that blocks touch gestures during heavy asynchronous processing events.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `message` | `String` | *Required* | Processing message text. |

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

#### 25. `ShimmerBox`
💡 **Purpose**: Core rectangular skeleton block used to create loading placeholder cards.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `width` | `double?` | `null` | Width of the skeleton block. |
| `height` | `double?` | `null` | Height of the skeleton block. |
| `borderRadius` | `double` | `8` | Corner rounding radius of the skeleton block. |

🚀 **Usage**:
```dart
ShimmerBox(width: 120, height: 16)
```

#### 26. `CommonShimmerCard`
💡 **Purpose**: Pre-formatted card placeholders that match list items layout definitions.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `width` | `double?` | `null` | Custom width of the card. |
| `height` | `double?` | `null` | Custom height of the card. |
| `borderRadius` | `double` | `16.0` | Corner radius of the card frame. |
| `padding` | `EdgeInsetsGeometry?` | `null` | Inner padding. |
| `showImage` | `bool` | `true` | Whether to render a simulated top image skeleton. |
| `imageHeight` | `double` | `140.0` | Height of the simulated image skeleton. |
| `showAvatar` | `bool` | `true` | Whether to render a simulated circular avatar skeleton. |
| `avatarRadius` | `double` | `20.0` | Radius of the circular avatar skeleton. |
| `lineCount` | `int` | `2` | Number of text line skeleton blocks to render in the card. |

🚀 **Usage**:
```dart
const CommonShimmerCard()
```

#### 27. `LoadingOverlay`
💡 **Purpose**: Translucent full-screen overlay panel showing custom spinner messages.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `isLoading` | `bool` | *Required* | Controls the visibility of the overlay spinner. |
| `child` | `Widget` | *Required* | Underlying content widget wrapped by the overlay. |
| `message` | `String` | `'Loading...'` | Informational loading text message. |

🚀 **Usage**:
```dart
LoadingOverlay(message: 'Uploading...')
```

#### 28. `PaginationLoader`
💡 **Purpose**: Subtle foot loader shown at list margins during page pagination.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `isLoading` | `bool` | `true` | Controls if the load indicator is shown. |

🚀 **Usage**:
```dart
PaginationLoader()
```

---

### 📁 Category 6: Empty, Offline & Error Fallback Views

#### 29. `EmptyStateWidget`
💡 **Purpose**: Fallback illustration displayed when collection elements return empty lists.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `title` | `String` | `'Nothing here yet'` | Empty view title. |
| `message` | `String` | `'Content will appear here when it becomes available.'` | Description body. |
| `actionLabel` | `String?` | `null` | Action button text. |
| `onAction` | `VoidCallback?` | `null` | Action button tap callback. |

🚀 **Usage**:
```dart
EmptyStateWidget(
  title: 'No Data',
  description: 'Try adding elements.',
)
```

#### 30. `ErrorStateWidget`
💡 **Purpose**: Retry illustration display presented when data fetching fails.
⚙️ **Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `title` | `String` | `'Something went wrong'` | Error view title. |
| `message` | `String` | `'Please try again in a moment.'` | Description body. |
| `onRetry` | `VoidCallback?` | `null` | Retry action button tap callback. |

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

### 1. Spacing Extensions (`lib/utils/extensions/screen_extensions.dart`)
Append `.height` or `.width` to integers or doubles for responsive layout spacing:
- `16.height` — Responsive `SizedBox(height: 16.h)`
- `24.width` — Responsive `SizedBox(width: 24.w)`

### 2. Context Extensions (`lib/utils/extensions/context_extensions.dart`)
Directly access themes, color schemes, screen dimension constraints, and custom colors from the current context:
- `context.theme` — Quick access to `Theme.of(context)`
- `context.colorScheme` — Quick access to the color scheme tokens
- `context.screenWidth` — Current display width
- `context.appColors` — Access custom, theme-adaptive colors directly (e.g., `context.appColors.primary`, `context.appColors.background`, `context.appColors.red`). Colors automatically switch between light and dark modes!

#### 🎨 Widget Color Usage Example:
You can style any widget's color, text, or icon dynamically depending on the current theme (Light/Dark mode) by passing `context.appColors.<color_name>`:

```dart
import 'package:your_project_name/utils/extensions/context_extensions.dart';

@override
Widget build(BuildContext context) {
  return CommonScaffold(
    appBar: CommonAppBar(
      title: 'Home',
      titleColor: context.appColors.primary, // Green in Light, Bright Green in Dark
      leading: Icon(
        Icons.menu,
        color: context.appColors.primary, 
      ),
    ),
    body: Container(
      color: context.appColors.background, // Light slate in Light, Dark slate in Dark
      child: Column(
        children: [
          CommonCard(
            color: context.appColors.surface, // White in Light, Dark slate card in Dark
            child: CommonText(
              "Welcome to the App!",
              color: context.appColors.text, // Dark text in Light, White text in Dark
            ),
          ),
          CommonButton(
            buttonColor: context.appColors.primary,
            titleText: "Proceed",
          ),
        ],
      ),
    ),
  );
}
```

### 3. Widget Layout Extensions (`lib/utils/extensions/widget_extensions.dart`)
Add responsiveness, paddings, and alignment inline without wrapping widgets manually:
- `widget.paddingAll(16.h)`
- `widget.paddingSymmetric(horizontal: 20.w)`
- `widget.visible(condition)`

#### Example usage:
```dart
import 'package:getx_template/utils/extensions/screen_extensions.dart';
import 'package:getx_template/utils/extensions/context_extensions.dart';
import 'package:getx_template/utils/extensions/widget_extensions.dart';

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

## 🛠️ Core Services, Helpers, Themes & Shared Controllers

### 📁 Category 1: Services (`lib/services/`)

#### 1. `SharedPreferencesService` (Local Key-Value persistence)
💡 **Purpose**: Singleton service to easily persist primitive values and serialize/deserialize complete model instances locally.
🚀 **Usage**:
```dart
// Fetch the singleton instance
final storage = SharedPreferencesService.instance;

// Store and retrieve primitives
await storage.setBool('is_first_time', false);
final bool? isFirstTime = storage.getBool('is_first_time');

// Serialize/Save custom models
await storage.saveUser(currentUserModel);

// Fetch custom models (returns UserModel?)
final user = storage.getUser();
```

#### 2. `SecureStorageService` (Encrypted Storage)
💡 **Purpose**: Encrypted storage interface to safely store sensitive keys like JWT access tokens using Android Keystore and iOS Keychain.
🚀 **Usage**:
```dart
final secureStorage = SecureStorageService();

// Write a secret key
await secureStorage.write('auth_token', 'ey...xT');

// Read a secret key
final String? token = await secureStorage.read('auth_token');

// Delete keys
await secureStorage.delete('auth_token');
```

#### 3. `DialogService`
💡 **Purpose**: A centralized service (extends `GetxService`) accessible via controllers to trigger app-wide Snackbars, confirm dialogs, loaders, and bottom sheets without requiring BuildContext.
🚀 **Usage**:
```dart
final dialogService = Get.find<DialogService>();

// Trigger floating loader overlay
dialogService.showLoading(message: 'Processing checkout...');

// Hide loader overlay
dialogService.hideLoading();

// Show alert dialogs
dialogService.showError(message: 'Invalid email format.');
dialogService.showSuccess(title: 'Updated', message: 'Profile changed successfully.');
```

---

### 📁 Category 2: Utility Helpers & Validators (`lib/utils/helper/`)

#### 1. `Validators`
💡 **Purpose**: Enforces email validation logic, field requirements, and password security bounds within Form Field inputs.
🚀 **Usage**:
```dart
CommonTextField(
  label: 'Email',
  validator: Validators.email,
);

CommonTextField(
  label: 'Password',
  validator: Validators.password,
);
```

#### 2. `DateFormatter`
💡 **Purpose**: Thread-safe date formatting mapping using the `intl` package formatters.
🚀 **Usage**:
```dart
// Returns standard dates format (e.g., Jul 26, 2026)
final String displayDate = DateFormatter.date(DateTime.now());

// Returns API-compliant format (e.g., 2026-07-26)
final String apiFormat = DateFormatter.apiDate(DateTime.now());
```

#### 3. `Debouncer`
💡 **Purpose**: Standardize call thresholds for search queries, preventing excessive database/network requests on text input change events.
🚀 **Usage**:
```dart
final _debouncer = Debouncer(delay: const Duration(milliseconds: 500));

void onSearchQueryChanged(String query) {
  _debouncer.call(() {
    controller.fetchSearchResults(query);
  });
}
```

---

### 📁 Category 3: Base Controller (`lib/shared/controllers/`)

#### 1. `BaseController`
💡 **Purpose**: Abstract base controller class extending `GetxController` providing standard reactive states (`isLoading`, `errorMessage`) and automatic asynchronous wrapper execution.
🚀 **Usage**:
```dart
class ProfileController extends BaseController {
  Future<void> updateProfile() async {
    // Automatically sets isLoading to true, clears errors, runs the task,
    // catches exceptions into errorMessage, and sets isLoading to false at the end.
    await runWithLoading(() async {
      await apiRepository.sendProfileData();
    });
  }
}
```

---

### 📁 Category 4: App Theme System (`lib/core/theme/`)

#### 1. Theme Configuration
💡 **Purpose**: Centralized themes providing consistent design patterns (light/dark colors, spacing tokens, border radiuses, and standard typographies) using Material 3 seed color palettes.
🚀 **Usage**:
```dart
GetMaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  themeMode: ThemeMode.system,
);
```
* **Radius Constants:** Ensure consistent rounded corners by using standard tokens from `AppRadius` (e.g., `AppRadius.md` is `12.0`).
* **Spacing Constants:** Use standardized margins/paddings from `AppSpacing` (e.g., `AppSpacing.md` is `16.0`).

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
