// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'physique_legend_grid_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$PhysiqueLegendGridThemeDataTailorMixin
    on ThemeExtension<PhysiqueLegendGridThemeData> {
  Color get highlightBorderColor;
  Color get dimmedBackgroundColor;

  @override
  PhysiqueLegendGridThemeData copyWith({
    Color? highlightBorderColor,
    Color? dimmedBackgroundColor,
  }) {
    return PhysiqueLegendGridThemeData(
      highlightBorderColor: highlightBorderColor ?? this.highlightBorderColor,
      dimmedBackgroundColor:
          dimmedBackgroundColor ?? this.dimmedBackgroundColor,
    );
  }

  @override
  PhysiqueLegendGridThemeData lerp(
    covariant ThemeExtension<PhysiqueLegendGridThemeData>? other,
    double t,
  ) {
    if (other is! PhysiqueLegendGridThemeData)
      return this as PhysiqueLegendGridThemeData;
    return PhysiqueLegendGridThemeData(
      highlightBorderColor: Color.lerp(
        highlightBorderColor,
        other.highlightBorderColor,
        t,
      )!,
      dimmedBackgroundColor: Color.lerp(
        dimmedBackgroundColor,
        other.dimmedBackgroundColor,
        t,
      )!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PhysiqueLegendGridThemeData &&
            const DeepCollectionEquality().equals(
              highlightBorderColor,
              other.highlightBorderColor,
            ) &&
            const DeepCollectionEquality().equals(
              dimmedBackgroundColor,
              other.dimmedBackgroundColor,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(highlightBorderColor),
      const DeepCollectionEquality().hash(dimmedBackgroundColor),
    );
  }
}
