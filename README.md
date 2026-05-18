# Premium GetX Flutter Boilerplate (Feature-First Architecture)

A production-ready, highly organized Flutter starter template built with **GetX**, **Clean Feature-First Architecture**, **Centralized Dependency Injection**, **Singleton Routing**, high-performance **Singleton Network Clients**, and deeply customizable **Premium Common UI Components**.

This template is meticulously structured for maximum code readability, rapid developer onboarding, and scalability, making it the perfect foundation for any enterprise-grade mobile application.

---

## 🚀 Architectural Overview

We have migrated from a traditional, cluttered folder structure to an organized, domain-driven **Feature-First Architecture**. All custom UI widgets have been unified under a standard **`Common`** design system (replacing standard platform-specific prefixes).

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
The network folder (`lib/core/network/`) features dual connection managers:

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
        return CommonScaffold(
          appBar: const CommonTopBar(title: 'Chat'),
          body: ...
        );
      }
    }
    ```

---

## 🎨 Common Custom Widgets Encyclopedia

All widgets in this boilerplate are prefix-unified under the **`Common`** namespace. They are meticulously designed to enforce standard-setting premium aesthetics (responsive widths, dark/light modes, premium micro-animations, and robust memory handling).

---

### 📁 Group A: Core Form Fields & Inputs

#### 1. `CommonButton`
💡 **Purpose**: A deeply customisable button supporting three visual styles (Filled, Outlined, Text), custom icons (leading/trailing), and a built-in loading spinner to handle async operations.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `onPressed` | `VoidCallback?` | *Required* | Tap callback. If null or `isLoading` is true, button is disabled. |
| `label` | `String?` | `null` | Label text. Either `label` or `child` must be provided. |
| `isLoading` | `bool` | `false` | When true, renders a centered progress spinner. |
| `isOutlined` | `bool` | `false` | Renders with an elegant thin border matching the accent color. |
| `isTextButton` | `bool` | `false` | Renders a borderless text-only button. |
| `backgroundColor` | `Color?` | Primary theme | Background fill color when filled. |
| `borderRadius` | `double` | `12.0` | Custom rounding radius. |

🚀 **Usage Snippet**:
```dart
CommonButton(
  label: 'Proceed to Checkout',
  isLoading: controller.isSubmitting.value,
  iconRight: const Icon(Icons.arrow_forward, color: Colors.white),
  onPressed: () => controller.checkout(),
)
```

---

#### 2. `CommonTextField`
💡 **Purpose**: The main text entry component offering custom round borders, automated focus indicators, error style maps, and helper toggles (e.g. password fields).
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `controller` | `TextEditingController?` | `null` | Field text controller. |
| `label` | `String?` | `null` | Floating label text. |
| `hint` | `String?` | `null` | Placeholder background hint. |
| `obscureText` | `bool` | `false` | Hides input text (for passwords). |
| `prefixIcon` | `IconData?` | `null` | Leading icon shown inside the frame. |
| `suffixIcon` | `IconData?` | `null` | Trailing icon shown inside the frame. |
| `validator` | `String? Function(String?)?` | `null` | Validation logic callback. |

🚀 **Usage Snippet**:
```dart
CommonTextField(
  label: 'Password',
  hint: 'Enter your account password',
  obscureText: controller.isPasswordHidden.value,
  prefixIcon: Icons.lock_outline,
  suffixWidget: IconButton(
    icon: Icon(controller.isPasswordHidden.value ? Icons.visibility : Icons.visibility_off),
    onPressed: () => controller.togglePasswordVisibility(),
  ),
  validator: (val) => val!.length < 6 ? 'Password is too short' : null,
)
```

---

#### 3. `CommonPhoneTextField`
💡 **Purpose**: Premium input designed specifically for international mobile numbers. It includes a built-in searchable country dialing-prefix selector bottom sheet and active regex validations based on the chosen country prefix.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `controller` | `TextEditingController` | *Required* | Phone input controller. |
| `label` | `String` | `'Phone Number'` | Outer label descriptor. |
| `initialCountryCode` | `String` | `'BD'` | ISO 2-letter code to pre-select. |
| `onCountryChanged` | `ValueChanged<CountryPhoneCode>?` | `null` | Triggers when the chosen country prefix changes. |

🚀 **Usage Snippet**:
```dart
CommonPhoneTextField(
  controller: controller.phoneController,
  initialCountryCode: 'BD',
  onChanged: (phone) => print("Current Input: $phone"),
  onCountryChanged: (country) => print("Dial Code: ${country.dialCode}"),
)
```

---

#### 4. `CommonSearchBar`
💡 **Purpose**: Stateful, sleek search panel that manages its own inner controller (or accepts a parent controller) and includes a one-click trailing "Clear" button.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `controller` | `TextEditingController?` | `null` | Parent controller to listen to query. |
| `onChanged` | `ValueChanged<String>?` | `null` | Callback triggered on character changes. |
| `hintText` | `String` | `'Search'` | Input placeholder text. |

🚀 **Usage Snippet**:
```dart
CommonSearchBar(
  hintText: 'Search products...',
  onChanged: (query) => controller.filterProducts(query),
)
```

---

#### 5. `CommonRatingBar`
💡 **Purpose**: Displays ratings with pixel-perfect accuracy. Supports both interactive star-based selection (with click/tap detection) and static, fractional read-only star previews.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `rating` | `double` | *Required* | Value to preview (e.g. `4.5` rating). |
| `onRatingChanged` | `ValueChanged<double>?` | `null` | Active selection handler. If null, becomes READ-ONLY. |
| `itemCount` | `int` | `5` | Total stars to display. |
| `allowHalf` | `bool` | `true` | Allows partial or half-star selection. |

🚀 **Usage Snippet**:
```dart
CommonRatingBar(
  rating: controller.productRating.value,
  onRatingChanged: (newRating) => controller.submitRating(newRating),
  allowHalf: true,
  size: 28,
)
```

---

#### 6. `CommonSwitch`
💡 **Purpose**: Premium custom toggle switch featuring smooth spring animation. Circumvents inconsistent native iOS/Android styling by offering customizable track/thumb sizes and colors.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `value` | `bool` | *Required* | Current state of the switch (ON/OFF). |
| `onChanged` | `ValueChanged<bool>` | *Required* | Toggle callback. |
| `activeColor` | `Color?` | Primary theme | Track color when active. |
| `inactiveColor` | `Color?` | Muted grey | Track color when inactive. |

🚀 **Usage Snippet**:
```dart
CommonSwitch(
  value: controller.isDarkTheme.value,
  onChanged: (status) => controller.changeTheme(status),
)
```

---

#### 7. `CommonTabBar`
💡 **Purpose**: Animated category sliding selector. Built with custom physics, featuring a beautiful sliding background block indicator.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `tabs` | `List<String>` | *Required* | Tab labels list. |
| `selectedIndex` | `int` | *Required* | Active selected index. |
| `onTabChanged` | `ValueChanged<int>` | *Required* | Callback on tab select. |
| `borderRadius` | `double` | `12.0` | Rounded corner framing. |

🚀 **Usage Snippet**:
```dart
CommonTabBar(
  tabs: const ['Ongoing', 'Completed', 'Canceled'],
  selectedIndex: controller.activeTab.value,
  onTabChanged: (index) => controller.switchTab(index),
)
```

---

### 📁 Group B: Layout, Typography & App Structure

#### 8. `CommonScaffold`
💡 **Purpose**: Multi-device viewport standardizer. Auto-constrains content width to desktop/web margins and wraps the main page frame in an optimized layout hierarchy.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `body` | `Widget` | *Required* | Content layout of the page. |
| `appBar` | `PreferredSizeWidget?` | `null` | Header top bar wrapper. |
| `bottomNavigationBar` | `Widget?` | `null` | Bottom navigation bar placement. |
| `safeArea` | `bool` | `true` | When true, wraps the body in a safe-area view. |

🚀 **Usage Snippet**:
```dart
CommonScaffold(
  appBar: const CommonTopBar(title: 'Settings'),
  body: Column(
    children: [
      const CommonText('Configuration settings', variant: TextVariant.title),
    ],
  ),
)
```

---

#### 9. `CommonTopBar`
💡 **Purpose**: Clean standard App Bar which auto-detects routing history to show a back button, complete with custom action support and bold typography.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `title` | `String` | *Required* | Top header text. |
| `showBack` | `bool` | `true` | Toggles automatic back-arrow button display. |
| `actions` | `List<Widget>?` | `null` | List of trailing icons or widgets. |

🚀 **Usage Snippet**:
```dart
CommonTopBar(
  title: 'Edit Profile',
  actions: [
    IconButton(icon: const Icon(Icons.check), onPressed: () => controller.save()),
  ],
)
```

---

#### 10. `CommonDrawer`
💡 **Purpose**: Navigation sidebar providing profile headers, responsive navigation links, and animated active state wrappers.
⚙️ **Key Parameters**: See implementation file: [common_drawer.dart](file:///d:/Codex/getx_template/lib/component/layout/common_drawer.dart) for deep detail. Includes headers, lists of titles, and action callbacks.

🚀 **Usage Snippet**:
```dart
CommonScaffold(
  drawer: const CommonDrawer(),
  appBar: const CommonTopBar(title: 'Dashboard'),
  body: const Center(child: CommonText('Welcome back!')),
)
```

---

#### 11. `CommonBottomNavBar`
💡 **Purpose**: Premium custom bottom bar supporting smooth page indexing transitions.
⚙️ **Key Parameters**: Takes selected active index, icon mappings, and transition callback functions. Refer to [common_bottom_nav_bar.dart](file:///d:/Codex/getx_template/lib/component/layout/common_bottom_nav_bar.dart).

🚀 **Usage Snippet**:
```dart
CommonScaffold(
  bottomNavigationBar: CommonBottomNavBar(
    selectedIndex: controller.currentIndex.value,
    onTap: (index) => controller.changePage(index),
  ),
  body: Obx(() => controller.currentPage),
)
```

---

#### 12. `CommonListView`
💡 **Purpose**: Ultra-high performance scroll list. Renders elements lazily (ensuring $O(1)$ memory consumption), featuring a built-in pull-to-refresh container, infinite scroll pagination limits, and empty-state fallbacks.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `items` | `List<T>` | *Required* | List of model items to loop. |
| `itemBuilder` | `Widget Function(..., T, int)` | *Required* | Custom item drawer. |
| `onRefresh` | `Future<void> Function()?`| `null` | Pull-to-refresh trigger. |
| `onLoadMore` | `Future<void> Function()?`| `null` | Infinite scroll bottom callback. |
| `hasMore` | `bool` | `false` | Shows dynamic paginate loaders at list bottom. |
| `emptyWidget` | `Widget?` | `null` | Fallback shown when `items` is empty. |

🚀 **Usage Snippet**:
```dart
CommonListView<ProductModel>(
  items: controller.productsList,
  onRefresh: () => controller.fetchLatest(),
  onLoadMore: () => controller.fetchNextPage(),
  hasMore: controller.hasNextPage.value,
  itemBuilder: (context, product, index) => ProductCard(product: product),
)
```

---

#### 13. `CommonGridView`
💡 **Purpose**: Lazy-loaded paginated grids built with an integrated pull-to-refresh structure. Similar signature to `CommonListView`, perfect for dashboard indexes.
⚙️ **Key Parameters**: Refer to [common_grid_view.dart](file:///d:/Codex/getx_template/lib/component/layout/common_grid_view.dart).

🚀 **Usage Snippet**:
```dart
CommonGridView<ProductModel>(
  items: controller.productList,
  crossAxisCount: 2,
  onRefresh: () => controller.refreshCatalog(),
  itemBuilder: (context, product, index) => ProductGridTile(product: product),
)
```

---

#### 14. `CommonCard`
💡 **Purpose**: Simple structured wrapper offering standard elevation, borders, padding, and uniform card layout formats.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `child` | `Widget` | *Required* | Layout inside the card. |
| `padding` | `EdgeInsetsGeometry` | `EdgeInsets.all(16.0)`| Padding within outer walls. |

🚀 **Usage Snippet**:
```dart
CommonCard(
  child: Column(
    children: [
      const CommonText('Account Details', variant: TextVariant.title),
      const CommonText('Active Subscription', variant: TextVariant.caption),
    ],
  ),
)
```

---

#### 15. `CommonText`
💡 **Purpose**: Typography standardization widget. Groups text properties into six standard semantic tokens, enforcing uniform font resizing, leading limits, and color templates.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `text` | `String` | *Required* | Content text. |
| `variant` | `TextVariant` | `TextVariant.body` | Font variant (`display`, `header`, `title`, `body`, `caption`, `overline`). |
| `weight` | `TextWeight` | `TextWeight.regular` | Weight variants (`light`, `regular`, `medium`, `bold`). |
| `color` | `Color?` | Theme body | Font color override. |
| `fontSize` | `double?` | Variant base | Point size override (auto-responsive). |

🚀 **Usage Snippet**:
```dart
CommonText(
  'User Account Staged',
  variant: TextVariant.header,
  weight: TextWeight.bold,
  color: context.colorScheme.primary,
)
```

---

#### 16. `CommonImage`
💡 **Purpose**: Dynamic multi-source image canvas. Detects resource origins to load network addresses (integrating automated local caching with custom fallback shimmers), vector SVGs (asset/network), or traditional project assets.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `src` | `String` | *Required* | Resource pointer (e.g. `http://...` or `assets/images/...`). |
| `width` | `double?` | `null` | Display layout width. |
| `height` | `double?` | `null` | Display layout height. |
| `borderRadius` | `BorderRadius` | `BorderRadius.zero`| Frame rounding settings. |

