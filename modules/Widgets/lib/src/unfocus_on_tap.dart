import 'package:flutter/material.dart';

/// Wraps [child] in a tap region that unfocuses any active text field
/// before calling [onTap]. Use this for anything that opens a dialog or
/// otherwise navigates away: Flutter's [Navigator] restores focus to
/// whatever was focused beforehand once that route is popped, so without
/// this, an input the user had already focused would silently regain
/// focus (and reopen the keyboard) the moment the dialog closes.
///
/// Pass [enabled] instead of conditionally passing `null` for [onTap]; the
/// widget takes care of disabling the tap region itself.
class UnfocusOnTap extends StatelessWidget {
  const UnfocusOnTap({
    super.key,
    required this.onTap,
    required this.child,
    this.enabled = true,
    this.borderRadius,
  });

  final VoidCallback onTap;
  final Widget child;
  final bool enabled;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius,
      onTap: enabled
          ? () {
              FocusScope.of(context).unfocus();
              onTap();
            }
          : null,
      child: child,
    );
  }
}
