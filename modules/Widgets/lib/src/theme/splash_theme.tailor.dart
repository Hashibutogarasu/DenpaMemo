// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'splash_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$SplashThemeDataTailorMixin on ThemeExtension<SplashThemeData> {
  Color get backgroundColor;
  double get appNameFontSize;
  Duration get displayDuration;
  Duration get fadeOutDuration;

  @override
  SplashThemeData copyWith({
    Color? backgroundColor,
    double? appNameFontSize,
    Duration? displayDuration,
    Duration? fadeOutDuration,
  }) {
    return SplashThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      appNameFontSize: appNameFontSize ?? this.appNameFontSize,
      displayDuration: displayDuration ?? this.displayDuration,
      fadeOutDuration: fadeOutDuration ?? this.fadeOutDuration,
    );
  }

  @override
  SplashThemeData lerp(
    covariant ThemeExtension<SplashThemeData>? other,
    double t,
  ) {
    if (other is! SplashThemeData) return this as SplashThemeData;
    return SplashThemeData(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      appNameFontSize: t < 0.5 ? appNameFontSize : other.appNameFontSize,
      displayDuration: t < 0.5 ? displayDuration : other.displayDuration,
      fadeOutDuration: t < 0.5 ? fadeOutDuration : other.fadeOutDuration,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SplashThemeData &&
            const DeepCollectionEquality().equals(
              backgroundColor,
              other.backgroundColor,
            ) &&
            const DeepCollectionEquality().equals(
              appNameFontSize,
              other.appNameFontSize,
            ) &&
            const DeepCollectionEquality().equals(
              displayDuration,
              other.displayDuration,
            ) &&
            const DeepCollectionEquality().equals(
              fadeOutDuration,
              other.fadeOutDuration,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(backgroundColor),
      const DeepCollectionEquality().hash(appNameFontSize),
      const DeepCollectionEquality().hash(displayDuration),
      const DeepCollectionEquality().hash(fadeOutDuration),
    );
  }
}