🚀 **Usage Snippet**:
```dart
CommonImage(
  src: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
  height: 200,
  borderRadius: BorderRadius.circular(16),
  fit: BoxFit.cover,
)
```

---

#### 17. `CommonSvgIcon`
💡 **Purpose**: Custom vector layout layer. Renders asset-based SVG images cleanly, injecting custom colors via single-filter color blending.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `asset` | `String` | *Required* | Path to local asset SVG (e.g. `assets/icons/home.svg`). |
| `size` | `double` | `24` | Box size dimension (width/height). |
| `color` | `Color?` | `null` | Color filter to apply. |

🚀 **Usage Snippet**:
```dart
CommonSvgIcon(
  asset: 'assets/icons/verified.svg',
  color: Colors.blue,
  size: 32,
)
```

---

### 📁 Group C: Pickers & Interactive Sheets

#### 18. `CommonCountryPicker`
💡 **Purpose**: Searchable modal panel returning dial codes, emojis, and ISO country descriptors.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `context` | `BuildContext` | *Required* | Widget context to push bottom sheet. |
| `title` | `String` | `'Select Country'`| Header label of sheet. |

🚀 **Usage Snippet**:
```dart
final country = await CommonCountryPicker.show(context: context);
if (country != null) {
  print("Chosen Country: ${country.name} (${country.dialCode})");
}
```

