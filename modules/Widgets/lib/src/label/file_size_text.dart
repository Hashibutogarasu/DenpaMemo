import 'package:flutter/material.dart';

import 'package:proper_filesize/proper_filesize.dart';

/// Displays [bytes] as a human-readable file size (e.g. "12.5 MB"), via
/// `proper_filesize`.
class FileSizeText extends StatelessWidget {
  const FileSizeText({super.key, required this.bytes, this.style});

  final int bytes;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(FileSize.fromBytes(bytes).toString(), style: style);
  }
}
