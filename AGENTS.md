# Repository Guidelines

## Project Structure & Module Organization
- `lib/` contains the app: flavor entrypoints (`lib/main_<flavor>.dart`), bootstrap wiring, shared utilities in `lib/core/`, and feature modules in `lib/features/`.
- Localizations live in `lib/l10n/arb/`; the generated `lib/l10n/gen/` folder should be rebuilt, not edited, when strings change.
- Tests mirror their targets in `test/` (`test/app`, `test/counter`, helpers in `test/helpers/`), while platform shells stay under `android/`, `ios/`, `macos/`, `web/`, and `windows/` with flavor assets scoped inside each directory.

## Build, Test, and Development Commands
- `flutter pub get` refreshes packages after editing `pubspec.yaml`.
- `flutter run --flavor development --target lib/main_development.dart` launches the dev build; swap the flavor name for staging or production.
- `flutter build apk --flavor production --target lib/main_production.dart` or `flutter build ios --flavor staging` produces release binaries ready for distribution.
- `very_good test --coverage --test-randomize-ordering-seed random` runs unit and widget tests with coverage in `coverage/lcov.info`; `genhtml coverage/lcov.info -o coverage/ && open coverage/index.html` renders the HTML report.

## Coding Style & Naming Conventions
- Linting comes from `package:very_good_analysis`; run `flutter analyze` and `dart format .` before review.
- Use two-space indentation, keep lines under ~100 characters, and follow `UpperCamelCase` for types, `lowerCamelCase` for members, and `snake_case.dart` filenames (for example `feed_repository.dart`).
- Add concise doc comments on reusable widgets or services and avoid touching generated assets such as `lib/l10n/gen/`.

## Testing Guidelines
- Name specs with the `_test.dart` suffix and mirror production paths (`lib/features/feed` → `test/features/feed/feed_page_test.dart`).
- Flutter’s `test` runner via Very Good CLI powers the suite; reuse `test/helpers/pump_app.dart` to bootstrap widgets consistently.
- Track coverage deltas and investigate drops of about 1% or more before merging.

## Commit & Pull Request Guidelines
- Write commits using Conventional Commits (`type(scope): summary`), for example `feat(auth): add login form`; keep subjects 72 characters or less and add context in the body.
- Name branches `type/short-scope` such as `feat/feed-pagination`, and mirror the lead commit in the PR title (`feat(auth): add login form`).
- Group related work per commit, reference issues with `#123`, note flavor/localization/asset impacts, and include screenshots plus the latest `very_good test` result for UI-facing changes.

## Localization & Flavor Notes
- Add strings in `lib/l10n/arb/app_en.arb`, mirror them per locale, then run `flutter gen-l10n --arb-dir lib/l10n/arb`.
- Update platform locale declarations (for example the `CFBundleLocalizations` array in `ios/Runner/Info.plist`) and flavor configs when you add a locale.
- Align flavor resources across `android/app/src/<flavor>/`, flavor `.xcconfig` files, and `web/index.html` so environments stay consistent.
