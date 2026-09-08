import 'package:data_pack/data_pack.dart';

/// Converts the domain [AppContrastLevel] to the `contrastLevel` value
/// [ColorScheme.fromSeed] expects (`-1.0`..`1.0`), per the Material 3
/// guideline mapping medium contrast to `0.5` and high contrast to `1.0`.
extension AppContrastLevelMapping on AppContrastLevel {
  double toColorSchemeContrastLevel() {
    return switch (this) {
      AppContrastLevel.standard => 0.0,
      AppContrastLevel.medium => 0.5,
      AppContrastLevel.high => 1.0,
    };
  }
}
