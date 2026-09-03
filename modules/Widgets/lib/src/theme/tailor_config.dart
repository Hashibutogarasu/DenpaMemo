import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

/// Shared `@TailorMixin` configuration for every `ThemeExtension` in this
/// package: skips theme_tailor's optional `BuildContext`/`ThemeData`
/// convenience-getter generation, since field names (e.g. `borderColor`)
/// repeat across these theme classes and would otherwise collide as
/// same-named top-level extension members. Consumers read fields the
/// standard way instead: `Theme.of(context).extension<MyThemeData>()!`.
const appTailorMixin = TailorMixin(themeGetter: ThemeGetter.none);
