# denpa_memo Agent Guide

This repository contains a Flutter application, a Dart package workspace, Rust
native logic, and several pnpm-managed TypeScript services. Read this file
together with `CLAUDE.md`; the latter contains repository-wide workflow and
safety rules that also apply to agent changes.

## Project Layout

The root package is the `denpa_memo` Flutter application. The root
`pubspec.yaml` declares the following Dart workspace members:

- `modules/DataPack`: pure-Dart domain models, repositories, backup, QR, and
  master-data logic. This package is analyzed and tested with Dart rather than
  Flutter.
- `modules/DataCache`: local cache index and cache storage.
- `modules/DMFile`: import/export file format and step-based file operations.
- `modules/AppDatas`: application path and data-location helpers.
- `modules/AppMetaData`: metadata annotations and generated metadata.
- `modules/StepDialog`: step execution and progress/error UI.
- `modules/Widgets`: reusable application widgets, themes, and UI state.
- `modules/Graph`: reusable lineage/tree graph widgets.
- `modules/TableEditor`: reusable table-editing widgets.
- `modules/Toaster`: toast presentation helpers.
- `modules/GraphQLClient`: GraphQL repositories, caching, and providers.
- `modules/APIClient`: typed API request/response models and client logic.
- `modules/FirebaseSignIn`: Firebase/Google sign-in and account backends.
- `modules/PlatformUtils`: platform-specific capability checks.
- `modules/Logging`: logging, log storage, and Dio/print interceptors.
- `modules/denpamemo_logics`: Flutter FFI plugin backed by Rust logic and
  generated flutter_rust_bridge bindings.
- `apps/WidgetBook`: isolated Widgetbook application for reusable widgets.

The `modules/` directory also contains packages that are not Dart workspace
members:

- `modules/server`: TypeScript Elysia/GraphQL server with TypeORM and
  PostgreSQL migrations.
- `modules/auth`: TypeScript/Cloudflare Worker authentication service.
- `modules/CloudData`: shared TypeScript cloud-storage and token helpers.
- `modules/tunnel`: local Cloudflare Tunnel configuration.

These packages are included in `pnpm-workspace.yaml`. The root `package.json`
uses Turbo to coordinate their development tasks.

Important root directories:

| Path | Responsibility |
| --- | --- |
| `lib/main.dart` | Startup and native/data-layer initialization |
| `lib/app.dart` | Provider scope, localization, theme, splash, and root app wiring |
| `lib/routing/` | Typed GoRouter route declarations and generated routes |
| `lib/providers/` | Riverpod state, dependency injection, and async workflows |
| `lib/pages/` | Feature-level screens and route destinations |
| `lib/widgets/` | App-specific widgets and screen composition |
| `lib/data/` | ObjectBox entities/repositories and server argument models |
| `lib/domain/` | App-specific domain errors and business concepts |
| `lib/services/` | Cross-feature services and native/background integration |
| `lib/bootstrap/` | Startup configuration and platform bootstrap helpers |
| `lib/theme/` | Root application theme and theme mappings |
| `lib/i18n/` | Root Japanese translation source and generated Slang output |
| `assets/` | Master data assets, icons, route fixtures, and auth configuration |
| `test/` | Root app unit, widget, integration-style, and feature tests |
| `modules/denpamemo_logics/rust/` | Rust implementation shared with Flutter and Wasm |
| `modules/server/data/` | Server-side master data and JSON schemas |
| `.github/workflows/` | Android, Flatpak, and release automation |

## Architecture

- `main.dart` initializes Flutter, Rust, ObjectBox, the cache index, OAuth
  configuration, connectivity monitoring, and the shared Dio instance before
  starting `MyApp`.
- `app.dart` owns the top-level provider scopes and connects the app to the
  reusable widget, step-dialog, and GraphQL packages.
- Riverpod providers are the normal dependency-injection and feature-state
  boundary. Prefer extending the existing provider graph over introducing
  service locators or global mutable state.
- ObjectBox-backed repositories live under `lib/data/`; domain-independent
  models and calculations should generally belong in `modules/DataPack`.
- Network calls use the shared Dio instance and the connectivity gate. Do not
  create a second uncoordinated Dio client for app network I/O.
- Root routes are declared in `lib/routing/app_router.dart`. Routes with
  non-URL state use GoRouter `$extra` arguments; route behavior and generated
  output must remain in sync.
- Reusable UI belongs in `modules/Widgets`, `modules/Graph`, or another
  appropriate workspace package. Keep app-specific composition in root
  `lib/widgets/` and feature screens in `lib/pages/`.
- The app currently supports Japanese as its Flutter locale. Translation
  source files are the `*.i18n.json` files; generated Dart translation files
  are not hand-maintained.

## Toolchain

- Flutter and Dart are pinned to Flutter `3.38.3` and Dart `3.10.1`.
- Use the FVM version specified by `.fvmrc` when FVM is available.
- The Dart workspace uses Melos `8.5.0`; do not independently run the same
  Flutter command package-by-package when a Melos script covers the workspace.
- The JavaScript workspace uses pnpm `12.3.4` and Turbo.
- Rust and Cargo are required for `modules/denpamemo_logics`. `setup.sh`
  installs the WebAssembly target and builds the Rust crate after fetching Dart
  dependencies and the ObjectBox native library.

## Setup

From the repository root:

