# Theme System

The template includes a Material 3 theme system with light and dark themes.

## Important Files

- [app_theme.dart](file:///d:/Project/getx/lib/core/theme/app_theme.dart) - Light & Dark theme definitions
- [app_colors.dart](file:///d:/Project/getx/lib/utils/constants/app_colors.dart) - Brand & Custom Color Palette
- [app_typography.dart](file:///d:/Project/getx/lib/core/theme/app_typography.dart) - Text styling & Typography
- [app_spacing.dart](file:///d:/Project/getx/lib/core/theme/app_spacing.dart) - Padding & Margin tokens
- [app_radius.dart](file:///d:/Project/getx/lib/core/theme/app_radius.dart) - Border radius tokens
- [app_dimensions.dart](file:///d:/Project/getx/lib/core/theme/app_dimensions.dart) - Layout measurements

---

## AppTheme

`AppTheme.light` and `AppTheme.dark` are registered in `GetMaterialApp` inside `main.dart`:

```dart
theme: AppTheme.light,
darkTheme: AppTheme.dark,
themeMode: ThemeMode.system,
```

---

## Color Palette System

The custom color palette is defined in `AppColors` with both **camelCase** and **snake_case** options for developer convenience.

### 1. Palette Structure
- **Error Shades**: `error50` / `error_50` (lightest) to `error900` / `error_900` (darkest)
- **Warning Shades**: `warning50` / `warning_50` to `warning900` / `warning_900`
- **Success Shades**: `success50` / `success_50` to `success900` / `success_900`
- **Text & Border (Neutral) Shades**: `textBorder50` / `text_border_50` to `textBorder900` / `text_border_900`

### 2. Light & Dark Theme Mappings
When the user toggles light/dark mode, these shades map dynamically:

| Component / Utility | Light Theme Value | Dark Theme Value |
| :--- | :--- | :--- |
| **Scaffold Background** | `textBorder50` (`#F2F2F2`) | `textBorder900` (`#353535`) |
| **Card / Surface Background** | `white` (`#FFFFFF`) | `textBorder800` (`#454545`) |
| **Primary Text (OnSurface)** | `textBorder900` (`#353535`) | `textBorder50` (`#F2F2F2`) |
| **Border / Outline** | `textBorder100` (`#D7D7D7`) | `textBorder700` (`#595959`) |
| **Error Color** | `error500` (`#CC0000`) | `error300` (`#DD5454`) |
| **Error Container** | `error50` (`#FAE6E6`) | `error900` (`#560000`) |
| **Warning (Tertiary)** | `warning500` (`#D2D515`) | `warning300` (`#E1E362`) |
| **Success (Secondary)** | `success500` (`#1FB396`) | `success300` (`#69CCB9`) |

---

## How to Use Colors

### 1. Using Dynamic Theme Colors (Recommended)
To support seamless theme switching (Light <-> Dark), always consume colors using the context extension defined in [context_extensions.dart](file:///d:/Project/getx/lib/utils/extensions/context_extensions.dart):

```dart
@override
Widget build(BuildContext context) {
  // Use context.colors to access dynamic Theme ColorScheme
  return Container(
    color: context.colors.surface, 
    border: Border.all(color: context.colors.outlineVariant),
    child: Text(
      'Dynamic Theme Card',
      style: context.textTheme.bodyMedium?.copyWith(
        color: context.colors.onSurface,
      ),
    ),
  );
}
```

### 2. Using Specific Palette Shades (Static)
Use specific shades from `AppColors` when you need a fixed color value regardless of the theme:

```dart
// Example: Hardcoded static light border
Container(
  decoration: BoxDecoration(
    color: AppColors.white,
    border: Border.all(color: AppColors.textBorder100),
  ),
  child: const Text('I will always look the same'),
)
```

### 3. Conditional Theming for Custom Widgets
If you want to use specific custom palette shades that switch dynamically with the theme, use `context.isDarkMode`:

```dart
Container(
  color: context.isDarkMode 
      ? AppColors.textBorder800  // Dark mode color
      : AppColors.white,         // Light mode color
)
```

---

## Spacing & Spacing Tokens

Use spacing tokens from `AppSpacing` to keep layouts consistent:

```dart
const SizedBox(height: AppSpacing.md)
```

Avoid random layout values unless absolutely necessary.

---

## Changing Theme Mode

The theme mode can be toggled using GetX:

```dart
Get.changeThemeMode(ThemeMode.dark);
```

This updates all active widgets instantly and saves the selection to persistent storage.
