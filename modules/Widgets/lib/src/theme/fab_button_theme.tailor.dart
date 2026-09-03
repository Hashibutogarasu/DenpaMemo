// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fab_button_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$FabButtonThemeDataTailorMixin on ThemeExtension<FabButtonThemeData> {
  Color get barrierColor;
  Duration get scrimAnimationDuration;
  Curve get scrimAnimationCurve;
  Duration get mainButtonAnimationDuration;
  Curve get miniOptionSlideCurve;
  Offset get miniOptionSlideOffset;
  double get labelBubbleElevation;
  double get labelBubbleBorderRadius;
  EdgeInsetsGeometry get labelBubblePadding;
  double get miniOptionGap;
  double get miniOptionRowBottomPadding;

  @override
  FabButtonThemeData copyWith({
    Color? barrierColor,
    Duration? scrimAnimationDuration,
    Curve? scrimAnimationCurve,
    Duration? mainButtonAnimationDuration,
    Curve? miniOptionSlideCurve,
    Offset? miniOptionSlideOffset,
    double? labelBubbleElevation,
    double? labelBubbleBorderRadius,
    EdgeInsetsGeometry? labelBubblePadding,
    double? miniOptionGap,
    double? miniOptionRowBottomPadding,
  }) {
    return FabButtonThemeData(
      barrierColor: barrierColor ?? this.barrierColor,
      scrimAnimationDuration:
          scrimAnimationDuration ?? this.scrimAnimationDuration,
      scrimAnimationCurve: scrimAnimationCurve ?? this.scrimAnimationCurve,
      mainButtonAnimationDuration:
          mainButtonAnimationDuration ?? this.mainButtonAnimationDuration,
      miniOptionSlideCurve: miniOptionSlideCurve ?? this.miniOptionSlideCurve,
      miniOptionSlideOffset:
          miniOptionSlideOffset ?? this.miniOptionSlideOffset,
      labelBubbleElevation: labelBubbleElevation ?? this.labelBubbleElevation,
      labelBubbleBorderRadius:
          labelBubbleBorderRadius ?? this.labelBubbleBorderRadius,
      labelBubblePadding: labelBubblePadding ?? this.labelBubblePadding,
      miniOptionGap: miniOptionGap ?? this.miniOptionGap,
      miniOptionRowBottomPadding:
          miniOptionRowBottomPadding ?? this.miniOptionRowBottomPadding,
    );
  }

  @override
  FabButtonThemeData lerp(
    covariant ThemeExtension<FabButtonThemeData>? other,
    double t,
  ) {
    if (other is! FabButtonThemeData) return this as FabButtonThemeData;
    return FabButtonThemeData(
      barrierColor: Color.lerp(barrierColor, other.barrierColor, t)!,
      scrimAnimationDuration: t < 0.5
          ? scrimAnimationDuration
          : other.scrimAnimationDuration,
      scrimAnimationCurve: t < 0.5
          ? scrimAnimationCurve
          : other.scrimAnimationCurve,
      mainButtonAnimationDuration: t < 0.5
          ? mainButtonAnimationDuration
          : other.mainButtonAnimationDuration,
      miniOptionSlideCurve: t < 0.5
          ? miniOptionSlideCurve
          : other.miniOptionSlideCurve,
      miniOptionSlideOffset: t < 0.5
          ? miniOptionSlideOffset
          : other.miniOptionSlideOffset,
      labelBubbleElevation: t < 0.5
          ? labelBubbleElevation
          : other.labelBubbleElevation,
      labelBubbleBorderRadius: t < 0.5
          ? labelBubbleBorderRadius
          : other.labelBubbleBorderRadius,
      labelBubblePadding: t < 0.5
          ? labelBubblePadding
          : other.labelBubblePadding,
      miniOptionGap: t < 0.5 ? miniOptionGap : other.miniOptionGap,
      miniOptionRowBottomPadding: t < 0.5
          ? miniOptionRowBottomPadding
          : other.miniOptionRowBottomPadding,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FabButtonThemeData &&
            const DeepCollectionEquality().equals(
              barrierColor,
              other.barrierColor,
            ) &&
            const DeepCollectionEquality().equals(
              scrimAnimationDuration,
              other.scrimAnimationDuration,
            ) &&
            const DeepCollectionEquality().equals(
              scrimAnimationCurve,
              other.scrimAnimationCurve,
            ) &&
            const DeepCollectionEquality().equals(
              mainButtonAnimationDuration,
              other.mainButtonAnimationDuration,
            ) &&
            const DeepCollectionEquality().equals(
              miniOptionSlideCurve,
              other.miniOptionSlideCurve,
            ) &&
            const DeepCollectionEquality().equals(
              miniOptionSlideOffset,
              other.miniOptionSlideOffset,
            ) &&
            const DeepCollectionEquality().equals(
              labelBubbleElevation,
              other.labelBubbleElevation,
            ) &&
            const DeepCollectionEquality().equals(
              labelBubbleBorderRadius,
              other.labelBubbleBorderRadius,
            ) &&
            const DeepCollectionEquality().equals(
              labelBubblePadding,
              other.labelBubblePadding,
            ) &&
            const DeepCollectionEquality().equals(
              miniOptionGap,
              other.miniOptionGap,
            ) &&
            const DeepCollectionEquality().equals(
              miniOptionRowBottomPadding,
              other.miniOptionRowBottomPadding,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(barrierColor),
      const DeepCollectionEquality().hash(scrimAnimationDuration),
      const DeepCollectionEquality().hash(scrimAnimationCurve),
      const DeepCollectionEquality().hash(mainButtonAnimationDuration),
      const DeepCollectionEquality().hash(miniOptionSlideCurve),
      const DeepCollectionEquality().hash(miniOptionSlideOffset),
      const DeepCollectionEquality().hash(labelBubbleElevation),
      const DeepCollectionEquality().hash(labelBubbleBorderRadius),
      const DeepCollectionEquality().hash(labelBubblePadding),
      const DeepCollectionEquality().hash(miniOptionGap),
      const DeepCollectionEquality().hash(miniOptionRowBottomPadding),
    );
  }
}
