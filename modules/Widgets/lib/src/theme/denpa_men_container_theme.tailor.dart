// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'denpa_men_container_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$DenpaMenContainerThemeDataTailorMixin
    on ThemeExtension<DenpaMenContainerThemeData> {
  Color get statusBackgroundColor;
  double get statusBorderRadius;
  Color get nestedBackgroundColor;
  Color get nestedBorderColor;
  double get nestedBorderWidth;
  double get nestedBorderRadius;
  Color get accentColor;
  Color get memoBackgroundColor;
  double get memoBorderRadius;
  double get headerDividerHeight;
  double get pencilIconSize;
  double get previewIconSize;
  double get accordionIconSize;
  double get accordionTitleFontSize;
  double get accordionCheckboxSlotSize;
  Duration get accordionAnimationDuration;
  double get resistanceGap;
  Color get nameFieldFillColor;

  @override
  DenpaMenContainerThemeData copyWith({
    Color? statusBackgroundColor,
    double? statusBorderRadius,
    Color? nestedBackgroundColor,
    Color? nestedBorderColor,
    double? nestedBorderWidth,
    double? nestedBorderRadius,
    Color? accentColor,
    Color? memoBackgroundColor,
    double? memoBorderRadius,
    double? headerDividerHeight,
    double? pencilIconSize,
    double? previewIconSize,
    double? accordionIconSize,
    double? accordionTitleFontSize,
    double? accordionCheckboxSlotSize,
    Duration? accordionAnimationDuration,
    double? resistanceGap,
    Color? nameFieldFillColor,
  }) {
    return DenpaMenContainerThemeData(
      statusBackgroundColor:
          statusBackgroundColor ?? this.statusBackgroundColor,
      statusBorderRadius: statusBorderRadius ?? this.statusBorderRadius,
      nestedBackgroundColor:
          nestedBackgroundColor ?? this.nestedBackgroundColor,
      nestedBorderColor: nestedBorderColor ?? this.nestedBorderColor,
      nestedBorderWidth: nestedBorderWidth ?? this.nestedBorderWidth,
      nestedBorderRadius: nestedBorderRadius ?? this.nestedBorderRadius,
      accentColor: accentColor ?? this.accentColor,
      memoBackgroundColor: memoBackgroundColor ?? this.memoBackgroundColor,
      memoBorderRadius: memoBorderRadius ?? this.memoBorderRadius,
      headerDividerHeight: headerDividerHeight ?? this.headerDividerHeight,
      pencilIconSize: pencilIconSize ?? this.pencilIconSize,
      previewIconSize: previewIconSize ?? this.previewIconSize,
      accordionIconSize: accordionIconSize ?? this.accordionIconSize,
      accordionTitleFontSize:
          accordionTitleFontSize ?? this.accordionTitleFontSize,
      accordionCheckboxSlotSize:
          accordionCheckboxSlotSize ?? this.accordionCheckboxSlotSize,
      accordionAnimationDuration:
          accordionAnimationDuration ?? this.accordionAnimationDuration,
      resistanceGap: resistanceGap ?? this.resistanceGap,
      nameFieldFillColor: nameFieldFillColor ?? this.nameFieldFillColor,
    );
  }

  @override
  DenpaMenContainerThemeData lerp(
    covariant ThemeExtension<DenpaMenContainerThemeData>? other,
    double t,
  ) {
    if (other is! DenpaMenContainerThemeData)
      return this as DenpaMenContainerThemeData;
    return DenpaMenContainerThemeData(
      statusBackgroundColor: Color.lerp(
        statusBackgroundColor,
        other.statusBackgroundColor,
        t,
      )!,
      statusBorderRadius: t < 0.5
          ? statusBorderRadius
          : other.statusBorderRadius,
      nestedBackgroundColor: Color.lerp(
        nestedBackgroundColor,
        other.nestedBackgroundColor,
        t,
      )!,
      nestedBorderColor: Color.lerp(
        nestedBorderColor,
        other.nestedBorderColor,
        t,
      )!,
      nestedBorderWidth: t < 0.5 ? nestedBorderWidth : other.nestedBorderWidth,
      nestedBorderRadius: t < 0.5
          ? nestedBorderRadius
          : other.nestedBorderRadius,
      accentColor: Color.lerp(accentColor, other.accentColor, t)!,
      memoBackgroundColor: Color.lerp(
        memoBackgroundColor,
        other.memoBackgroundColor,
        t,
      )!,
      memoBorderRadius: t < 0.5 ? memoBorderRadius : other.memoBorderRadius,
      headerDividerHeight: t < 0.5
          ? headerDividerHeight
          : other.headerDividerHeight,
      pencilIconSize: t < 0.5 ? pencilIconSize : other.pencilIconSize,
      previewIconSize: t < 0.5 ? previewIconSize : other.previewIconSize,
      accordionIconSize: t < 0.5 ? accordionIconSize : other.accordionIconSize,
      accordionTitleFontSize: t < 0.5
          ? accordionTitleFontSize
          : other.accordionTitleFontSize,
      accordionCheckboxSlotSize: t < 0.5
          ? accordionCheckboxSlotSize
          : other.accordionCheckboxSlotSize,
      accordionAnimationDuration: t < 0.5
          ? accordionAnimationDuration
          : other.accordionAnimationDuration,
      resistanceGap: t < 0.5 ? resistanceGap : other.resistanceGap,
      nameFieldFillColor: Color.lerp(
        nameFieldFillColor,
        other.nameFieldFillColor,
        t,
      )!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DenpaMenContainerThemeData &&
            const DeepCollectionEquality().equals(
              statusBackgroundColor,
              other.statusBackgroundColor,
            ) &&
            const DeepCollectionEquality().equals(
              statusBorderRadius,
              other.statusBorderRadius,
            ) &&
            const DeepCollectionEquality().equals(
              nestedBackgroundColor,
              other.nestedBackgroundColor,
            ) &&
            const DeepCollectionEquality().equals(
              nestedBorderColor,
              other.nestedBorderColor,
            ) &&
            const DeepCollectionEquality().equals(
              nestedBorderWidth,
              other.nestedBorderWidth,
            ) &&
            const DeepCollectionEquality().equals(
              nestedBorderRadius,
              other.nestedBorderRadius,
            ) &&
            const DeepCollectionEquality().equals(
              accentColor,
              other.accentColor,
            ) &&
            const DeepCollectionEquality().equals(
              memoBackgroundColor,
              other.memoBackgroundColor,
            ) &&
            const DeepCollectionEquality().equals(
              memoBorderRadius,
              other.memoBorderRadius,
            ) &&
            const DeepCollectionEquality().equals(
              headerDividerHeight,
              other.headerDividerHeight,
            ) &&
            const DeepCollectionEquality().equals(
              pencilIconSize,
              other.pencilIconSize,
            ) &&
            const DeepCollectionEquality().equals(
              previewIconSize,
              other.previewIconSize,
            ) &&
            const DeepCollectionEquality().equals(
              accordionIconSize,
              other.accordionIconSize,
            ) &&
            const DeepCollectionEquality().equals(
              accordionTitleFontSize,
              other.accordionTitleFontSize,
            ) &&
            const DeepCollectionEquality().equals(
              accordionCheckboxSlotSize,
              other.accordionCheckboxSlotSize,
            ) &&
            const DeepCollectionEquality().equals(
              accordionAnimationDuration,
              other.accordionAnimationDuration,
            ) &&
            const DeepCollectionEquality().equals(
              resistanceGap,
              other.resistanceGap,
            ) &&
            const DeepCollectionEquality().equals(
              nameFieldFillColor,
              other.nameFieldFillColor,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(statusBackgroundColor),
      const DeepCollectionEquality().hash(statusBorderRadius),
      const DeepCollectionEquality().hash(nestedBackgroundColor),
      const DeepCollectionEquality().hash(nestedBorderColor),
      const DeepCollectionEquality().hash(nestedBorderWidth),
      const DeepCollectionEquality().hash(nestedBorderRadius),
      const DeepCollectionEquality().hash(accentColor),
      const DeepCollectionEquality().hash(memoBackgroundColor),
      const DeepCollectionEquality().hash(memoBorderRadius),
      const DeepCollectionEquality().hash(headerDividerHeight),
      const DeepCollectionEquality().hash(pencilIconSize),
      const DeepCollectionEquality().hash(previewIconSize),
      const DeepCollectionEquality().hash(accordionIconSize),
      const DeepCollectionEquality().hash(accordionTitleFontSize),
      const DeepCollectionEquality().hash(accordionCheckboxSlotSize),
      const DeepCollectionEquality().hash(accordionAnimationDuration),
      const DeepCollectionEquality().hash(resistanceGap),
      const DeepCollectionEquality().hash(nameFieldFillColor),
    );
  }
}
