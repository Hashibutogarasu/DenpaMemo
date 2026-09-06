// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_bar_blur_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$NavigationBarBlurThemeDataTailorMixin
    on ThemeExtension<NavigationBarBlurThemeData> {
  Color get tintColor;
  double get blurSigma;

  @override
  NavigationBarBlurThemeData copyWith({Color? tintColor, double? blurSigma}) {
    return NavigationBarBlurThemeData(
      tintColor: tintColor ?? this.tintColor,
      blurSigma: blurSigma ?? this.blurSigma,
    );
  }

  @override
  NavigationBarBlurThemeData lerp(
    covariant ThemeExtension<NavigationBarBlurThemeData>? other,
    double t,
  ) {
    if (other is! NavigationBarBlurThemeData)
      return this as NavigationBarBlurThemeData;
    return NavigationBarBlurThemeData(
      tintColor: Color.lerp(tintColor, other.tintColor, t)!,
      blurSigma: t < 0.5 ? blurSigma : other.blurSigma,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NavigationBarBlurThemeData &&
            const DeepCollectionEquality().equals(tintColor, other.tintColor) &&
            const DeepCollectionEquality().equals(blurSigma, other.blurSigma));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(tintColor),
      const DeepCollectionEquality().hash(blurSigma),
    );
  }
}
