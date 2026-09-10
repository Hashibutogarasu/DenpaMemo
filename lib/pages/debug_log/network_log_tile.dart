import 'package:flutter/material.dart';

import 'package:app_logging/app_logging.dart';

import '../../i18n/gen/strings.g.dart';
import 'network_log_detail_row.dart';
import 'network_status_indicator.dart';
import 'network_transfer_badge.dart';

/// Accordion-style row for one [NetworkLogEntry], built on a plain
/// [ExpansionTile] (deliberately not `DenpaMenAccordionTile`'s custom
/// home-screen styling). Collapsed, it shows [NetworkStatusIndicator],
/// the method/URI, and — once resolved — a transfer-direction arrow.
class NetworkLogTile extends StatelessWidget {
  const NetworkLogTile({super.key, required this.entry});

  final NetworkLogEntry entry;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return ExpansionTile(
      leading: NetworkStatusIndicator(status: entry.status),
      title: Text(
        entry.operation ?? entry.id,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: switch (entry.status) {
        NetworkLogStatus.pending || NetworkLogStatus.skipped => null,
        _ => NetworkTransferBadge(entry: entry),
      },
      expandedAlignment: Alignment.centerLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (entry.uri != null)
                NetworkLogDetailRow(
                  label: t.debugLog.destinationLabel,
                  value: entry.uri!,
                ),
              if (entry.statusCode != null)
                NetworkLogDetailRow(
                  label: t.debugLog.statusCodeLabel,
                  value: '${entry.statusCode}',
                ),
              if (entry.duration != null)
                NetworkLogDetailRow(
                  label: t.debugLog.durationLabel,
                  value: '${entry.duration!.inMilliseconds} ms',
                ),
              if (entry.errorMessage != null)
                NetworkLogDetailRow(
                  label: t.debugLog.errorLabel,
                  value: entry.errorMessage!,
                ),
              NetworkLogDetailRow(
                label: t.debugLog.requestBodyLabel,
                value: entry.requestBody ?? '',
              ),
              NetworkLogDetailRow(
                label: t.debugLog.responseBodyLabel,
                value: entry.responseBody ?? '',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
