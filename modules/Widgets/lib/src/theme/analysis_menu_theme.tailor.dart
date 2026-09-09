// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analysis_menu_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AnalysisMenuThemeDataTailorMixin
    on ThemeExtension<AnalysisMenuThemeData> {
  Color get backgroundColor;
  Color get foregroundColor;
  double get borderRadius;
  int get columns;
  double get spacing;
  EdgeInsetsGeometry get padding;
  double get iconSize;

  @override
  AnalysisMenuThemeData copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    double? borderRadius,
    int? columns,
    double? spacing,
    EdgeInsetsGeometry? padding,
    double? iconSize,
  }) {
    return AnalysisMenuThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      columns: columns ?? this.columns,
      spacing: spacing ?? this.spacing,
      padding: padding ?? this.padding,
      iconSize: iconSize ?? this.iconSize,
    );
  }

  @override
  AnalysisMenuThemeData lerp(
    covariant ThemeExtension<AnalysisMenuThemeData>? other,
    double t,
  ) {
    if (other is! AnalysisMenuThemeData) return this as AnalysisMenuThemeData;
    return AnalysisMenuThemeData(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t)!,
      borderRadius: t < 0.5 ? borderRadius : other.borderRadius,
      columns: t < 0.5 ? columns : other.columns,
      spacing: t < 0.5 ? spacing : other.spacing,
      padding: t < 0.5 ? padding : other.padding,
      iconSize: t < 0.5 ? iconSize : other.iconSize,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AnalysisMenuThemeData &&
            const DeepCollectionEquality().equals(
              backgroundColor,
              other.backgroundColor,
            ) &&
            const DeepCollectionEquality().equals(
              foregroundColor,
              other.foregroundColor,
            ) &&
            const DeepCollectionEquality().equals(
              borderRadius,
              other.borderRadius,
            ) &&
            const DeepCollectionEquality().equals(columns, other.columns) &&
            const DeepCollectionEquality().equals(spacing, other.spacing) &&
            const DeepCollectionEquality().equals(padding, other.padding) &&
            const DeepCollectionEquality().equals(iconSize, other.iconSize));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(backgroundColor),
      const DeepCollectionEquality().hash(foregroundColor),
      const DeepCollectionEquality().hash(borderRadius),
      const DeepCollectionEquality().hash(columns),
      const DeepCollectionEquality().hash(spacing),
      const DeepCollectionEquality().hash(padding),
      const DeepCollectionEquality().hash(iconSize),
    );
  }
}
