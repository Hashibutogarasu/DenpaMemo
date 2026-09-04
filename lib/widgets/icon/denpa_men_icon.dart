import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension;
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
    return ResolvedEntityIcon(file: iconAsync.value, size: size);
  }
}
