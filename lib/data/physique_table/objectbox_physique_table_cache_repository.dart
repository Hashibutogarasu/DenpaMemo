import 'dart:convert';

import 'package:api_client/api_client.dart';

import '../../objectbox.g.dart';
import '../../widgets/physique_table/physique_table_row.dart';
import '../objectbox/objectbox.dart';
import '../server/physique_table_args.dart';
import 'physique_table_row_entity.dart';

/// Local ObjectBox-backed cache of physique table rows, so
/// `PhysiqueTableEditNotifier` can read and stage edits without reaching
/// `modules/server`. [upsertFromServer] never clobbers a row edited
/// locally since the last sync (see [PhysiqueTableRowEntity.pendingSync]).
class PhysiqueTableCacheRepository {
  PhysiqueTableCacheRepository(this._objectBox);

  final ObjectBox _objectBox;

  Box<PhysiqueTableRowEntity> get _box => _objectBox.physiqueTableRowBox;

  /// Builds a query from [condition] (optionally [orderBy]-sorted), runs
  /// [action] against it, and closes it afterwards regardless of outcome.
  T _runQuery<T>(
    Condition<PhysiqueTableRowEntity> condition,
    T Function(Query<PhysiqueTableRowEntity> query) action, {
    QueryProperty<PhysiqueTableRowEntity, Object>? orderBy,
  }) {
    final builder = _box.query(condition);
    if (orderBy != null) {
      builder.order(orderBy);
    }
    final query = builder.build();
    try {
      return action(query);
    } finally {
      query.close();
    }
  }

  /// Returns the cached rows for one table, ordered by `lineOffset`.
  List<PhysiqueTableRow> rowsFor(PhysiqueTableArgs args) => _runQuery(
    _argsCondition(args),
    (query) => [for (final entity in query.find()) _toRow(entity)],
    orderBy: PhysiqueTableRowEntity_.lineOffset,
  );

  /// Whether one table has any row edited locally since the last
  /// successful sync.
  bool hasPendingChanges(PhysiqueTableArgs args) => _runQuery(
    _argsCondition(args) & PhysiqueTableRowEntity_.pendingSync.equals(true),
    (query) => query.count() > 0,
  );

  /// Whether one table already has at least one cached row, so callers
  /// can check data availability without reaching the server.
  bool hasDataFor(PhysiqueTableArgs args) =>
      _runQuery(_argsCondition(args), (query) => query.count() > 0);

  /// Every `anntenaCategory` that has at least one cached row, across
  /// every table type and level.
  Set<String> anntenaCategoriesWithData() => {
    for (final entity in _box.getAll()) entity.anntenaCategory,
  };

  /// The number of this table's cached rows already known to exist on
  /// the server (see [PhysiqueTableRowEntity.existsOnServer]) — the
  /// prefix `PhysiqueTableEditNotifier.syncToServer` must only `update`,
  /// creating everything past it.
  int persistedRowCount(PhysiqueTableArgs args) => _runQuery(
    _argsCondition(args) & PhysiqueTableRowEntity_.existsOnServer.equals(true),
    (query) => query.count(),
  );

  /// Replaces every cached row of one `type` with [records]. A row with
  /// an unsynced local edit keeps its values and
  /// [PhysiqueTableRowEntity.pendingSync] untouched, but its
  /// [PhysiqueTableRowEntity.existsOnServer] is still reconciled from
  /// [records], so a row this app already created is never re-`create`d.
  void upsertFromServer(String type, List<PhysiqueTableRecord> records) {
    final existingByKey = _existingByKey(
      PhysiqueTableRowEntity_.type.equals(type),
    );

    final toSave = <PhysiqueTableRowEntity>[];
    for (final record in records) {
      final rowKey = PhysiqueTableRowEntity.buildRowKey(
        type: record.type,
        level: record.level,
        anntenaCategory: record.anntenaCategory,
        lineOffset: record.lineOffset,
      );
      final pending = existingByKey[rowKey];
      if (pending != null && pending.pendingSync) {
        existingByKey.remove(rowKey);
        if (!pending.existsOnServer) {
          pending.existsOnServer = true;
          toSave.add(pending);
        }
        continue;
      }
      toSave.add(
        _buildEntity(
          existingByKey: existingByKey,
          type: record.type,
          level: record.level,
          anntenaCategory: record.anntenaCategory,
          lineOffset: record.lineOffset,
          valuesJson: jsonEncode(record.values),
          existsOnServer: true,
        ),
      );
    }
    _box.putMany(toSave);
  }

  /// Overwrites this table's cached rows with [rows] from the edit
  /// screen and marks them [PhysiqueTableRowEntity.pendingSync]. A row
  /// with a cached counterpart keeps that counterpart's
  /// [PhysiqueTableRowEntity.existsOnServer] value instead of losing it.
  void replaceLocalRows(PhysiqueTableArgs args, List<PhysiqueTableRow> rows) {
    final existingByKey = _existingByKey(_argsCondition(args));

    final toSave = <PhysiqueTableRowEntity>[
      for (final row in rows)
        _buildEntity(
          existingByKey: existingByKey,
          type: args.type,
          level: args.level,
          anntenaCategory: args.anntenaCategory,
          lineOffset: row.lineOffset,
          valuesJson: jsonEncode([
            for (final value in row.values) int.tryParse(value),
          ]),
          pendingSync: true,
          existsOnServer:
              existingByKey[PhysiqueTableRowEntity.buildRowKey(
                    type: args.type,
                    level: args.level,
                    anntenaCategory: args.anntenaCategory,
                    lineOffset: row.lineOffset,
                  )]
                  ?.existsOnServer ??
              false,
        ),
    ];
    _box.putMany(toSave);
    if (existingByKey.isNotEmpty) {
      _box.removeMany([for (final entity in existingByKey.values) entity.id]);
    }
  }

