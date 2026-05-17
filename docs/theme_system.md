# Theme System

The template includes a Material 3 theme system with light and dark themes.

## Important Files

- `lib/theme/app_theme.dart`
- `lib/theme/app_colors.dart`
- `lib/theme/app_typography.dart`
- `lib/theme/app_spacing.dart`
- `lib/theme/app_radius.dart`
- `lib/theme/app_dimensions.dart`

## AppTheme

`AppTheme.light` and `AppTheme.dark` are registered in `GetMaterialApp`:

```dart
theme: AppTheme.light,
darkTheme: AppTheme.dark,
themeMode: ThemeMode.system,
```

## Colors

Use `Theme.of(context).colorScheme` inside widgets when possible:

```dart
final colors = Theme.of(context).colorScheme;

Container(
  color: colors.primaryContainer,
  child: Text('Hello', style: TextStyle(color: colors.onPrimaryContainer)),
)
```

Add brand colors to `AppColors` only when they are design tokens used across the app.

## Spacing

Use spacing tokens:

```dart
const SizedBox(height: AppSpacing.md)
```

Avoid random spacing values unless the layout truly needs a one-off adjustment.

## Radius

Use radius tokens:

```dart
BorderRadius.circular(AppRadius.md)
```

Cards are intentionally kept at modest radius for a clean production UI.

## Typography

Typography is defined in `AppTypography`.

Use theme text styles:

```dart
Text(
  'Settings',
  style: Theme.of(context).textTheme.titleLarge,
)
```

## Changing Theme Mode

The settings screen includes a theme segmented control:

```dart
Get.changeThemeMode(ThemeMode.dark);
```

The selected mode is saved with `SharedPreferencesService`.

## Reusable Widgets

Widgets in `lib/widgets` already consume the theme. Prefer:

- `AppButton`
- `AppTextField`
- `AppCard`
- `AppTopBar`
- `ResponsiveScaffold`
- `EmptyStateWidget`
- `ErrorStateWidget`
- `NoInternetWidget`

This keeps screens consistent across the app.
