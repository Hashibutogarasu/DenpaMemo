import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:denpa_memo/widgets.dart';
import '../data/server/physique_table_args.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/physique_table_edit_providers.dart';
import '../providers/physiques_providers.dart';
import '../routing/app_router.dart';
import '../widgets/physique_table/physique_table_body.dart';

/// Read-only display of one physique table (a `type`/`level`/
/// `anntenaCategory` triple). The table body is [PhysiqueTableBody] —
/// shared with the physique-identification "matching location" page's HP
/// grid — while this page owns only the page-level chrome: title, and the
/// edit shortcut.
class PhysiqueTableViewPage extends ConsumerWidget {
  const PhysiqueTableViewPage({required this.args, super.key});

  final PhysiqueTableArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final editState = ref.watch(physiqueTableEditProvider(args));
    final rows = editState.rows;
    final typesAsync = ref.watch(tableTypesProvider);
    final type = typesAsync.value?.firstWhereOrNull(
      (type) => type.type == args.type,
    );
    final columnCount = type?.columnCount;
    return AppScaffold(
      title: OutlinedTitleText(
        text: t.physiqueTable.tableTitle(
          level: args.level,
          anntenaCategory: args.anntenaCategory,
          statusName: type == null
              ? ''
              : (t[type.translationKey] as String?) ?? type.type,
        ),
      ),
      floatingActionButton: rows == null || columnCount == null
          ? null
          : FloatingActionButton.extended(
              label: Text(t.physiqueTable.edit),
              onPressed: () =>
                  PhysiqueTableEditRoute($extra: args).push(context),
            ),
      body: PhysiqueTableBody(args: args),
    );
  }
}
