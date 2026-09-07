# Response Language

- Always respond in whatever language the user requests.
- Re-check the requested language at the moment each new request arrives, regardless of the current state (mid-task, mid-plan, background work in progress, etc.). Never assume the language from earlier in the conversation still applies without re-confirming it against the latest request.

# Workspace Tooling

- When analyzing or building across multiple packages in this workspace (the `modules/` and `apps/` members listed under `workspace:` in the root `pubspec.yaml`), use Melos (`melos run analyze`, `melos run test`, etc.) instead of invoking `flutter analyze` / `flutter test` separately per package.
- The root app package (`denpa_memo` itself) is outside the Melos workspace member list and is not covered by Melos scripts. Analyze and test it on its own, directly with `flutter analyze` / `flutter test` from the repo root.
- The pure-Dart `data_pack` package (`modules/DataPack`) is filtered out of the `flutter: true` Melos script filters. Analyze and test it on its own with `dart analyze` / `dart test`.

# Code Formatting

- Never hand-edit code purely to reformat it, and never use a script (e.g. a Python one-off) to force a particular formatting.
- Formatting is the compiler/toolchain's job: run `dart format` (or the equivalent `flutter format`) and let it decide the formatting.
- Never hand-sort or reorder `import` directives by editing them one by one. Use the `tidy_imports` tool instead, so import order is decided by the tool rather than by hand:
  - It is declared as a `dev_dependency` in the root `pubspec.yaml`.
  - Run it from the repo root as `dart run tidy_imports --no-comments <files...>` — not a globally activated `tidy_imports` binary.
  - Always pass `--no-comments`: this codebase does not use tidy_imports' "Dart imports:" / "Package imports:" / "Project imports:" group-header comments, so omitting the flag would introduce a comment style not used elsewhere in the repo.

# Planning

- Do not write concrete/literal code snippets inside a plan file.
- Write a detailed design description instead: class/function responsibilities, field and parameter shapes described in prose, how pieces connect, and why — not the code itself.

# Documentation Comments

- Doc comments on individual fields are forbidden. If a field's purpose isn't obvious from its name and type, rename it instead of explaining it with a comment.
- Doc comments on classes, functions, and methods are required, and must be written in English.

# Device Execution

- Never run `flutter devices`, `flutter run`, `flutter install`, `adb install`, `adb shell am start`/`monkey`, or any other command that installs, launches, or otherwise interacts with a real device or emulator — this includes screenshots, logcat capture, and UI automation against a running app — unless the user has explicitly asked for it in that turn. A prior build (`flutter build ...`) is not permission to install or run it.
- If diagnosing a bug seems to require an actual run, say so and ask before doing it. Do not treat "let's figure out the root cause" as implicit permission to touch a connected device.
- When wrapping up a task, do not solicit permission to run device/build verification (e.g. "let me know if you'd like me to run this"). State plainly that device verification wasn't performed and stop there; let the user bring it up themselves if they want it done.

# Unrequested Bug Fixes

- While writing code for a requested task, a bug noticed in unrelated, unrequested code must not be fixed unilaterally on the spot.
- Verify it test-first: write a test that reproduces the suspected bug, confirm it fails against the current code, and only then fix the bug and confirm the test passes. Do not patch the code first and rationalize it afterward.
- If writing a reproducing test isn't practical, surface the finding to the user instead of silently fixing it, and let them decide whether and how to proceed.
