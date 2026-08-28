import 'dart:convert';
import 'dart:io';
import 'package:data_pack/data_pack.dart';


Directory _repoRoot() {
  var dir = Directory.current;
  while (!File('${dir.path}/pubspec.yaml').existsSync()) {
    final parent = dir.parent;
    if (parent.path == dir.path) {
      throw StateError('Could not locate repo root from ${Directory.current.path}');
    }
    dir = parent;
  }
  return dir;
}

/// Loads a lineage tree exported via "系譜ツリーをJSONとしてコピー" from
/// [repoRelativePath] (e.g. `test/denpamens/mizuka.json`) and flattens it
/// (by [DenpaMen.id]) into every individual it references, deduping
/// ancestors reused by more than one child.
Map<String, DenpaMen> loadLineageTreeFixtureById(String repoRelativePath) {
  final raw = File(
    '${_repoRoot().path}/$repoRelativePath',
  ).readAsStringSync();
  final root = jsonDecode(raw) as Map<String, dynamic>;
  final byId = <String, DenpaMen>{};
  void visit(Map<String, dynamic> node) {
    final denpaMen = DenpaMen.fromJson(node);
    if (byId.containsKey(denpaMen.id)) {
      return;
    }
    byId[denpaMen.id] = denpaMen;
    for (final parent in node['parents'] as List<dynamic>) {
      visit(parent as Map<String, dynamic>);
    }
  }

  visit(root);
  return byId;
}
