import 'package:objectbox/objectbox.dart';

/// Locally cached representation of one physique table row
/// (`PhysiqueTableRecord` on `modules/server`), keyed by [rowKey].
/// [pendingSync] marks an unsynced local edit; [existsOnServer] marks a
/// row already created server-side, so syncing only needs to update it.
@Entity()
class PhysiqueTableRowEntity {
  @Id()
  int id;

  @Unique()
  String rowKey;

  String type;

  String level;

  String anntenaCategory;

  int lineOffset;

  String valuesJson;

  bool pendingSync;

  bool existsOnServer;

  PhysiqueTableRowEntity({
    this.id = 0,
    required this.rowKey,
    required this.type,
    required this.level,
    required this.anntenaCategory,
    required this.lineOffset,
    required this.valuesJson,
    this.pendingSync = false,
    this.existsOnServer = false,
  });

  /// Builds the [rowKey] identifying one `type`/`level`/`anntenaCategory`/
  /// `lineOffset` combination.
  static String buildRowKey({
    required String type,
    required String level,
    required String anntenaCategory,
    required int lineOffset,
  }) => '$type|$level|$anntenaCategory|$lineOffset';
}
