import 'package:api_client/api_client.dart';
import 'package:collection/collection.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_editor/table_editor.dart';
import 'package:toaster/toaster.dart';

import '../data/server/physique_table_args.dart';
import '../i18n/gen/strings.g.dart';
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

/// Editable version of [PhysiqueTableViewPage]. Cell edits and row
/// additions are staged locally and only reach the server when the save
/// FAB is pressed: new rows are POSTed first (so the table's row count
/// catches up with the local list), then every row's current values are
/// pushed in one `PUT /tables` call starting at `lineOffset: 0`, which is
/// then always within the server's row-count bound.
class PhysiqueTableEditPage extends ConsumerStatefulWidget {
  const PhysiqueTableEditPage({required this.args, super.key});

  final PhysiqueTableArgs args;

  @override
  ConsumerState<PhysiqueTableEditPage> createState() => _PhysiqueTableEditPageState();
}

class _PhysiqueTableEditPageState extends ConsumerState<PhysiqueTableEditPage> {
  List<PhysiqueTableRow>? _rows;
  int _persistedRowCount = 0;
  Set<String> _selectedRowIds = {};
  bool _loadError = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.invalidate(tableTypesProvider));
    _load();
  }

  Future<void> _load() async {
    final client = ref.read(physiquesApiClientProvider);
    try {
      final records = await client.fetch(
        type: widget.args.type,
        level: widget.args.level,
        anntenaCategory: widget.args.anntenaCategory,
      );
      if (!mounted) return;
      setState(() {
        _loadError = false;
        _rows = [
          for (final record in records)
            PhysiqueTableRow(lineOffset: record.lineOffset, values: record.values),
        ];
        _persistedRowCount = _rows!.length;
        _selectedRowIds = {};
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loadError = true);
    }
  }

  void _onValueChanged(int lineOffset, int columnIndex, int newValue) {
    setState(() {
      _rows = [
        for (final row in _rows!)
          row.lineOffset == lineOffset ? row.copyWithValueAt(columnIndex, newValue) : row,
      ];
    });
  }

  void _addRow(int columnCount) {
    setState(() {
      _rows = [
        ..._rows!,
        PhysiqueTableRow(lineOffset: _rows!.length, values: List.filled(columnCount, 0)),
      ];
    });
  }

  Future<void> _save() async {
    if (_rows!.isEmpty) return;
    final client = ref.read(physiquesApiClientProvider);
    final newRows = _rows!.sublist(_persistedRowCount);
    if (newRows.isNotEmpty) {
      await client.create([
        for (final row in newRows)
          PhysiqueTableRecord(
            type: widget.args.type,
            level: widget.args.level,
            anntenaCategory: widget.args.anntenaCategory,
            lineOffset: row.lineOffset,
            values: row.values,
          ),
      ]);
    }
    await client.update(
      lineOffset: 0,
      type: widget.args.type,
      level: widget.args.level,
      anntenaCategory: widget.args.anntenaCategory,
      rowValues: [for (final row in _rows!) row.values],
    );
    if (!mounted) return;
    setState(() => _persistedRowCount = _rows!.length);
    await Toaster.show(context, context.t.physiqueTable.saved);
  }

  Future<void> _deleteTable() async {
    final t = context.t;
    final confirmed = await _confirm(
      context,
      title: t.physiqueTable.deleteTableConfirmTitle,
      message: t.physiqueTable.deleteTableConfirmMessage,
    );
    if (!confirmed || !mounted) return;
    final client = ref.read(physiquesApiClientProvider);
    await client.delete(
      type: widget.args.type,
      level: widget.args.level,
      anntenaCategory: widget.args.anntenaCategory,
    );
    if (!mounted) return;
    Navigator.of(context)
      ..pop()
      ..pop();
  }

  Future<void> _deleteSelectedRows() async {
    if (_selectedRowIds.isEmpty) return;
    final t = context.t;
    final confirmed = await _confirm(
      context,
      title: t.physiqueTable.deleteRowConfirmTitle,
      message: t.physiqueTable.deleteRowConfirmMessage,
    );
    if (!confirmed || !mounted) return;
    final selectedOffsets = [for (final id in _selectedRowIds) int.parse(id)];
    final persistedOffsets = [
      for (final offset in selectedOffsets)
        if (offset < _persistedRowCount) offset,
    ];
    if (persistedOffsets.isEmpty) {
      final selected = selectedOffsets.toSet();
      final remaining = [
        for (final row in _rows!)
          if (!selected.contains(row.lineOffset)) row,
      ];
      setState(() {
        _rows = [
          for (var i = 0; i < remaining.length; i++)
            PhysiqueTableRow(lineOffset: i, values: remaining[i].values),
        ];
        _selectedRowIds = {};
      });
      return;
    }
    final client = ref.read(physiquesApiClientProvider);
    await client.deleteRows(
      type: widget.args.type,
      level: widget.args.level,
      anntenaCategory: widget.args.anntenaCategory,
      lineOffsets: persistedOffsets,
    );
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final rows = _rows;
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
      floatingActionButton: rows == null
          ? null
          : FloatingActionButton.extended(
              label: Text(t.physiqueTable.save),
              onPressed: _save,
            ),
      body: _loadError || typesAsync.hasError || (typesAsync.hasValue && columnCount == null)
          ? Center(child: Text(t.physiqueTable.loadError))
          : rows == null || typesAsync.isLoading || columnCount == null
          ? const ProgressBar()
          : Column(
              children: [
                Expanded(
                  child: rows.isEmpty
                      ? Center(child: Text(t.physiqueTable.empty))
                      : TableEditor<PhysiqueTableRow>(
                          columns: buildPhysiqueTableColumns(
                            columnCount: columnCount,
                            onValueChanged: _onValueChanged,
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
                        onPressed: () => _addRow(columnCount),
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
                        label: Text(t.physiqueTable.deleteRow),
                        onPressed: _selectedRowIds.isEmpty ? null : _deleteSelectedRows,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
