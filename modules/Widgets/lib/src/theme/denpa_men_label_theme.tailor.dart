// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'denpa_men_label_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$DenpaMenLabelThemeDataTailorMixin
    on ThemeExtension<DenpaMenLabelThemeData> {
  Color get headerTitleOutlineColor;
  Color get pillBackgroundColor;
  Color get pillTextColor;
  Color get expBarFilledColor;
  Color get expBarUnfilledColor;
  Color get maxedValueColor;
  Color get inactiveBonusColor;
  Color get titleFillColor;
  Color get expBarBorderColor;

  @override
  DenpaMenLabelThemeData copyWith({
    Color? headerTitleOutlineColor,
    Color? pillBackgroundColor,
    Color? pillTextColor,
    Color? expBarFilledColor,
    Color? expBarUnfilledColor,
    Color? maxedValueColor,
    Color? inactiveBonusColor,
    Color? titleFillColor,
    Color? expBarBorderColor,
  }) {
    return DenpaMenLabelThemeData(
      headerTitleOutlineColor:
          headerTitleOutlineColor ?? this.headerTitleOutlineColor,
      pillBackgroundColor: pillBackgroundColor ?? this.pillBackgroundColor,
      pillTextColor: pillTextColor ?? this.pillTextColor,
      expBarFilledColor: expBarFilledColor ?? this.expBarFilledColor,
      expBarUnfilledColor: expBarUnfilledColor ?? this.expBarUnfilledColor,
      maxedValueColor: maxedValueColor ?? this.maxedValueColor,
      inactiveBonusColor: inactiveBonusColor ?? this.inactiveBonusColor,
      titleFillColor: titleFillColor ?? this.titleFillColor,
      expBarBorderColor: expBarBorderColor ?? this.expBarBorderColor,
    );
  }

  @override
  DenpaMenLabelThemeData lerp(
    covariant ThemeExtension<DenpaMenLabelThemeData>? other,
    double t,
  ) {
    if (other is! DenpaMenLabelThemeData) return this as DenpaMenLabelThemeData;
    return DenpaMenLabelThemeData(
      headerTitleOutlineColor: Color.lerp(
        headerTitleOutlineColor,
        other.headerTitleOutlineColor,
        t,
      )!,
      pillBackgroundColor: Color.lerp(
        pillBackgroundColor,
        other.pillBackgroundColor,
        t,
      )!,
      pillTextColor: Color.lerp(pillTextColor, other.pillTextColor, t)!,
      expBarFilledColor: Color.lerp(
        expBarFilledColor,
        other.expBarFilledColor,
        t,
      )!,
      expBarUnfilledColor: Color.lerp(
        expBarUnfilledColor,
        other.expBarUnfilledColor,
        t,
      )!,
      maxedValueColor: Color.lerp(maxedValueColor, other.maxedValueColor, t)!,
      inactiveBonusColor: Color.lerp(
        inactiveBonusColor,
        other.inactiveBonusColor,
        t,
      )!,
      titleFillColor: Color.lerp(titleFillColor, other.titleFillColor, t)!,
      expBarBorderColor: Color.lerp(
        expBarBorderColor,
        other.expBarBorderColor,
        t,
      )!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DenpaMenLabelThemeData &&
            const DeepCollectionEquality().equals(
              headerTitleOutlineColor,
              other.headerTitleOutlineColor,
            ) &&
            const DeepCollectionEquality().equals(
              pillBackgroundColor,
              other.pillBackgroundColor,
            ) &&
            const DeepCollectionEquality().equals(
              pillTextColor,
              other.pillTextColor,
            ) &&
            const DeepCollectionEquality().equals(
              expBarFilledColor,
              other.expBarFilledColor,
            ) &&
            const DeepCollectionEquality().equals(
              expBarUnfilledColor,
              other.expBarUnfilledColor,
            ) &&
            const DeepCollectionEquality().equals(
              maxedValueColor,
              other.maxedValueColor,
            ) &&
            const DeepCollectionEquality().equals(
              inactiveBonusColor,
              other.inactiveBonusColor,
            ) &&
            const DeepCollectionEquality().equals(
              titleFillColor,
              other.titleFillColor,
            ) &&
            const DeepCollectionEquality().equals(
              expBarBorderColor,
              other.expBarBorderColor,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(headerTitleOutlineColor),
      const DeepCollectionEquality().hash(pillBackgroundColor),
      const DeepCollectionEquality().hash(pillTextColor),
      const DeepCollectionEquality().hash(expBarFilledColor),
      const DeepCollectionEquality().hash(expBarUnfilledColor),
      const DeepCollectionEquality().hash(maxedValueColor),
      const DeepCollectionEquality().hash(inactiveBonusColor),
      const DeepCollectionEquality().hash(titleFillColor),
      const DeepCollectionEquality().hash(expBarBorderColor),
    );
  }
}