---

#### 19. `CommonDatePicker`
💡 **Purpose**: Premium iOS Cupertino date selection wheel neatly framed inside a modern rounded material bottom sheet.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `context` | `BuildContext` | *Required* | View context. |
| `initialDate` | `DateTime?` | `DateTime.now()` | Initially selected wheel timestamp. |
| `minimumDate` | `DateTime?` | `null` | Minimum bound. |
| `maximumDate` | `DateTime?` | `null` | Maximum bound. |

🚀 **Usage Snippet**:
```dart
final selectedDate = await CommonDatePicker.show(
  context: context,
  minimumDate: DateTime(2000),
  maximumDate: DateTime.now(),
);
```

---

#### 20. `CommonTimePicker`
💡 **Purpose**: Premium Cupertino hour/minute time wheel inside a modern dark-mode compatible bottom sheet.
⚙️ **Key Parameters**: Similar to date picker. Returns a standard `TimeOfDay` value.
🚀 **Usage Snippet**:
```dart
final selectedTime = await CommonTimePicker.show(
  context: context,
  initialTime: TimeOfDay.now(),
);
```

---

#### 21. `CommonMultiImagePicker`
💡 **Purpose**: A compressed multi-file image selector. Displays thumbnails with custom delete hooks. Features **built-in image quality compression and dimensions limit overrides** to prevent RAM out-of-memory crashes on resource-constrained devices.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `onImagesChanged` | `Function(List<File>)` | *Required* | Callback triggered whenever items are modified. |
| `maxImages` | `int` | `10` | Maximum images allowed. |
| `imageQuality` | `int` | `70` | JPEG compression ratio (saves memory!). |
| `maxWidth` | `double` | `1080` | Automatic width boundary resizing. |