  /// Marks this table's rows as pushed to the server: clears
  /// [PhysiqueTableRowEntity.pendingSync] and sets [existsOnServer].
  void markSynced(PhysiqueTableArgs args) {
    final rows = _runQuery(_argsCondition(args), (query) => query.find());
    for (final row in rows) {
      row.pendingSync = false;
      row.existsOnServer = true;
    }
    _box.putMany(rows);
  }

  /// Sets [PhysiqueTableRowEntity.existsOnServer] on the rows at
  /// [lineOffsets] without touching [PhysiqueTableRowEntity.pendingSync].
  void markRowsExistOnServer(
    PhysiqueTableArgs args,
    Iterable<int> lineOffsets,
  ) {
    final offsets = lineOffsets.toSet();
    if (offsets.isEmpty) return;
    final rows = _runQuery(
      _argsCondition(args) &
          PhysiqueTableRowEntity_.lineOffset.oneOf(offsets.toList()),
      (query) => query.find(),
    );
    for (final row in rows) {
      row.existsOnServer = true;
    }
    _box.putMany(rows);
  }

  /// Removes every cached row for one table.
  void deleteTable(PhysiqueTableArgs args) {
    _runQuery(_argsCondition(args), (query) => query.remove());
  }

  /// Removes the cached rows at [lineOffsets] within one table and
  /// renumbers the remaining rows' `lineOffset`s, mirroring the server's
  /// own resequencing (`deleteTableRows` in `tables.route.ts`).
  void deleteRows(PhysiqueTableArgs args, Set<int> lineOffsets) {
    _runQuery(
      _argsCondition(args) &
          PhysiqueTableRowEntity_.lineOffset.oneOf(lineOffsets.toList()),
      (query) => query.remove(),
    );

    final remaining = _runQuery(
      _argsCondition(args),
      (query) => query.find(),
      orderBy: PhysiqueTableRowEntity_.lineOffset,
    );
    for (var i = 0; i < remaining.length; i++) {
      final entity = remaining[i];
      entity.lineOffset = i;
      entity.rowKey = PhysiqueTableRowEntity.buildRowKey(
        type: entity.type,
        level: entity.level,
        anntenaCategory: entity.anntenaCategory,
        lineOffset: i,
      );
    }
    _box.putMany(remaining);
  }

  /// The query condition matching every row belonging to one table.
  Condition<PhysiqueTableRowEntity> _argsCondition(PhysiqueTableArgs args) =>
      PhysiqueTableRowEntity_.type.equals(args.type) &
      PhysiqueTableRowEntity_.level.equals(args.level) &
      PhysiqueTableRowEntity_.anntenaCategory.equals(args.anntenaCategory);

  /// Fetches rows matching [condition], keyed by [PhysiqueTableRowEntity.rowKey]
  /// so callers can look up and remove the ones a new row set replaces.
  Map<String, PhysiqueTableRowEntity> _existingByKey(
    Condition<PhysiqueTableRowEntity> condition,
  ) => {
    for (final entity in _runQuery(condition, (query) => query.find()))
      entity.rowKey: entity,
  };

  /// Builds the entity for one row, reusing an existing box id from
  /// [existingByKey] (removing it from the map) when this row already has
  /// a cached counterpart, so [Box.putMany] updates it in place.
  PhysiqueTableRowEntity _buildEntity({
    required Map<String, PhysiqueTableRowEntity> existingByKey,
    required String type,
    required String level,
    required String anntenaCategory,
    required int lineOffset,
    required String valuesJson,
    bool pendingSync = false,
    bool existsOnServer = false,
  }) {
    final rowKey = PhysiqueTableRowEntity.buildRowKey(
      type: type,
      level: level,
      anntenaCategory: anntenaCategory,
      lineOffset: lineOffset,
    );
    final existing = existingByKey.remove(rowKey);
    return PhysiqueTableRowEntity(
      id: existing?.id ?? 0,
      rowKey: rowKey,
      type: type,
      level: level,
      anntenaCategory: anntenaCategory,
      lineOffset: lineOffset,
      valuesJson: valuesJson,
      pendingSync: pendingSync,
      existsOnServer: existsOnServer,
    );
  }

  /// Decodes one cached entity back into the UI's [PhysiqueTableRow].
  PhysiqueTableRow _toRow(PhysiqueTableRowEntity entity) {
    final values = (jsonDecode(entity.valuesJson) as List<dynamic>)
        .cast<int?>();
    return PhysiqueTableRow(
      lineOffset: entity.lineOffset,
      values: [for (final value in values) value?.toString() ?? ''],
    );
  }
}
