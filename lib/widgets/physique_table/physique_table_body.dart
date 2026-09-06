import 'package:collection/collection.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_editor/table_editor.dart';

import '../../data/server/physique_table_args.dart';
import '../../i18n/gen/strings.g.dart';
import '../../providers/physique_table_edit_providers.dart';
import '../../providers/physiques_providers.dart';
import 'physique_table_row.dart';

/// The physique table's shared fetch → column-width → [TableEditor]
/// pipeline: reads [args]'s rows from [physiqueTableEditProvider] and its
/// column count from [tableTypesProvider], and renders the same loading,
/// error, and empty states [PhysiqueTableViewPage] does. Both that page
/// and the physique-identification "matching location" page build their
/// HP grid from this single widget, so the two can never drift into
/// separate ad-hoc table implementations. [isHighlighted], when given,
/// marks one `(lineOffset, columnIndex)` cell with
/// `PhysiqueLegendGridThemeData`'s highlight border and dims every other
/// cell — see `buildPhysiqueTableColumns`.
class PhysiqueTableBody extends ConsumerStatefulWidget {
  const PhysiqueTableBody({required this.args, this.isHighlighted, super.key});

  final PhysiqueTableArgs args;
  final bool Function(int lineOffset, int columnIndex)? isHighlighted;

  @override
  ConsumerState<PhysiqueTableBody> createState() => _PhysiqueTableBodyState();
}

class _PhysiqueTableBodyState extends ConsumerState<PhysiqueTableBody> {
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

    if (editState.loadError) {
      return Center(child: Text(t.physiqueTable.loadError));
    }

    return ref
        .watch(tableTypesProvider)
        .when(
          data: (types) {
            final columnCount = types
                .firstWhereOrNull((type) => type.type == widget.args.type)
                ?.columnCount;
            if (columnCount == null) {
              return Center(child: Text(t.physiqueTable.loadError));
            }
            return LoadingOverlay(
              loading: rows == null,
              child: rows == null
                  ? const SizedBox.shrink()
                  : (rows.isEmpty
                        ? Center(child: Text(t.physiqueTable.empty))
                        : TableEditor<PhysiqueTableRow>(
                            columns: buildPhysiqueTableColumns(
                              columnCount: columnCount,
                              isHighlighted: widget.isHighlighted,
                            ),
                            data: rows,
                            rowId: (row) => row.lineOffset.toString(),
                          )),
            );
          },
          loading: () =>
              LoadingOverlay(loading: true, child: const SizedBox.shrink()),
          error: (_, _) => Center(child: Text(t.physiqueTable.loadError)),
        );
  }
}
