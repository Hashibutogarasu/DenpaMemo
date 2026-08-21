import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/denpa_men/denpa_men_record.dart';
import '../../domain/master_data/master_data.dart';
import '../../i18n/gen/strings.g.dart';
import '../../pages/birth_guide.dart';
import '../../pages/denpa_men_editor.dart';
import '../../providers/denpa_men_providers.dart';
import '../../routing/app_router.dart';

enum DenpaMenAction { edit, birthGuide, delete }

List<PopupMenuEntry<DenpaMenAction>> denpaMenActionMenuItems(
  BuildContext context, {
  required bool hasParents,
}) {
  final t = context.t;
  return [
    PopupMenuItem(value: DenpaMenAction.edit, child: Text(t.common.edit)),
    if (hasParents)
      PopupMenuItem(
        value: DenpaMenAction.birthGuide,
        child: Text(t.home.birthGuideAction),
      ),
    PopupMenuItem(value: DenpaMenAction.delete, child: Text(t.common.delete)),
  ];
}

Future<bool> confirmDenpaMenDelete(BuildContext context) async {
  final t = context.t;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(t.home.deleteConfirmTitle),
      content: Text(t.home.deleteConfirmMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(t.common.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(t.common.delete),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}

Future<void> handleDenpaMenAction(
  BuildContext context,
  WidgetRef ref,
  DenpaMenAction action, {
  required DenpaMenRecord record,
  required MasterData masterData,
}) async {
  switch (action) {
    case DenpaMenAction.edit:
      AddDenpaMenRoute(
        $extra: DenpaMenEditorArgs(masterData: masterData, initial: record),
      ).push(context);
    case DenpaMenAction.birthGuide:
      BirthGuideRoute(
        $extra: BirthGuideArgs(masterData: masterData, target: record),
      ).push(context);
    case DenpaMenAction.delete:
      if (await confirmDenpaMenDelete(context)) {
        ref.read(denpaMenRepositoryProvider).delete(record.id);
      }
  }
}

class DenpaMenContextMenuArea extends ConsumerWidget {
  const DenpaMenContextMenuArea({
    super.key,
    required this.record,
    required this.masterData,
    required this.child,
  });

  final DenpaMenRecord record;
  final MasterData masterData;
  final Widget child;

  Future<void> _showMenu(
    BuildContext context,
    WidgetRef ref,
    Offset globalPosition,
  ) async {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final action = await showMenu<DenpaMenAction>(
      context: context,
      position: RelativeRect.fromRect(
        globalPosition & const Size(1, 1),
        Offset.zero & overlay.size,
      ),
      items: denpaMenActionMenuItems(
        context,
        hasParents: record.denpaMen.parentIds.isNotEmpty,
      ),
    );
    if (action != null && context.mounted) {
      await handleDenpaMenAction(
        context,
        ref,
        action,
        record: record,
        masterData: masterData,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onSecondaryTapUp: (details) =>
          _showMenu(context, ref, details.globalPosition),
      onLongPressStart: (details) =>
          _showMenu(context, ref, details.globalPosition),
      child: child,
    );
  }
}
