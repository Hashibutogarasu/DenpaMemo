import 'package:api_client/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/server/physique_table_args.dart';
import '../widgets/physique_table/physique_table_row.dart';
import 'physiques_providers.dart';

class PhysiqueTableEditState {
  const PhysiqueTableEditState({this.rows, this.persistedRowCount = 0, this.loadError = false});

  final List<PhysiqueTableRow>? rows;
  final int persistedRowCount;
  final bool loadError;

  PhysiqueTableEditState copyWith({
    List<PhysiqueTableRow>? rows,
    int? persistedRowCount,
    bool? loadError,
  }) => PhysiqueTableEditState(
    rows: rows ?? this.rows,
    persistedRowCount: persistedRowCount ?? this.persistedRowCount,
    loadError: loadError ?? this.loadError,
  );
}

/// Owns one physique table's editable rows and every operation that
/// reaches the server for it (load/save/create/delete). Row edits and
/// additions are staged in [state] until [save] is called, which creates
/// any rows added since the last save, then pushes every row's current
/// values in one `PUT /tables` call.
class PhysiqueTableEditNotifier extends Notifier<PhysiqueTableEditState> {
  PhysiqueTableEditNotifier(this.args);

  final PhysiqueTableArgs args;

  @override
  PhysiqueTableEditState build() {
    _load();
    return const PhysiqueTableEditState();
  }

  Future<void> _load() async {
    final client = ref.read(physiquesApiClientProvider);
    try {
      final records = await client.fetch(
        type: args.type,
        level: args.level,
        anntenaCategory: args.anntenaCategory,
      );
      final rows = [
        for (final record in records)
          PhysiqueTableRow(
            lineOffset: record.lineOffset,
            values: [for (final value in record.values) value.toString()],
          ),
      ];
      state = PhysiqueTableEditState(rows: rows, persistedRowCount: rows.length);
    } catch (_) {
      state = state.copyWith(loadError: true);
    }
  }

  Future<void> reload() => _load();

  void onValueChanged(int lineOffset, int columnIndex, String newValue) {
    final rows = state.rows;
    if (rows == null) return;
    state = state.copyWith(
      rows: [
        for (final row in rows)
          row.lineOffset == lineOffset ? row.copyWithValueAt(columnIndex, newValue) : row,
      ],
    );
  }

  void addRow(int columnCount) {
    final rows = state.rows;
    if (rows == null) return;
    state = state.copyWith(
      rows: [
        ...rows,
        PhysiqueTableRow(lineOffset: rows.length, values: List.filled(columnCount, '0')),
      ],
    );
  }

  /// The only place row text is parsed to the integers the server
  /// requires: an empty or unparseable cell becomes `0`.
  List<int> _parsedValues(PhysiqueTableRow row) => [
    for (final value in row.values) int.tryParse(value) ?? 0,
  ];

  Future<void> save() async {
    final rows = state.rows;
    if (rows == null || rows.isEmpty) return;
    final client = ref.read(physiquesApiClientProvider);
    final newRows = rows.sublist(state.persistedRowCount);
    if (newRows.isNotEmpty) {
      await client.create([
        for (final row in newRows)
          PhysiqueTableRecord(
            type: args.type,
            level: args.level,
            anntenaCategory: args.anntenaCategory,
            lineOffset: row.lineOffset,
            values: _parsedValues(row),
          ),
      ]);
    }
    await client.update(
      lineOffset: 0,
      type: args.type,
      level: args.level,
      anntenaCategory: args.anntenaCategory,
      rowValues: [for (final row in rows) _parsedValues(row)],
    );
    state = state.copyWith(persistedRowCount: rows.length);
  }

  Future<void> deleteTable() async {
    final client = ref.read(physiquesApiClientProvider);
    await client.delete(type: args.type, level: args.level, anntenaCategory: args.anntenaCategory);
  }

  /// Persisted rows among [selectedRowIds] are deleted on the server
  /// (which re-sequences the rest); not-yet-saved rows are simply
  /// dropped locally, since the server never received them.
  Future<void> deleteRows(Set<String> selectedRowIds) async {
    final rows = state.rows;
    if (rows == null || selectedRowIds.isEmpty) return;
    final selectedOffsets = [for (final id in selectedRowIds) int.parse(id)];
    final persistedOffsets = [
      for (final offset in selectedOffsets)
        if (offset < state.persistedRowCount) offset,
    ];
    if (persistedOffsets.isEmpty) {
      final selected = selectedOffsets.toSet();
      final remaining = [
        for (final row in rows)
          if (!selected.contains(row.lineOffset)) row,
      ];
      state = state.copyWith(
        rows: [
          for (var i = 0; i < remaining.length; i++)
            PhysiqueTableRow(lineOffset: i, values: remaining[i].values),
        ],
      );
      return;
    }
    final client = ref.read(physiquesApiClientProvider);
    await client.deleteRows(
      type: args.type,
      level: args.level,
      anntenaCategory: args.anntenaCategory,
      lineOffsets: persistedOffsets,
    );
    await _load();
  }
}

final physiqueTableEditProvider =
    NotifierProvider.family<PhysiqueTableEditNotifier, PhysiqueTableEditState, PhysiqueTableArgs>(
      PhysiqueTableEditNotifier.new,
    );
