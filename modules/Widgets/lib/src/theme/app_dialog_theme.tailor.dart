// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_dialog_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AppDialogThemeDataTailorMixin on ThemeExtension<AppDialogThemeData> {
  Duration get transitionDuration;
  Curve get transitionCurve;
  Curve get reverseTransitionCurve;
  Color get barrierColor;
  EdgeInsetsGeometry get insetPadding;

  @override
  AppDialogThemeData copyWith({
    Duration? transitionDuration,
    Curve? transitionCurve,
    Curve? reverseTransitionCurve,
    Color? barrierColor,
    EdgeInsetsGeometry? insetPadding,
  }) {
    return AppDialogThemeData(
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      reverseTransitionCurve:
          reverseTransitionCurve ?? this.reverseTransitionCurve,
      barrierColor: barrierColor ?? this.barrierColor,
      insetPadding: insetPadding ?? this.insetPadding,
    );
  }

  @override
  AppDialogThemeData lerp(
    covariant ThemeExtension<AppDialogThemeData>? other,
    double t,
  ) {
    if (other is! AppDialogThemeData) return this as AppDialogThemeData;
    return AppDialogThemeData(
      transitionDuration: t < 0.5
          ? transitionDuration
          : other.transitionDuration,
      transitionCurve: t < 0.5 ? transitionCurve : other.transitionCurve,
      reverseTransitionCurve: t < 0.5
          ? reverseTransitionCurve
          : other.reverseTransitionCurve,
      barrierColor: Color.lerp(barrierColor, other.barrierColor, t)!,
      insetPadding: t < 0.5 ? insetPadding : other.insetPadding,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppDialogThemeData &&
            const DeepCollectionEquality().equals(
              transitionDuration,
              other.transitionDuration,
            ) &&
            const DeepCollectionEquality().equals(
              transitionCurve,
              other.transitionCurve,
            ) &&
            const DeepCollectionEquality().equals(
              reverseTransitionCurve,
              other.reverseTransitionCurve,
            ) &&
            const DeepCollectionEquality().equals(
              barrierColor,
              other.barrierColor,
            ) &&
            const DeepCollectionEquality().equals(
              insetPadding,
              other.insetPadding,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(transitionDuration),
      const DeepCollectionEquality().hash(transitionCurve),
      const DeepCollectionEquality().hash(reverseTransitionCurve),
      const DeepCollectionEquality().hash(barrierColor),
      const DeepCollectionEquality().hash(insetPadding),
    );
  }
}
