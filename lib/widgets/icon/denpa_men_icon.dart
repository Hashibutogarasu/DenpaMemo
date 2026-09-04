import 'dart:io';

import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension, Translations, t;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/clipping_slot_providers.dart';
import '../../providers/denpa_men_icon_providers.dart';
import '../../providers/entity_image_providers.dart';

/// Shows the icon image set for the `DenpaMen` with [denpaMenId], or a
/// placeholder box if it has none set yet. Tapping it opens every built-in
/// [DenpaMenImageSlotType] image (`face`/`wholeBody`/`icon`) it has saved
/// in a swipeable [MediaZoomDialog] — each rendered, in memory, through
/// [denpaMenId]'s own assigned clipping profile only once this widget is
/// actually built, rather than upfront for every individual in a list.
class DenpaMenIcon extends ConsumerWidget {
  const DenpaMenIcon({super.key, required this.denpaMenId, required this.size});

  final String denpaMenId;
  final double size;

  Future<void> _showZoom(BuildContext context, WidgetRef ref) async {
    final profileId = await ref.read(
      denpaMenClippingProfileIdProvider(denpaMenId).future,
    );
    final files = <File>[];
    final labels = <String>[];
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
        labels.add(defaultClippingSlotLabel(slotType));
      }
    }
    if (!context.mounted) {
      return;
    }
    await MediaZoomDialog.showImages(context, images: files, labels: labels);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconAsync = ref.watch(denpaMenIconProvider(denpaMenId));
    return GestureDetector(
      onTap: () => _showZoom(context, ref),
      child: ResolvedEntityIcon(file: iconAsync.value, size: size),
    );
  }
}
