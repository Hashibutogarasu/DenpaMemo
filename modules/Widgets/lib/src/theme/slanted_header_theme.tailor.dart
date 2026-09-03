// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slanted_header_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$SlantedHeaderThemeDataTailorMixin
    on ThemeExtension<SlantedHeaderThemeData> {
  Color get fillColor;
  Color get borderColor;
  double get borderWidth;
  double get angleDegrees;
  EdgeInsetsGeometry get contentPadding;

  @override
  SlantedHeaderThemeData copyWith({
    Color? fillColor,
    Color? borderColor,
    double? borderWidth,
    double? angleDegrees,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return SlantedHeaderThemeData(
      fillColor: fillColor ?? this.fillColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      angleDegrees: angleDegrees ?? this.angleDegrees,
      contentPadding: contentPadding ?? this.contentPadding,
    );
  }

  @override
  SlantedHeaderThemeData lerp(
    covariant ThemeExtension<SlantedHeaderThemeData>? other,
    double t,
  ) {
    if (other is! SlantedHeaderThemeData) return this as SlantedHeaderThemeData;
    return SlantedHeaderThemeData(
      fillColor: Color.lerp(fillColor, other.fillColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      borderWidth: t < 0.5 ? borderWidth : other.borderWidth,
      angleDegrees: t < 0.5 ? angleDegrees : other.angleDegrees,
      contentPadding: t < 0.5 ? contentPadding : other.contentPadding,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SlantedHeaderThemeData &&
            const DeepCollectionEquality().equals(fillColor, other.fillColor) &&
            const DeepCollectionEquality().equals(
              borderColor,
              other.borderColor,
            ) &&
            const DeepCollectionEquality().equals(
              borderWidth,
              other.borderWidth,
            ) &&
            const DeepCollectionEquality().equals(
              angleDegrees,
              other.angleDegrees,
            ) &&
            const DeepCollectionEquality().equals(
              contentPadding,
              other.contentPadding,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(fillColor),
      const DeepCollectionEquality().hash(borderColor),
      const DeepCollectionEquality().hash(borderWidth),
      const DeepCollectionEquality().hash(angleDegrees),
      const DeepCollectionEquality().hash(contentPadding),
    );
  }
}
