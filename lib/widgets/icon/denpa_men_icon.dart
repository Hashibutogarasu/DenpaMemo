import 'dart:io';

import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:denpa_memo/widgets.dart' hide Translations, t;
import '../../providers/clipping_slot_providers.dart';
import '../../providers/denpa_men_icon_providers.dart';
import '../../providers/entity_image_providers.dart';

/// Shows the icon image set for the `DenpaMen` with [denpaMenId], or a
/// placeholder box if it has none set yet. If [denpaMenId] has a clipping
/// profile assigned, tapping it opens every built-in
/// [DenpaMenImageSlotType] image (`face`/`wholeBody`/`icon`) it has saved
/// in a swipeable [MediaZoomDialog] — each rendered, in memory, only once
/// this widget is actually built, rather than upfront for every
/// individual in a list. With no profile assigned, tapping just opens
/// the single representative image, unclipped — clipping being
/// unspecified means there's nothing to offer a choice between.
class DenpaMenIcon extends ConsumerWidget {
  const DenpaMenIcon({super.key, required this.denpaMenId, required this.size});

  final String denpaMenId;
  final double size;

  Future<void> _show(BuildContext context, WidgetRef ref) async {
    final profileId = await ref.read(
      denpaMenClippingProfileIdProvider(denpaMenId).future,
    );
    if (profileId == null) {
      final file = await ref.read(denpaMenIconProvider(denpaMenId).future);
      if (file == null || !context.mounted) {
        return;
      }
      await MediaZoomDialog.show(context, images: [file]);
      return;
    }

    final files = <File>[];
    for (final slotType in DenpaMenImageSlotType.values) {
      final file = await ref.read(
        entityImageProvider((
          denpaMenIconCategory,
          denpaMenId,
          slotType,
          profileId,
        )).future,
      );
      if (file != null) {
        files.add(file);
      }
    }
    if (!context.mounted) {
      return;
    }
    await MediaZoomDialog.show(context, images: files);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconAsync = ref.watch(denpaMenIconProvider(denpaMenId));
    return GestureDetector(
      onTap: () => _show(context, ref),
      child: ResolvedEntityIcon(file: iconAsync.value, size: size),
    );
  }
}