```sh
bash setup.sh
pnpm install
```

`setup.sh` requires Flutter, Rust/rustup, Cargo, and network access. Do not
commit files produced by setup that are covered by `.gitignore`, especially
native libraries, build directories, package caches, or generated service
artifacts.

## Validation Commands

Run only the checks relevant to the changed area first, then broaden validation
when the change crosses package boundaries.

### Root Flutter application

```sh
flutter analyze .
flutter test
flutter build apk --debug
```

The root app is outside the Melos package filters, so run its analysis and
tests directly from the repository root.

### Dart workspace packages

```sh
dart run melos run --no-select analyze
dart run melos run --no-select test
```

These scripts cover Flutter workspace packages with the applicable filters.
Use `--no-select` to skip Melos's interactive package-selection prompt and run
the script's configured package filters non-interactively.
`modules/DataPack` is pure Dart and must be checked separately:

```sh
dart analyze modules/DataPack
dart test modules/DataPack
```

### TypeScript services

Use pnpm filters and the scripts defined by each package. Examples:

```sh
pnpm --filter @Hashibutogarasu/denpa-memo-server typecheck
pnpm --filter @Hashibutogarasu/denpa-memo-server test
pnpm --filter @Hashibutogarasu/denpa-memo-auth typecheck
pnpm --filter @Hashibutogarasu/denpa-memo-auth test
pnpm --filter @Hashibutogarasu/denpa-memo-cloud-data typecheck
pnpm --filter @Hashibutogarasu/denpa-memo-cloud-data test
```

The server's database and container scripts require Docker. Do not run
deployment or destructive database commands as part of ordinary validation.

### Rust and Wasm

```sh
cargo test --manifest-path modules/denpamemo_logics/rust/Cargo.toml
cargo build --manifest-path modules/denpamemo_logics/rust/Cargo.toml
pnpm --filter @denpamemo/denpamemo-logics build:wasm
```

When changing Rust inputs or the bridge configuration, regenerate the
flutter_rust_bridge output under `modules/denpamemo_logics/lib/src/rust` with
the repository's pinned toolchain before testing the Flutter package.

## Code Generation

Generated files are checked into this repository and must be regenerated when
their source changes. Do not edit generated files directly.

- Freezed, JSON serialization, ObjectBox, GoRouter, app metadata, and
  Widgetbook output use `build_runner`.
- The root app's dependency graph includes `sqlite3` through
  `objectbox_flutter_libs`. Use JIT mode for root generation:

  ```sh
  dart run build_runner build --force-jit --delete-conflicting-outputs
  ```

- The `build_runner` version range `>=2.15.1 <2.16.0` is intentional. Do not
  loosen it to work around the native-assets hook issue.
- For packages without the native-assets dependency, run the same command
  without `--force-jit` from that package when required.
- Root translations are regenerated with `dart run slang`. Workspace package
  translations are regenerated with `melos run slang`.
- Route declarations in `lib/routing/app_router.dart`, annotation/model
  changes, ObjectBox model changes, and translation source changes commonly
  require generated-file updates in the same change.

Generated output should be reviewed for accidental unrelated changes. Never
manually rewrite `.g.dart`, `.freezed.dart`, `objectbox.g.dart`, generated
Slang files, or `frb_generated*` files to hide a source-level problem.

## Change Guidelines

- Make the smallest change that preserves the existing package boundaries and
  provider architecture.
- Add or update tests next to the behavior being changed. Root tests are
  organized by `data`, `domain`, `denpamens`, `pages`, `providers`, `services`,
  and `widgets`; follow those existing categories.
- Prefer deterministic fixtures and fakes from `test/support/` over network,
  filesystem, or platform access in widget tests.
- Keep persistence migrations compatible with existing ObjectBox data. Treat
  model IDs, hashes, backup formats, QR formats, and migration code as public
  compatibility surfaces.
- Keep network behavior offline-safe and preserve the existing request/logging
  status semantics when changing API clients or connectivity handling.
- Use English documentation comments for public classes, functions, and
  methods. Do not add documentation comments to individual fields or inline
  comments that merely restate code.
- Do not hand-format Dart solely for style. The repository pre-commit hook
  formats staged Dart files. Use `tidy_imports` with `--no-comments` when
  import ordering must be corrected:

  ```sh
  dart run tidy_imports --no-comments <files...>
  ```

- Keep secrets out of the repository. Firebase files, Google OAuth client
  secrets, signing keys, `.dev.vars`, and similar local configuration are
  ignored and are decoded in CI from GitHub secrets.
- Do not make unrelated bug fixes while working on a requested change. If an
  unrelated defect is important, report it separately unless it can be
  reproduced and fixed with an appropriate regression test.

## CI and Release Notes

- `.github/workflows/android-build.yml` builds debug/release APKs and AABs and
  publishes Play Store internal/beta artifacts under specific event conditions.
- `.github/workflows/flatpak-build.yml` builds the Linux Flatpak bundle.
- `.github/workflows/release-please.yml` manages releases from the `release`
  branch and updates the Flutter package version with `pub_version_plus`.
- `RELEASE-DETAILS.md`, `release-please-config.json`, and
  `.release-please-manifest.json` are part of the release workflow. Avoid
  changing versioning behavior unless the task explicitly requires it.

Do not launch, install, or automate a real device or emulator unless the user
explicitly requests that in the current task.
