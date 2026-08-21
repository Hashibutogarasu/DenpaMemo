import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/denpa_men/denpa_men_record.dart';
import '../../domain/master_data/master_data.dart';
import '../../i18n/gen/strings.g.dart';
import '../../pages/birth_guide.dart';
import '../../pages/denpa_men_editor.dart';
import '../../providers/denpa_men_providers.dart';
import '../../providers/qr_code_providers.dart';
import '../../routing/app_router.dart';
import 'qr_code_image_dialog.dart';

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

Future<void> _showQrCode(
  BuildContext context,
  WidgetRef ref,
  String qrCodeId,
) async {
  final qrCodeRecord = ref
      .read(qrCodeRepositoryProvider)
      .getAll()
      .firstWhereOrNull((r) => r.qrCode.id == qrCodeId);
  if (qrCodeRecord != null && context.mounted) {
    await showDialog<void>(
      context: context,
      builder: (context) =>
          QrCodeImageDialog(rawValue: qrCodeRecord.qrCode.rawValue),
    );
  }
}

/// Builds the edit/delete menu entries for [record], each carrying its own
/// action as a [VoidCallback] rather than a shared action enum, so a menu
/// like this one only ever needs one place edited to add or remove an
/// entry.
List<PopupMenuEntry<VoidCallback>> denpaMenActionMenuItems(
  BuildContext context,
  WidgetRef ref, {
  required DenpaMenRecord record,
  required MasterData masterData,
}) {
  final t = context.t;
  final denpaMen = record.denpaMen;
  final qrCodeId = denpaMen.qrCodeId;
  return [
    if (qrCodeId != null)
      PopupMenuItem(
        value: () => _showQrCode(context, ref, qrCodeId),
        child: Text(t.home.showQrCodeAction),
      ),
    PopupMenuItem(
      value: () => AddDenpaMenRoute(
        $extra: DenpaMenEditorArgs(masterData: masterData, initial: record),
      ).push(context),
      child: Text(t.common.edit),
    ),
    if (denpaMen.parentIds.isNotEmpty)
      PopupMenuItem(
        value: () => BirthGuideRoute(
          $extra: BirthGuideArgs(masterData: masterData, target: record),
        ).push(context),
        child: Text(t.home.birthGuideAction),
      ),
    PopupMenuItem(
      value: () async {
        if (await confirmDenpaMenDelete(context)) {
          ref.read(denpaMenRepositoryProvider).delete(record.id);
        }
      },
      child: Text(t.common.delete),
    ),
  ];
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
    final action = await showMenu<VoidCallback>(
      context: context,
      position: RelativeRect.fromRect(
        globalPosition & const Size(1, 1),
        Offset.zero & overlay.size,
      ),
      items: denpaMenActionMenuItems(
        context,
        ref,
        record: record,
        masterData: masterData,
      ),
    );
    action?.call();
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
