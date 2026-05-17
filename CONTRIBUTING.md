# Contributing

Thanks for helping improve this Flutter GetX starter template.

## Local Setup

```bash
flutter pub get
dart format lib test
flutter analyze
flutter test
```

## Contribution Rules

- Keep the template generic.
- Do not add demo business domains such as ecommerce, blog, todo, or chat.
- Keep UI in `views`, state in `controllers`, dependencies in `bindings`, and API/data work in `repositories`.
- Prefer reusable infrastructure only when it helps many apps.
- Do not commit secrets, real Firebase configs, production keys, or private API URLs.
- Update docs when changing structure, architecture, services, or workflows.

## Pull Request Checklist

- Code is formatted.
- Analyzer passes.
- Tests pass or the reason is documented.
- README/docs are updated if behavior or structure changed.
- The template can still be cloned and renamed for any app.
