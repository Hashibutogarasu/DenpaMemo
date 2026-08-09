import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/denpa_men_icon_providers.dart';

/// Shows the icon image set for the `DenpaMen` with [denpaMenId], or a
/// placeholder box if it has none set yet.
class DenpaMenIcon extends ConsumerWidget {
  const DenpaMenIcon({super.key, required this.denpaMenId, required this.size});

  final String denpaMenId;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconAsync = ref.watch(denpaMenIconProvider(denpaMenId));

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: iconAsync.maybeWhen(
        data: (file) => file == null
            ? _placeholder()
            : Image.file(file, width: size, height: size, fit: BoxFit.cover),
        orElse: _placeholder,
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: size,
      height: size,
      color: Colors.white,
      alignment: Alignment.center,
      child: Icon(Icons.image_outlined, size: size * 0.6, color: Colors.grey),
    );
  }
}
