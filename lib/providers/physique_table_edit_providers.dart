import 'package:api_client/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/server/physique_table_args.dart';
import '../widgets/physique_table/physique_table_row.dart';
import 'physique_table_cache_providers.dart';
import 'physiques_providers.dart';

class PhysiqueTableEditState {
  const PhysiqueTableEditState({
    this.rows,
    this.persistedRowCount = 0,
    this.loadError = false,
  });

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

/// Owns one physique table's editable rows, backed by the local
/// [PhysiqueTableCacheRepository] rather than the server directly. Row
/// edits and additions are staged in [state] until [save] is called,
/// which writes the whole row set to the local cache; [syncToServer]
/// pushes the cache's unsynced rows to `modules/server` on demand.
class PhysiqueTableEditNotifier extends Notifier<PhysiqueTableEditState> {
  PhysiqueTableEditNotifier(this.args);

  final PhysiqueTableArgs args;

  @override
  PhysiqueTableEditState build() => const PhysiqueTableEditState();

  Future<void> ensureLoaded() {
    if (state.rows != null || state.loadError) return Future.value();
    return _load();
  }

  Future<void> _load() async {
    final cacheRepository = ref.read(physiqueTableCacheRepositoryProvider);
    final rows = cacheRepository.rowsFor(args);
    state = PhysiqueTableEditState(
      rows: rows,
      persistedRowCount: cacheRepository.persistedRowCount(args),
    );
  }

  Future<void> reload() => _load();

  void onValueChanged(int lineOffset, int columnIndex, String newValue) {
    final rows = state.rows;
    if (rows == null) return;
    state = state.copyWith(
      rows: [
        for (final row in rows)
          row.lineOffset == lineOffset
              ? row.copyWithValueAt(columnIndex, newValue)
              : row,
      ],
    );
  }

  void addRow(int columnCount) {
    final rows = state.rows;
    if (rows == null) return;
    state = state.copyWith(
      rows: [
        ...rows,
        PhysiqueTableRow(
          lineOffset: rows.length,
          values: List.filled(columnCount, ''),
        ),
      ],
    );
  }

  /// The only place row text is parsed to what the server stores: a
  /// blank or unparseable cell stays `null`, never coerced to `0`.
  List<int?> _parsedValues(PhysiqueTableRow row) => [
    for (final value in row.values) int.tryParse(value),
  ];

  /// Writes the current row set to the local cache only, without a
  /// network call. [syncToServer] is what pushes it to the server.
  Future<void> save() async {
    final rows = state.rows;
    if (rows == null || rows.isEmpty) return;
    ref.read(physiqueTableCacheRepositoryProvider).replaceLocalRows(args, rows);
  }

  /// Pushes the current row set to the server: creates every row past
  /// [PhysiqueTableEditState.persistedRowCount] (rows not yet known to
  /// exist on the server), then PUTs every row's values in one call —
  /// the same combined logic [save] used to perform directly.
  Future<void> syncToServer() async {
    final rows = state.rows;
    if (rows == null || rows.isEmpty) return;
    final cacheRepository = ref.read(physiqueTableCacheRepositoryProvider);
    cacheRepository.replaceLocalRows(args, rows);

    final client = ref.read(physiquesApiClientProvider);
    final persistedRowCount = cacheRepository.persistedRowCount(args);
    final newRows = rows.sublist(persistedRowCount);
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
    cacheRepository.markSynced(args);
    state = state.copyWith(persistedRowCount: rows.length);
  }

  /// Deletes the table on the server, then mirrors the deletion into the
  /// local cache so it does not reappear on the next load.
  Future<void> deleteTable() async {
    final client = ref.read(physiquesApiClientProvider);
    await client.delete(
      type: args.type,
      level: args.level,
      anntenaCategory: args.anntenaCategory,
    );
    ref.read(physiqueTableCacheRepositoryProvider).deleteTable(args);
  }

  /// Rows among [selectedRowIds] already known to exist on the server are
  /// deleted there first; every selected row is then removed from the
  /// local cache, which re-sequences the remaining ones the same way the
  /// server does.
  Future<void> deleteRows(Set<String> selectedRowIds) async {
    final rows = state.rows;
    if (rows == null || selectedRowIds.isEmpty) return;
    final selectedOffsets = {for (final id in selectedRowIds) int.parse(id)};
    final persistedOffsets = [
      for (final offset in selectedOffsets)
        if (offset < state.persistedRowCount) offset,
    ];
    if (persistedOffsets.isNotEmpty) {
      final client = ref.read(physiquesApiClientProvider);
      await client.deleteRows(
        type: args.type,
        level: args.level,
        anntenaCategory: args.anntenaCategory,
        lineOffsets: persistedOffsets,
      );
    }
    ref
        .read(physiqueTableCacheRepositoryProvider)
        .deleteRows(args, selectedOffsets);
    await _load();
  }
}

final physiqueTableEditProvider =
    NotifierProvider.family<
      PhysiqueTableEditNotifier,
      PhysiqueTableEditState,
      PhysiqueTableArgs
    >(PhysiqueTableEditNotifier.new);
