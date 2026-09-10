import 'package:flutter/material.dart';

import 'package:app_logging/app_logging.dart';

import 'package:denpa_memo/widgets.dart' hide Translations;

enum _TransferDirection { upload, download }

/// [NetworkLogTile]'s trailing badge for a resolved [entry]: an arrow for
/// whichever of [NetworkLogEntry.requestBytes]/[NetworkLogEntry.responseBytes]
/// is larger (green up = upload, red down = download), with that byte
/// count shown via [FileSizeText] to its left.
class NetworkTransferBadge extends StatelessWidget {
  const NetworkTransferBadge({super.key, required this.entry});

  final NetworkLogEntry entry;

  @override
  Widget build(BuildContext context) {
    final requestBytes = entry.requestBytes ?? 0;
    final responseBytes = entry.responseBytes ?? 0;
    final direction = responseBytes >= requestBytes
        ? _TransferDirection.download
        : _TransferDirection.upload;
    final bytes = direction == _TransferDirection.download
        ? responseBytes
        : requestBytes;
    final color = direction == _TransferDirection.download
        ? Colors.red
        : Colors.green;
    final icon = direction == _TransferDirection.download
        ? Icons.arrow_downward
        : Icons.arrow_upward;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FileSizeText(bytes: bytes),
        const SizedBox(width: 4),
        Icon(icon, color: color),
      ],
    );
  }
}
