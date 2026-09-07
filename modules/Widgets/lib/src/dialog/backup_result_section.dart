import 'dart:io';

import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';

import '../denpa_men_list_tile.dart';

/// Shared section layout for the app's import/export summary dialogs
/// ([ExportCompleteDialog](export_complete_dialog.dart) and the root-only
/// `ImportCompleteDialog`): a heading with [denpaMens]'s count, followed by
/// a read-only [DenpaMenListTile] per entry. Renders nothing when
/// [denpaMens] is empty.
///
/// This widget has no Riverpod access of its own, so [iconsById] (each
/// entry's already-resolved icon file, by [DenpaMen.id]) must be resolved
/// by the caller — omitting it just renders every tile with the
/// placeholder icon.
class BackupResultSection extends StatelessWidget {
  const BackupResultSection({
    super.key,
    required this.title,
    required this.denpaMens,
    this.iconsById,
  });

  final String title;
  final List<DenpaMen> denpaMens;
  final Map<String, File?>? iconsById;

  @override
  Widget build(BuildContext context) {
    if (denpaMens.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          child: Text(
            '$title (${denpaMens.length})',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: denpaMens.length,
          itemBuilder: (context, index) => DenpaMenListTile(
            denpaMen: denpaMens[index],
            iconFile: iconsById?[denpaMens[index].id],
          ),
        ),
      ],
    );
  }
}
