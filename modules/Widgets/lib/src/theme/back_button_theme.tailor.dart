// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'back_button_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$BackButtonThemeDataTailorMixin on ThemeExtension<BackButtonThemeData> {
  BackButtonAnchor get anchor;

  @override
  BackButtonThemeData copyWith({BackButtonAnchor? anchor}) {
    return BackButtonThemeData(anchor: anchor ?? this.anchor);
  }

  @override
  BackButtonThemeData lerp(
    covariant ThemeExtension<BackButtonThemeData>? other,
    double t,
  ) {
    if (other is! BackButtonThemeData) return this as BackButtonThemeData;
    return BackButtonThemeData(anchor: t < 0.5 ? anchor : other.anchor);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BackButtonThemeData &&
            const DeepCollectionEquality().equals(anchor, other.anchor));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(anchor),
    );
  }
}
