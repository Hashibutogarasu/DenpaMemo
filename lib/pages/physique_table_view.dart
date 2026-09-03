import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_editor/table_editor.dart';

import '../data/server/physique_table_args.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/physiques_providers.dart';
import '../routing/app_router.dart';
import '../widgets/physique_table/physique_table_row.dart';

/// Read-only display of one physique table (a `type`/`level`/
/// `anntenaCategory` triple). Fetches once in [initState] and assembles
/// the flat record list into [PhysiqueTableRow]s itself — the server
/// never returns a table shape, only a flat, `lineOffset`-ordered list
/// (see `GET /tables`).
class PhysiqueTableViewPage extends ConsumerStatefulWidget {
  const PhysiqueTableViewPage({required this.args, super.key});

  final PhysiqueTableArgs args;

  @override
  ConsumerState<PhysiqueTableViewPage> createState() => _PhysiqueTableViewPageState();
}

class _PhysiqueTableViewPageState extends ConsumerState<PhysiqueTableViewPage> {
  late Future<List<PhysiqueTableRow>> _rowsFuture;

  @override
  void initState() {
    super.initState();
    _rowsFuture = _fetchRows();
  }

  Future<List<PhysiqueTableRow>> _fetchRows() async {
    final client = ref.read(physiquesApiClientProvider);
    final records = await client.fetch(
      type: widget.args.type,
      level: widget.args.level,
      anntenaCategory: widget.args.anntenaCategory,
    );
    return [
      for (final record in records)
        PhysiqueTableRow(lineOffset: record.lineOffset, values: record.values),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return AppScaffold(
      title: OutlinedTitleText(
        text: t.physiqueTable.tableTitle(
          level: widget.args.level,
          anntenaCategory: widget.args.anntenaCategory,
        ),
      ),
      body: FutureBuilder<List<PhysiqueTableRow>>(
        future: _rowsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const ProgressBar();
          }
          final rows = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: TableEditor<PhysiqueTableRow>(
                  columns: buildPhysiqueTableColumns(columnCount: widget.args.columnCount),
                  data: rows,
                  rowId: (row) => row.lineOffset.toString(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton.icon(
                  icon: const Icon(Icons.edit_outlined),
                  label: Text(t.physiqueTable.edit),
                  onPressed: () => PhysiqueTableEditRoute($extra: widget.args).push(context),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
