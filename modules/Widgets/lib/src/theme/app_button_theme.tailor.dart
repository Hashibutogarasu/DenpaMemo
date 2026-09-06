// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_button_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AppButtonThemeDataTailorMixin on ThemeExtension<AppButtonThemeData> {
  Color get backgroundTintColor;
  double get blurSigma;
  Color get foregroundColor;

  @override
  AppButtonThemeData copyWith({
    Color? backgroundTintColor,
    double? blurSigma,
    Color? foregroundColor,
  }) {
    return AppButtonThemeData(
      backgroundTintColor: backgroundTintColor ?? this.backgroundTintColor,
      blurSigma: blurSigma ?? this.blurSigma,
      foregroundColor: foregroundColor ?? this.foregroundColor,
    );
  }

  @override
  AppButtonThemeData lerp(
    covariant ThemeExtension<AppButtonThemeData>? other,
    double t,
  ) {
    if (other is! AppButtonThemeData) return this as AppButtonThemeData;
    return AppButtonThemeData(
      backgroundTintColor: Color.lerp(
        backgroundTintColor,
        other.backgroundTintColor,
        t,
      )!,
      blurSigma: t < 0.5 ? blurSigma : other.blurSigma,
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppButtonThemeData &&
            const DeepCollectionEquality().equals(
              backgroundTintColor,
              other.backgroundTintColor,
            ) &&
            const DeepCollectionEquality().equals(blurSigma, other.blurSigma) &&
            const DeepCollectionEquality().equals(
              foregroundColor,
              other.foregroundColor,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(backgroundTintColor),
      const DeepCollectionEquality().hash(blurSigma),
      const DeepCollectionEquality().hash(foregroundColor),
    );
  }
}
