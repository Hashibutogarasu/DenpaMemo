import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;

import 'package:api_client/api_client.dart';
import 'package:toaster/toaster.dart';

import 'package:denpa_memo/widgets.dart';
import '../../i18n/gen/strings.g.dart';

/// Explains, in readable Japanese, why `GET /tables/search` couldn't
/// resolve a physique category for the just-run search — [info] is only
/// ever present in that case (see `PhysiqueSearchResult.info`). A
/// "detail copy" button puts the raw traced data on the clipboard for
/// anyone who needs more than the summary shown here. Debug-only: the
/// caller decides whether to show this at all (see
/// `_DenpaMenEditorState._identifyPhysique`, gated on `kDebugMode`).
class PhysiqueSearchDebugDialog extends StatelessWidget {
  const PhysiqueSearchDebugDialog({super.key, required this.info});

  final PhysiqueSearchDebugInfo info;

  static Future<void> show(
    BuildContext context, {
    required PhysiqueSearchDebugInfo info,
  }) {
    return AppDialog.show<void>(
      context: context,
      builder: (context) => PhysiqueSearchDebugDialog(info: info),
    );
  }

  String get _rawDetails =>
      const JsonEncoder.withIndent('  ').convert(info.toJson());

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final query = info.query;
    final matches = info.matches.cast<Map<String, dynamic>>();
    final categoryRows = info.categoryRows.cast<Map<String, dynamic>>();

    return AlertDialog(
      title: Text(t.physiqueIdentification.debugTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.physiqueIdentification.debugQueryLabel,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              t.physiqueIdentification.debugQueryValue(
                type: '${query['type']}',
                against: '${query['against']}',
                evasionRate: '${query['evasionRate']}',
                hp: '${query['hp']}',
                level: '${query['level']}',
                antenna: '${query['antenna']}',
                anntenaCategory: '${query['anntenaCategory']}',
              ),
            ),
            const SizedBox(height: 12),
            Text(
              t.physiqueIdentification.debugMatchesLabel,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            if (matches.isEmpty)
              Text(t.physiqueIdentification.debugMatchesEmpty)
            else
              for (final match in matches)
                Text(
                  t.physiqueIdentification.debugMatchValue(
                    level: '${match['level']}',
                    anntenaCategory: '${match['anntenaCategory']}',
                    lineOffset: '${match['lineOffset']}',
                    columnIndex: '${match['columnIndex']}',
                  ),
                ),
            const SizedBox(height: 12),
            Text(
              t.physiqueIdentification.debugCategoryRowsLabel,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            if (categoryRows.isEmpty)
              Text(t.physiqueIdentification.debugCategoryRowsEmpty)
            else
              for (final row in categoryRows)
                Text(
                  t.physiqueIdentification.debugCategoryRowValue(
                    evasionRateStart: '${row['evasionRateStart']}',
                    evasionRateEnd: '${row['evasionRateEnd']}',
                    startColumn: '${row['startColumn']}',
                    columnOffset: '${row['columnOffset']}',
                    textKey: '${row['textKey']}',
                  ),
                ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: _rawDetails));
            if (context.mounted) {
              await Toaster.show(context, t.physiqueIdentification.debugCopied);
            }
          },
          child: Text(t.physiqueIdentification.debugCopyDetails),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.common.confirm),
        ),
      ],
    );
  }
}
