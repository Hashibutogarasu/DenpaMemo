// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_item_container_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ListItemContainerThemeDataTailorMixin
    on ThemeExtension<ListItemContainerThemeData> {
  Color get backgroundColor;
  double get borderRadius;
  Color get tileBorderColor;
  double get tileBorderWidth;
  Color get selectedBackgroundColor;
  Duration get checkAnimationDuration;
  Curve get checkAnimationInCurve;
  Curve get checkAnimationOutCurve;

  @override
  ListItemContainerThemeData copyWith({
    Color? backgroundColor,
    double? borderRadius,
    Color? tileBorderColor,
    double? tileBorderWidth,
    Color? selectedBackgroundColor,
    Duration? checkAnimationDuration,
    Curve? checkAnimationInCurve,
    Curve? checkAnimationOutCurve,
  }) {
    return ListItemContainerThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      tileBorderColor: tileBorderColor ?? this.tileBorderColor,
      tileBorderWidth: tileBorderWidth ?? this.tileBorderWidth,
      selectedBackgroundColor:
          selectedBackgroundColor ?? this.selectedBackgroundColor,
      checkAnimationDuration:
          checkAnimationDuration ?? this.checkAnimationDuration,
      checkAnimationInCurve:
          checkAnimationInCurve ?? this.checkAnimationInCurve,
      checkAnimationOutCurve:
          checkAnimationOutCurve ?? this.checkAnimationOutCurve,
    );
  }

  @override
  ListItemContainerThemeData lerp(
    covariant ThemeExtension<ListItemContainerThemeData>? other,
    double t,
  ) {
    if (other is! ListItemContainerThemeData)
      return this as ListItemContainerThemeData;
    return ListItemContainerThemeData(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      borderRadius: t < 0.5 ? borderRadius : other.borderRadius,
      tileBorderColor: Color.lerp(tileBorderColor, other.tileBorderColor, t)!,
      tileBorderWidth: t < 0.5 ? tileBorderWidth : other.tileBorderWidth,
      selectedBackgroundColor: Color.lerp(
        selectedBackgroundColor,
        other.selectedBackgroundColor,
        t,
      )!,
      checkAnimationDuration: t < 0.5
          ? checkAnimationDuration
          : other.checkAnimationDuration,
      checkAnimationInCurve: t < 0.5
          ? checkAnimationInCurve
          : other.checkAnimationInCurve,
      checkAnimationOutCurve: t < 0.5
          ? checkAnimationOutCurve
          : other.checkAnimationOutCurve,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ListItemContainerThemeData &&
            const DeepCollectionEquality().equals(
              backgroundColor,
              other.backgroundColor,
            ) &&
            const DeepCollectionEquality().equals(
              borderRadius,
              other.borderRadius,
            ) &&
            const DeepCollectionEquality().equals(
              tileBorderColor,
              other.tileBorderColor,
            ) &&
            const DeepCollectionEquality().equals(
              tileBorderWidth,
              other.tileBorderWidth,
            ) &&
            const DeepCollectionEquality().equals(
              selectedBackgroundColor,
              other.selectedBackgroundColor,
            ) &&
            const DeepCollectionEquality().equals(
              checkAnimationDuration,
              other.checkAnimationDuration,
            ) &&
            const DeepCollectionEquality().equals(
              checkAnimationInCurve,
              other.checkAnimationInCurve,
            ) &&
            const DeepCollectionEquality().equals(
              checkAnimationOutCurve,
              other.checkAnimationOutCurve,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(backgroundColor),
      const DeepCollectionEquality().hash(borderRadius),
      const DeepCollectionEquality().hash(tileBorderColor),
      const DeepCollectionEquality().hash(tileBorderWidth),
      const DeepCollectionEquality().hash(selectedBackgroundColor),
      const DeepCollectionEquality().hash(checkAnimationDuration),
      const DeepCollectionEquality().hash(checkAnimationInCurve),
      const DeepCollectionEquality().hash(checkAnimationOutCurve),
    );
  }
}
