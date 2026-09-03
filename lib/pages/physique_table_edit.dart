import 'package:collection/collection.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_editor/table_editor.dart';
import 'package:toaster/toaster.dart';

import '../data/server/physique_table_args.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/physique_table_edit_providers.dart';
import '../providers/physiques_providers.dart';
import '../widgets/physique_table/physique_table_row.dart';

Future<bool> _confirm(
  BuildContext context, {
  required String title,
  required String message,
}) async {
  final t = context.t;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(t.common.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(t.common.confirm),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}

/// Editable version of [PhysiqueTableViewPage]. All row data and every
/// server operation live in [PhysiqueTableEditNotifier] — this widget
/// only holds which rows are checked, a purely visual concern the
/// notifier doesn't need to know about.
class PhysiqueTableEditPage extends ConsumerStatefulWidget {
  const PhysiqueTableEditPage({required this.args, super.key});

  final PhysiqueTableArgs args;

  @override
  ConsumerState<PhysiqueTableEditPage> createState() => _PhysiqueTableEditPageState();
}

class _PhysiqueTableEditPageState extends ConsumerState<PhysiqueTableEditPage> {
  Set<String> _selectedRowIds = {};

  @override
  void initState() {
    super.initState();
    ref.read(physiqueTableEditProvider(widget.args).notifier).ensureLoaded();
  }

  Future<void> _deleteTable() async {
    final t = context.t;
    final confirmed = await _confirm(
      context,
      title: t.physiqueTable.deleteTableConfirmTitle,
      message: t.physiqueTable.deleteTableConfirmMessage,
    );
    if (!confirmed || !mounted) return;
    await ref.read(physiqueTableEditProvider(widget.args).notifier).deleteTable();
    if (!mounted) return;
    Navigator.of(context)
      ..pop()
      ..pop();
  }

  Future<void> _deleteRow(int lineOffset) async {
    final t = context.t;
    final confirmed = await _confirm(
      context,
      title: t.physiqueTable.deleteRowConfirmTitle,
      message: t.physiqueTable.deleteRowConfirmMessage,
    );
    if (!confirmed || !mounted) return;
    await ref
        .read(physiqueTableEditProvider(widget.args).notifier)
        .deleteRows({lineOffset.toString()});
  }

  Future<void> _deleteSelectedRows() async {
    if (_selectedRowIds.isEmpty) return;
    final t = context.t;
    final confirmed = await _confirm(
      context,
      title: t.physiqueTable.deleteSelectedRowsConfirmTitle,
      message: t.physiqueTable.deleteSelectedRowsConfirmMessage,
    );
    if (!confirmed || !mounted) return;
    await ref.read(physiqueTableEditProvider(widget.args).notifier).deleteRows(_selectedRowIds);
    if (!mounted) return;
    setState(() => _selectedRowIds = {});
  }

  Future<void> _save() async {
    await ref.read(physiqueTableEditProvider(widget.args).notifier).save();
    if (!mounted) return;
    await Toaster.show(context, context.t.physiqueTable.saved);
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
      floatingActionButton: rows == null || columnCount == null
          ? null
          : FloatingActionButton.extended(
              label: Text(t.physiqueTable.save),
              onPressed: _save,
            ),
      body: editState.loadError || typesAsync.hasError || (typesAsync.hasValue && columnCount == null)
          ? Center(child: Text(t.physiqueTable.loadError))
          : LoadingOverlay(
              loading: rows == null || typesAsync.isLoading || columnCount == null,
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
                                    onValueChanged: (lineOffset, columnIndex, newValue) => ref
                                        .read(physiqueTableEditProvider(widget.args).notifier)
                                        .onValueChanged(lineOffset, columnIndex, newValue),
                                  ),
                                  data: rows,
                                  rowId: (row) => row.lineOffset.toString(),
                                  isSelectable: true,
                                  selectionMode: SelectionMode.multiple,
                                  selectedRows: _selectedRowIds,
                                  onCheckboxChanged: (rowId, isSelected) => setState(() {
                                    _selectedRowIds = Set.of(_selectedRowIds);
                                    if (isSelected) {
                                      _selectedRowIds.add(rowId);
                                    } else {
                                      _selectedRowIds.remove(rowId);
                                    }
                                  }),
                                  trailingCellBuilder: (row) => IconButton(
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: Theme.of(context).colorScheme.error,
                                    ),
                                    tooltip: t.physiqueTable.deleteRow,
                                    onPressed: () => _deleteRow(row.lineOffset),
                                  ),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Wrap(
                            spacing: 8,
                            children: [
                              OutlinedButton.icon(
                                icon: const Icon(Icons.add),
                                label: Text(t.physiqueTable.addRow),
                                onPressed: () => ref
                                    .read(physiqueTableEditProvider(widget.args).notifier)
                                    .addRow(columnCount),
                              ),
                              OutlinedButton.icon(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                                label: Text(t.physiqueTable.deleteTable),
                                onPressed: _deleteTable,
                              ),
                              OutlinedButton.icon(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                                label: Text(t.physiqueTable.deleteSelectedRows),
                                onPressed: _selectedRowIds.isEmpty ? null : _deleteSelectedRows,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
    );
  }
}
