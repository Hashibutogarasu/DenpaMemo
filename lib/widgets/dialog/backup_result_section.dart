import 'package:flutter/material.dart';

import '../../domain/denpa_men/denpa_men.dart';
import '../denpa_men_list_tile.dart';

/// Shared section layout for [ImportCompleteDialog](import_complete_dialog.dart)
/// and [ExportCompleteDialog](export_complete_dialog.dart): a heading with
/// [denpaMens]'s count, followed by a read-only
/// [DenpaMenListTile] per entry. Renders nothing when [denpaMens]
/// is empty.
class BackupResultSection extends StatelessWidget {
  const BackupResultSection({super.key, required this.title, required this.denpaMens});

  final String title;
  final List<DenpaMen> denpaMens;

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
          itemBuilder: (context, index) =>
              DenpaMenListTile(denpaMen: denpaMens[index]),
        ),
      ],
    );
  }
}
