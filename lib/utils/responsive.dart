import 'package:flutter/material.dart';

/// Width below which the app switches to the mobile layout. Matches
/// Material Design's compact window size class boundary.
const double kMobileBreakpoint = 600;

/// Returns whether [context]'s current width is narrow enough to use the
/// mobile layout.
bool isMobileWidth(BuildContext context) =>
    MediaQuery.sizeOf(context).width < kMobileBreakpoint;
