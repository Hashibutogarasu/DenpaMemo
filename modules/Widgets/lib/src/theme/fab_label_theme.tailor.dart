// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fab_label_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$FabLabelThemeDataTailorMixin on ThemeExtension<FabLabelThemeData> {
  bool get showLabel;
  bool get showTooltip;

  @override
  FabLabelThemeData copyWith({bool? showLabel, bool? showTooltip}) {
    return FabLabelThemeData(
      showLabel: showLabel ?? this.showLabel,
      showTooltip: showTooltip ?? this.showTooltip,
    );
  }

  @override
  FabLabelThemeData lerp(
    covariant ThemeExtension<FabLabelThemeData>? other,
    double t,
  ) {
    if (other is! FabLabelThemeData) return this as FabLabelThemeData;
    return FabLabelThemeData(
      showLabel: t < 0.5 ? showLabel : other.showLabel,
      showTooltip: t < 0.5 ? showTooltip : other.showTooltip,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FabLabelThemeData &&
            const DeepCollectionEquality().equals(showLabel, other.showLabel) &&
            const DeepCollectionEquality().equals(
              showTooltip,
              other.showTooltip,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(showLabel),
      const DeepCollectionEquality().hash(showTooltip),
    );
  }
}