🚀 **Usage Snippet**:
```dart
CommonMultiImagePicker(
  maxImages: 5,
  onImagesChanged: (files) => controller.selectedImages.assignAll(files),
)
```

---

### 📁 Group D: Dialogs & Toast Alerts

#### 22. `CommonSnackbar`
💡 **Purpose**: Floating notification alerts built on top of `Get.snackbar` featuring custom box shadows, responsive edge margins, and color indicators.
⚙️ **Key Parameters**:
| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `title` | `String` | *Required* | Headline text. |
| `message` | `String` | *Required* | Message description. |
| `type` | `SnackbarType` | `SnackbarType.info` | Action variants (`success`, `error`, `warning`, `info`). |

🚀 **Usage Snippet**:
```dart
// Direct static access:
CommonSnackbar.showSuccess(title: 'Profile Saved', message: 'Your changes were updated.');
CommonSnackbar.showError(title: 'Connection Lost', message: 'Please retry your request.');
```

---

#### 23. `ConfirmationDialog`
💡 **Purpose**: Clean standard choice alert box dialog returning boolean status flags.
⚙️ **Key Parameters**: Takes `title`, `message`, `confirmText`, `cancelText`.
🚀 **Usage Snippet**:
```dart
final confirmed = await showDialog<bool>(
  context: context,
  builder: (context) => const ConfirmationDialog(
    title: 'Delete Item?',
    message: 'Are you sure you want to permanently remove this transaction?',
  ),
);
if (confirmed ?? false) {
  controller.deleteItem();
}
```

