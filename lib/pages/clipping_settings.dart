import 'dart:io';

import 'package:croppy/croppy.dart';
import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension, Translations, t;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/clipping/clipping_slot_storage.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/clipping_slot_providers.dart';
import '../providers/profile_providers.dart';
import '../routing/app_router.dart';
import '../widgets/list/list_item_tile.dart';

String _defaultLabelFor(Translations t, DenpaMenImageSlotType slotType) {
  switch (slotType) {
    case DenpaMenImageSlotType.face:
      return t.settings.clippingFace;
    case DenpaMenImageSlotType.wholeBody:
      return t.settings.clippingWholeBody;
    case DenpaMenImageSlotType.icon:
      return t.settings.clippingIcon;
  }
}

IconData _iconFor(DenpaMenImageSlotType slotType) {
  switch (slotType) {
    case DenpaMenImageSlotType.face:
      return Icons.face_outlined;
    case DenpaMenImageSlotType.wholeBody:
      return Icons.accessibility_new_outlined;
    case DenpaMenImageSlotType.icon:
      return Icons.image_outlined;
  }
}

String _rangeText(Translations t, ClippingSlot slot) {
  int pct(double value) => (value * 100).round();
  return t.settings.clippingRangeText(
    left: pct(slot.left),
    top: pct(slot.top),
    right: pct(slot.right),
    bottom: pct(slot.bottom),
  );
}

/// Lets the user register a [ClippingSlot] (a reusable relative crop
/// rectangle) for each [DenpaMenImageSlotType] by picking an example
/// image and cropping it once, and reorder slots by dragging to change
/// `ClippingSlot.priority` (which decides representative-thumbnail
/// selection, see `denpaMenIconProvider`).
class ClippingSettingsPage extends ConsumerWidget {
  const ClippingSettingsPage({super.key});

  Future<void> _configureSlot(
    BuildContext context,
    WidgetRef ref,
    DenpaMenImageSlotType slotType,
    ClippingSlot? existing,
  ) async {
    final result = await FilePicker.pickFiles(type: FileType.image);
    final pickedPath = result?.files.single.path;
    if (pickedPath == null || !context.mounted) {
      return;
    }

    final cropResult = await showMaterialImageCropper(
      context,
      imageProvider: FileImage(File(pickedPath)),
      allowedAspectRatios: slotType == DenpaMenImageSlotType.icon
          ? const [CropAspectRatio(width: 1, height: 1)]
          : null,
    );
    if (cropResult == null || !context.mounted) {
      return;
    }

    final data = cropResult.transformationsData;
    final rect = data.cropRect;
    final size = data.imageSize;

    final defaultName = existing?.name ?? _defaultLabelFor(context.t, slotType);
    final name = await _promptName(context, defaultName);
    if (name == null) {
      return;
    }

    final slot = createClippingSlot(
      slotType: slotType,
      name: name,
      priority:
          existing?.priority ??
          DenpaMenImageSlotType.defaultPriority[slotType]!,
      left: rect.left / size.width,
      top: rect.top / size.height,
      right: rect.right / size.width,
      bottom: rect.bottom / size.height,
    );
    await ref.read(clippingSlotStorageProvider).save(slot);
    ref.invalidate(clippingSlotProvider(slotType));
    ref.invalidate(clippingSlotTypesByPriorityProvider);
  }

  Future<String?> _promptName(BuildContext context, String initial) async {
    final controller = TextEditingController(text: initial);
    final t = context.t;
    try {
      return await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(controller: controller, autofocus: true),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(t.common.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: Text(t.common.ok),
            ),
          ],
        ),
      );
    } finally {
      controller.dispose();
    }
  }

  Future<void> _reorder(
    WidgetRef ref,
    List<DenpaMenImageSlotType> order,
    int oldIndex,
    int newIndex,
  ) async {
    final adjustedNewIndex = newIndex > oldIndex ? newIndex - 1 : newIndex;
    final reordered = List<DenpaMenImageSlotType>.from(order);
    final moved = reordered.removeAt(oldIndex);
    reordered.insert(adjustedNewIndex, moved);

    final storage = ref.read(clippingSlotStorageProvider);
    for (var i = 0; i < reordered.length; i++) {
      final slotType = reordered[i];
      final existing = await storage.load(slotType);
      if (existing != null) {
        if (existing.priority != i) {
          await storage.save(existing.copyWith(priority: i));
        }
      } else {
        await storage.save(
          createClippingSlot(
            slotType: slotType,
            name: _defaultLabelFor(t, slotType),
            priority: i,
            left: 0,
            top: 0,
            right: 1,
            bottom: 1,
          ),
        );
      }
    }
    for (final slotType in reordered) {
      ref.invalidate(clippingSlotProvider(slotType));
    }
    ref.invalidate(clippingSlotTypesByPriorityProvider);
  }

  Future<void> _switchProfile(BuildContext context, WidgetRef ref) async {
    await const ProfileSwitchRoute(
      namespace: ClippingSlotStorage.profileNamespace,
    ).push<bool>(context);
    ref.invalidate(currentProfileProvider(ClippingSlotStorage.profileNamespace));
    ref.invalidate(clippingSlotTypesByPriorityProvider);
    for (final slotType in DenpaMenImageSlotType.values) {
      ref.invalidate(clippingSlotProvider(slotType));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final orderedTypes = ref.watch(clippingSlotTypesByPriorityProvider);
    final currentProfile = ref.watch(
      currentProfileProvider(ClippingSlotStorage.profileNamespace),
    );

    return AppScaffold(
      title: OutlinedTitleText(
        text: switch (currentProfile) {
          AsyncData(:final value) => t.page.clippingSettingsTitle(
            profileName: value.name,
          ),
          _ => t.page.clippingSettings,
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _switchProfile(context, ref),
        label: Text(t.profile.switchProfile),
      ),
      body: orderedTypes.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (order) => Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: ColoredBox(
              color: Colors.transparent,
              child: ReorderableListView(
                buildDefaultDragHandles: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                onReorder: (oldIndex, newIndex) =>
                    _reorder(ref, order, oldIndex, newIndex),
                children: [
                  for (var i = 0; i < order.length; i++)
                    _ClippingSlotTile(
                      key: ValueKey(order[i].name),
                      index: i,
                      slotType: order[i],
                      onTap: (existing) =>
                          _configureSlot(context, ref, order[i], existing),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ClippingSlotTile extends ConsumerWidget {
  const _ClippingSlotTile({
    required super.key,
    required this.index,
    required this.slotType,
    required this.onTap,
  });

  final int index;
  final DenpaMenImageSlotType slotType;
  final void Function(ClippingSlot? existing) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final slotAsync = ref.watch(clippingSlotProvider(slotType));
    final slot = slotAsync.value;

    return ListItemTile(
      icon: _iconFor(slotType),
      label: slot?.name ?? _defaultLabelFor(t, slotType),
      subtitle: slot != null ? _rangeText(t, slot) : t.common.unset,
      onTap: () => onTap(slot),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (slot != null)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async {
                await ref.read(clippingSlotStorageProvider).delete(slotType);
                ref.invalidate(clippingSlotProvider(slotType));
                ref.invalidate(clippingSlotTypesByPriorityProvider);
              },
            ),
          ReorderableDragStartListener(
            index: index,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.drag_handle),
            ),
          ),
        ],
      ),
    );
  }
}
