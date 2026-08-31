import 'package:flutter/material.dart';

/// Shared bare [LinearProgressIndicator], used wherever the app shows an
/// in-progress state: [value] null renders an indeterminate animation
/// (e.g. master data still loading), a value between 0 and 1 renders a
/// determinate one (e.g. `.dm` import/export progress, see
/// `ImportExportProgressBar`). Pins itself to the bottom of whatever
/// space its parent gives it, so callers never need to wrap it in an
/// `Align` themselves.
class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, this.value});

  final double? value;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.bottomCenter,
    child: LinearProgressIndicator(value: value),
  );
}
