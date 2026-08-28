import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../i18n/gen/strings.g.dart';
import '../../pages/birth_guide.dart';
import '../../pages/denpa_men_editor.dart';
import '../../providers/denpa_men_providers.dart';
import '../../providers/dm_export_providers.dart';
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

/// Builds a debug-oriented JSON tree of [denpaMen]'s lineage, walking
/// [DenpaMen.parentIds] recursively via [byId]. Every node is [denpaMen]'s
/// full [DenpaMen.toJson] (every stat and feature, not just catch-order
/// fields) plus the resolved
/// [DenpaMenCatchOrderResolution.newCatchOrder], so catch-order bugs can be
/// inspected without a debugger.
Map<String, dynamic> _lineageTreeJson(
  DenpaMen denpaMen,
  Map<String, DenpaMen> byId, [
  Set<String>? visited,
]) {
  final seen = visited ?? <String>{};
  final node = <String, dynamic>{
    ...denpaMen.toJson(),
    'newCatchOrder': denpaMen.newCatchOrder(byId),
  };
  if (!seen.add(denpaMen.id)) {
    node['parents'] = const <dynamic>[];
    return node;
  }
  node['parents'] = [
    for (final parentId in denpaMen.parentIds)
      if (byId[parentId] case final parent?)
        _lineageTreeJson(parent, byId, seen)
      else
        {'id': parentId, 'missing': true},
  ];
  return node;
}

Future<void> _copyLineageTreeJson(
  WidgetRef ref,
  DenpaMenRecord record,
  MasterData masterData,
) async {
  final denpaMenRecords = ref
      .read(denpaMenRepositoryProvider)
      .getAll(masterData);
  final byId = {
    for (final r in denpaMenRecords) r.denpaMen.id: r.denpaMen,
  };
  final json = _lineageTreeJson(record.denpaMen, byId);
  await Clipboard.setData(
    ClipboardData(text: const JsonEncoder.withIndent('  ').convert(json)),
  );
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
    if (denpaMen.parentIds.isNotEmpty) ...[
      PopupMenuItem(
        value: () => BirthGuideRoute(
          $extra: BirthGuideArgs(masterData: masterData, target: record),
        ).push(context),
        child: Text(t.home.birthGuideAction),
      ),
      PopupMenuItem(
        value: () => _copyLineageTreeJson(ref, record, masterData),
        child: Text(t.home.copyLineageTreeJsonAction),
      ),
    ],
    if (ref.read(selectedDenpaMenIdsProvider).isNotEmpty)
      PopupMenuItem(
        value: () => exportSelectedDenpaMen(context, ref, masterData),
        child: Text(t.home.exportSelected),
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
