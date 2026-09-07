import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:denpa_memo/widgets.dart';
import '../../data/profile/profile.dart';
import '../../i18n/gen/strings.g.dart';
import '../../providers/profile_providers.dart';

/// Lists every [Profile] registered for [namespace] and lets the user
/// pick one, returning it — or null if they cancel. Entirely
/// domain-agnostic, like [ProfileSwitchPage](../../pages/profile_switch_page.dart):
/// this dialog has no notion of what a profile's settings are for.
class ProfileSelectionDialog extends ConsumerWidget {
  const ProfileSelectionDialog({super.key, required this.namespace});

  final String namespace;

  static Future<Profile?> show(
    BuildContext context, {
    required String namespace,
  }) {
    return AppDialog.show<Profile>(
      context: context,
      builder: (context) => ProfileSelectionDialog(namespace: namespace),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final profilesAsync = ref.watch(profileListProvider(namespace));
    return AlertDialog(
      title: Text(t.profile.selectionDialogTitle),
      content: SizedBox(
        width: double.maxFinite,
        child: profilesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Text(error.toString()),
          data: (profiles) => ListView(
            shrinkWrap: true,
            children: [
              for (final profile in profiles)
                ListTile(
                  title: Text(profile.name),
                  onTap: () => Navigator.of(context).pop(profile),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.common.cancel),
        ),
      ],
    );
  }
}
