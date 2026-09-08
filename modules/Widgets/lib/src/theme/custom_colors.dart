import 'package:flutter/material.dart';

/// Semantic colors ([success], [warning], [info]) derived purely from a
/// [ColorScheme]'s own [ColorScheme.brightness], the same way
/// `ColorScheme.error` is always available without being supplied by the
/// app. Anchored on fixed hues (green/amber/blue) carried at a lightness
/// appropriate for the scheme's brightness, so both light and dark themes
/// get a legible, correctly-contrasted result automatically.
extension CustomColors on ColorScheme {
  Color get success => _tonal(const Color(0xFF2E7D32));

  Color get warning => _tonal(const Color(0xFFF9A825));

  Color get info => _tonal(const Color(0xFF0277BD));

  Color _tonal(Color anchor) {
    final hsl = HSLColor.fromColor(anchor);
    final lightness = brightness == Brightness.dark
        ? (hsl.lightness + 0.18).clamp(0.0, 1.0)
        : hsl.lightness;
    return hsl.withLightness(lightness.toDouble()).toColor();
  }
}
