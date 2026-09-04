import 'package:collection/collection.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_editor/table_editor.dart';

import '../data/server/physique_table_args.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/physique_table_edit_providers.dart';
import '../providers/physiques_providers.dart';
import '../routing/app_router.dart';
import '../widgets/physique_table/physique_table_row.dart';

/// Read-only display of one physique table (a `type`/`level`/
/// `anntenaCategory` triple). Shares [physiqueTableEditProvider] with the
/// edit page — the list page normally primes it via `ensureLoaded()`
/// before navigating here, so this page mounts with data already in
/// hand; [initState] calls `ensureLoaded()` too, only as a fallback.
class PhysiqueTableViewPage extends ConsumerStatefulWidget {
  const PhysiqueTableViewPage({required this.args, super.key});

  final PhysiqueTableArgs args;

  @override
  ConsumerState<PhysiqueTableViewPage> createState() =>
      _PhysiqueTableViewPageState();
}

class _PhysiqueTableViewPageState extends ConsumerState<PhysiqueTableViewPage> {
  @override
  void initState() {
    super.initState();
    ref.read(physiqueTableEditProvider(widget.args).notifier).ensureLoaded();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final editState = ref.watch(physiqueTableEditProvider(widget.args));
    final rows = editState.rows;
    final typesAsync = ref.watch(tableTypesProvider);
    final columnCount = typesAsync.value
        ?.firstWhereOrNull((type) => type.type == widget.args.type)
        ?.columnCount;
    return AppScaffold(
      title: OutlinedTitleText(
        text: t.physiqueTable.tableTitle(
          level: widget.args.level,
          anntenaCategory: widget.args.anntenaCategory,
        ),
      ),
      body:
          editState.loadError ||
              typesAsync.hasError ||
              (typesAsync.hasValue && columnCount == null)
          ? Center(child: Text(t.physiqueTable.loadError))
          : LoadingOverlay(
              loading:
                  rows == null || typesAsync.isLoading || columnCount == null,
              child: rows == null || columnCount == null
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        Expanded(
                          child: rows.isEmpty
                              ? Center(child: Text(t.physiqueTable.empty))
                              : TableEditor<PhysiqueTableRow>(
                                  columns: buildPhysiqueTableColumns(
                                    columnCount: columnCount,
                                  ),
                                  data: rows,
                                  rowId: (row) => row.lineOffset.toString(),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: FilledButton.icon(
                            icon: const Icon(Icons.edit_outlined),
                            label: Text(t.physiqueTable.edit),
                            onPressed: () => PhysiqueTableEditRoute(
                              $extra: widget.args,
                            ).push(context),
                          ),
                        ),
                      ],
                    ),
            ),
    );
  }
}
