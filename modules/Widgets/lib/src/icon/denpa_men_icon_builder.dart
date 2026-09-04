import 'dart:io';

import 'package:flutter/widgets.dart';

import 'entity_icon.dart';

/// Builds a `DenpaMen` individual's own icon widget at [size]. Lets
/// widgets in this package accept the app layer's zoomable `DenpaMenIcon`
/// without depending on it or on Riverpod directly.
typedef DenpaMenIconBuilder = Widget Function(double size);

/// A [DenpaMenIconBuilder] that always shows [file] (or a placeholder),
/// with no tap-to-swipe behavior — for callers with an already-resolved
/// file and no `DenpaMen` id to resolve a zoomable icon through instead.
DenpaMenIconBuilder staticDenpaMenIconBuilder(File? file) {
  return (size) => ResolvedEntityIcon(file: file, size: size);
}
