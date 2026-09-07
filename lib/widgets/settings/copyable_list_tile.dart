import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:toaster/toaster.dart';

import 'package:denpa_memo/widgets.dart';
import '../../i18n/gen/strings.g.dart';

/// [ListItemTile] view that copies [trailingText] to the clipboard on tap
/// and toasts confirmation naming [label]. Disabled when [trailingText]
/// is null.
class CopyableListTile extends StatelessWidget {
  const CopyableListTile({
    super.key,
    required this.icon,
    required this.label,
    this.trailingText,
  });

  final IconData icon;
  final String label;
  final String? trailingText;

  Future<void> _copy(BuildContext context) async {
    final text = trailingText;
    if (text == null) {
      return;
    }
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) {
      return;
    }
    await Toaster.show(context, context.t.settings.copiedToast(label: label));
  }

  @override
  Widget build(BuildContext context) {
    return ListItemTile(
      icon: icon,
      label: label,
      trailingText: trailingText,
      onTap: trailingText != null ? () => _copy(context) : null,
    );
  }
}