---

#### 24. `LoadingDialog`
💡 **Purpose**: Synchronous dialog sheet that blocks clicks during asynchronous loading actions.
⚙️ **Key Parameters**: Takes `message`.
🚀 **Usage Snippet**:
```dart
// Open loader dialog
showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => const LoadingDialog(message: 'Processing payment...'),
);

// Close once done
Get.back();
```

---

### 📁 Group E: Loading Indicators & Shimmers

#### 25. `ShimmerBox`
💡 **Purpose**: Core rectangular skeleton block used to create loading placeholders.
🚀 **Usage Snippet**:
```dart
ShimmerBox(width: 120, height: 16, borderRadius: BorderRadius.circular(4))
```

---

#### 26. `CommonShimmerCard` & `CommonShimmerList`
💡 **Purpose**: Pre-formatted card and list layouts matching standard UI structures to preview skeleton frames.
🚀 **Usage Snippet**:
```dart
// Previews an animated skeleton list when waiting for data
if (controller.isLoading.value) {
  return const CommonShimmerList();
}
```

---

#### 27. `LoadingOverlay`
💡 **Purpose**: Semi-transparent state overlay box featuring central indicators.
🚀 **Usage Snippet**:
```dart
Stack(
  children: [
    MainBodyScreen(),
    if (controller.isUploading.value)
      const LoadingOverlay(message: 'Uploading document...'),
  ],
)
```

---

#### 28. `PaginationLoader`
💡 **Purpose**: Subtle loading indicator rendered at the footer of list/grid boundaries during pagination actions.
🚀 **Usage Snippet**:
```dart
// Rendered automatically inside CommonListView at scroll margins
PaginationLoader()
```

---

### 📁 Group F: Fallback & State Widgets

#### 29. `EmptyStateWidget`
💡 **Purpose**: Clean fallback view with optional custom actions, shown when list items or queries return empty results.
⚙️ **Key Parameters**: Takes `title`, `description`, `icon`, `actionLabel`, `onAction`.
🚀 **Usage Snippet**:
```dart
EmptyStateWidget(
  title: 'No Active Orders',
  description: 'You haven\'t placed any orders yet.',
  actionLabel: 'Shop Now',
  onAction: () => Get.toNamed(AppRoutes.catalog),
)
```

---

#### 30. `ErrorStateWidget`
💡 **Purpose**: Custom layout shown when an operation fails, displaying details and an action button to retry.
🚀 **Usage Snippet**:
```dart
ErrorStateWidget(
  errorMessage: 'Could not resolve server connection.',
  onRetry: () => controller.reloadItems(),
)
```

---

#### 31. `NoInternetWidget`
💡 **Purpose**: Dedicated screen shown when the device is offline.
🚀 **Usage Snippet**:
```dart
NoInternetWidget(
  onRetry: () => controller.checkConnection(),
)
```

---

#### 32. `RetryWidget`
💡 **Purpose**: Minimal inline button structure to easily hook error refetching.
🚀 **Usage Snippet**:
```dart
RetryWidget(
  onRetry: () => controller.reloadData(),
)
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
      CommonText(
        'Workspace Settings',
        variant: TextVariant.header,
        color: context.colorScheme.primary, // context.colorScheme!
      ),
      12.height, // 12.height spacer!
      const CommonText('Subheading', variant: TextVariant.body)
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
