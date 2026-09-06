import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension, Translations, t;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/clipping/clipping_slot_storage.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/clipping_slot_providers.dart';
import '../providers/profile_providers.dart';
import '../widgets/dialog/confirm_dialog.dart';

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
/// their display/priority order. All persistence/file-picking/cropping
/// work is delegated to `ClippingSettingsController`; this page only
/// builds UI, tracks the reorder drag's optimistic local state, and
/// reacts to the controller's results.
class ClippingSettingsPage extends ConsumerStatefulWidget {
  const ClippingSettingsPage({super.key});

  @override
  ConsumerState<ClippingSettingsPage> createState() =>
      _ClippingSettingsPageState();
}

class _ClippingSettingsPageState extends ConsumerState<ClippingSettingsPage> {
  List<DenpaMenImageSlotType>? _order;
  bool _isReordering = false;

  void _reorder(int oldIndex, int newIndex) {
    final adjustedNewIndex = newIndex > oldIndex ? newIndex - 1 : newIndex;
    final reordered = List<DenpaMenImageSlotType>.from(_order!);
    final moved = reordered.removeAt(oldIndex);
    reordered.insert(adjustedNewIndex, moved);

    setState(() {
      _order = reordered;
      _isReordering = true;
    });
    ref.read(clippingSettingsControllerProvider).saveOrder(reordered).then((_) {
      if (!mounted) {
        return;
      }
      setState(() => _isReordering = false);
    });
  }

  Future<void> _reset() async {
    final t = context.t;
    final confirmed = await ConfirmDialog.show(
      context,
      title: t.settings.clippingResetConfirmTitle,
      message: t.settings.clippingResetConfirmMessage,
    );
    if (!confirmed || !mounted) {
      return;
    }
    await ref.read(clippingSettingsControllerProvider).reset();
    if (!mounted) {
      return;
    }
    setState(() => _order = null);
  }

  Future<void> _switchProfile() async {
    await ref.read(clippingSettingsControllerProvider).switchProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final orderedTypesAsync = ref.watch(clippingSlotTypesByPriorityProvider);
    final currentProfile = ref.watch(
      currentProfileProvider(ClippingSlotStorage.profileNamespace),
    );

    if (orderedTypesAsync.value case final order? when !_isReordering) {
      _order = order;
    }
    final order = _order;

    return AppScaffold(
      title: OutlinedTitleText(
        text: switch (currentProfile) {
          AsyncData(:final value) => t.page.clippingSettingsTitle(
            profileName: value.name,
          ),
          _ => t.page.clippingSettings,
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'clippingSettingsReset',
            onPressed: _reset,
            label: Text(t.common.reset),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.extended(
            heroTag: 'clippingSettingsSwitchProfile',
            onPressed: _switchProfile,
            label: Text(t.profile.switchProfile),
          ),
        ],
      ),
      body: order == null
          ? orderedTypesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text(error.toString())),
              data: (order) => const SizedBox.shrink(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ColoredBox(
                  color: Colors.transparent,
                  child: ReorderableListView(
                    buildDefaultDragHandles: false,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    onReorder: _reorder,
                    children: [
                      for (var i = 0; i < order.length; i++)
                        _ClippingSlotTile(
                          key: ValueKey(order[i].name),
                          index: i,
                          slotType: order[i],
                        ),
                    ],
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
  });

  final int index;
  final DenpaMenImageSlotType slotType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final slotAsync = ref.watch(clippingSlotProvider(slotType));
    final slot = slotAsync.value;

    return ListItemTile(
      icon: _iconFor(slotType),
      label: slot?.name ?? defaultClippingSlotLabel(slotType),
      subtitle: Text(slot != null ? _rangeText(t, slot) : t.common.unset),
      onTap: () => ref
          .read(clippingSettingsControllerProvider)
          .configureSlot(context, slotType: slotType, existing: slot),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (slot != null)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => ref
                  .read(clippingSettingsControllerProvider)
                  .deleteSlot(slotType),
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
