import 'package:flutter/material.dart';

/// Centralized color palette for the app's custom widgets, referenced by
/// role instead of scattering raw hex values across call sites.
abstract final class AppColors {
  static const Color statusBackground = Color(0xFF90E2FF);
  static const Color accent = Color(0xFF056193);
  static const Color pillBackground = Color(0xFF7FC9FF);
  static const Color pillText = Color(0xFF2B2031);
  static const Color nestedBackground = Color(0xFFC8E0E7);
  static const Color nestedBorder = Color(0xFF90DAFE);
  static const Color headerBackground = Color(0xFF52BBE5);
  static const Color headerBorder = Color(0xFF0865C2);
  static const Color headerTitleOutline = Color(0xFF238BCB);
  static const Color expBarFilled = Color(0xFFFFEB3B);
  static const Color expBarUnfilled = accent;
  static const Color maxedValue = Color(0xFF7BEA95);
  static const Color inactiveBonus = Color(0xFFE53935);
}
