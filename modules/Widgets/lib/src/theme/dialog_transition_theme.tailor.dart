// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dialog_transition_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$DialogTransitionThemeDataTailorMixin
    on ThemeExtension<DialogTransitionThemeData> {
  Duration get duration;
  Curve get curve;
  Curve get reverseCurve;
  Offset get beginOffset;

  @override
  DialogTransitionThemeData copyWith({
    Duration? duration,
    Curve? curve,
    Curve? reverseCurve,
    Offset? beginOffset,
  }) {
    return DialogTransitionThemeData(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      reverseCurve: reverseCurve ?? this.reverseCurve,
      beginOffset: beginOffset ?? this.beginOffset,
    );
  }

  @override
  DialogTransitionThemeData lerp(
    covariant ThemeExtension<DialogTransitionThemeData>? other,
    double t,
  ) {
    if (other is! DialogTransitionThemeData)
      return this as DialogTransitionThemeData;
    return DialogTransitionThemeData(
      duration: t < 0.5 ? duration : other.duration,
      curve: t < 0.5 ? curve : other.curve,
      reverseCurve: t < 0.5 ? reverseCurve : other.reverseCurve,
      beginOffset: t < 0.5 ? beginOffset : other.beginOffset,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DialogTransitionThemeData &&
            const DeepCollectionEquality().equals(duration, other.duration) &&
            const DeepCollectionEquality().equals(curve, other.curve) &&
            const DeepCollectionEquality().equals(
              reverseCurve,
              other.reverseCurve,
            ) &&
            const DeepCollectionEquality().equals(
              beginOffset,
              other.beginOffset,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(duration),
      const DeepCollectionEquality().hash(curve),
      const DeepCollectionEquality().hash(reverseCurve),
      const DeepCollectionEquality().hash(beginOffset),
    );
  }
}
