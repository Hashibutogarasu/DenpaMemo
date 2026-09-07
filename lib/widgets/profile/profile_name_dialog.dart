import 'package:flutter/material.dart';

import 'package:denpa_memo/widgets.dart';
import '../../i18n/gen/strings.g.dart';

/// Text-input dialog for naming a [Profile](../../data/profile/profile.dart),
/// used by [ProfileSwitchPage](../../pages/profile_switch_page.dart) when
/// creating a new one. Returns the entered name, or null if the user
/// cancelled.
class ProfileNameDialog extends StatefulWidget {
  const ProfileNameDialog({super.key, this.initial = ''});

  final String initial;

  static Future<String?> show(BuildContext context, {String initial = ''}) {
    return AppDialog.show<String>(
      context: context,
      builder: (context) => ProfileNameDialog(initial: initial),
    );
  }

  @override
  State<ProfileNameDialog> createState() => _ProfileNameDialogState();
}

class _ProfileNameDialogState extends State<ProfileNameDialog> {
  late final _controller = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return AlertDialog(
      title: Text(t.profile.nameDialogTitle),
      content: TextField(controller: _controller, autofocus: true),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.common.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: Text(t.common.ok),
        ),
      ],
    );
  }
}
