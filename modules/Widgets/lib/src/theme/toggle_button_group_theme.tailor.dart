// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'toggle_button_group_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ToggleButtonGroupThemeDataTailorMixin
    on ThemeExtension<ToggleButtonGroupThemeData> {
  Color get containerColor;
  double get containerElevation;
  double get containerBorderRadius;
  Color get highlightColor;
  double get highlightBorderRadius;
  Color get selectedIconColor;
  Color get unselectedIconColor;
  Duration get slideDuration;
  Curve get slideCurve;

  @override
  ToggleButtonGroupThemeData copyWith({
    Color? containerColor,
    double? containerElevation,
    double? containerBorderRadius,
    Color? highlightColor,
    double? highlightBorderRadius,
    Color? selectedIconColor,
    Color? unselectedIconColor,
    Duration? slideDuration,
    Curve? slideCurve,
  }) {
    return ToggleButtonGroupThemeData(
      containerColor: containerColor ?? this.containerColor,
      containerElevation: containerElevation ?? this.containerElevation,
      containerBorderRadius:
          containerBorderRadius ?? this.containerBorderRadius,
      highlightColor: highlightColor ?? this.highlightColor,
      highlightBorderRadius:
          highlightBorderRadius ?? this.highlightBorderRadius,
      selectedIconColor: selectedIconColor ?? this.selectedIconColor,
      unselectedIconColor: unselectedIconColor ?? this.unselectedIconColor,
      slideDuration: slideDuration ?? this.slideDuration,
      slideCurve: slideCurve ?? this.slideCurve,
    );
  }

  @override
  ToggleButtonGroupThemeData lerp(
    covariant ThemeExtension<ToggleButtonGroupThemeData>? other,
    double t,
  ) {
    if (other is! ToggleButtonGroupThemeData)
      return this as ToggleButtonGroupThemeData;
    return ToggleButtonGroupThemeData(
      containerColor: Color.lerp(containerColor, other.containerColor, t)!,
      containerElevation: t < 0.5
          ? containerElevation
          : other.containerElevation,
      containerBorderRadius: t < 0.5
          ? containerBorderRadius
          : other.containerBorderRadius,
      highlightColor: Color.lerp(highlightColor, other.highlightColor, t)!,
      highlightBorderRadius: t < 0.5
          ? highlightBorderRadius
          : other.highlightBorderRadius,
      selectedIconColor: Color.lerp(
        selectedIconColor,
        other.selectedIconColor,
        t,
      )!,
      unselectedIconColor: Color.lerp(
        unselectedIconColor,
        other.unselectedIconColor,
        t,
      )!,
      slideDuration: t < 0.5 ? slideDuration : other.slideDuration,
      slideCurve: t < 0.5 ? slideCurve : other.slideCurve,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ToggleButtonGroupThemeData &&
            const DeepCollectionEquality().equals(
              containerColor,
              other.containerColor,
            ) &&
            const DeepCollectionEquality().equals(
              containerElevation,
              other.containerElevation,
            ) &&
            const DeepCollectionEquality().equals(
              containerBorderRadius,
              other.containerBorderRadius,
            ) &&
            const DeepCollectionEquality().equals(
              highlightColor,
              other.highlightColor,
            ) &&
            const DeepCollectionEquality().equals(
              highlightBorderRadius,
              other.highlightBorderRadius,
            ) &&
            const DeepCollectionEquality().equals(
              selectedIconColor,
              other.selectedIconColor,
            ) &&
            const DeepCollectionEquality().equals(
              unselectedIconColor,
              other.unselectedIconColor,
            ) &&
            const DeepCollectionEquality().equals(
              slideDuration,
              other.slideDuration,
            ) &&
            const DeepCollectionEquality().equals(
              slideCurve,
              other.slideCurve,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(containerColor),
      const DeepCollectionEquality().hash(containerElevation),
      const DeepCollectionEquality().hash(containerBorderRadius),
      const DeepCollectionEquality().hash(highlightColor),
      const DeepCollectionEquality().hash(highlightBorderRadius),
      const DeepCollectionEquality().hash(selectedIconColor),
      const DeepCollectionEquality().hash(unselectedIconColor),
      const DeepCollectionEquality().hash(slideDuration),
      const DeepCollectionEquality().hash(slideCurve),
    );
  }
}
