import 'package:flutter/material.dart';

import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension, Translations, t;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/profile/profile.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/profile_providers.dart';
import '../widgets/profile/profile_name_dialog.dart';

/// Lets the user create and switch between [Profile]s for [namespace], a
/// caller-defined string identifying which feature's profile pool this
/// is (see `ProfileStorage`). Entirely domain-agnostic: this page has no
/// notion of what a profile's settings actually are — it only lists
/// [Profile.name]s and lets the caller create/select/rename/delete one.
/// Creating a profile only selects it as current and stays on this page
/// (the user may want to create several before leaving); selecting an
/// existing one from the list pops with `true`, so the caller knows to
/// re-read whatever settings depend on the current profile.
class ProfileSwitchPage extends ConsumerWidget {
  const ProfileSwitchPage({super.key, required this.namespace});

  final String namespace;

  Future<void> _create(BuildContext context, WidgetRef ref) async {
    final name = await ProfileNameDialog.show(context);
    if (name == null || name.isEmpty) {
      return;
    }
    await ref.read(profileControllerProvider(namespace)).create(name);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final profilesAsync = ref.watch(profileListProvider(namespace));
    final currentAsync = ref.watch(currentProfileProvider(namespace));

    return AppScaffold(
      title: OutlinedTitleText(text: t.profile.switchPageTitle),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _create(context, ref),
        label: Text(t.profile.create),
      ),
      body: profilesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (profiles) => ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: ListItemContainer(
                children: [
                  for (final profile in profiles)
                    _ProfileTile(
                      namespace: namespace,
                      profile: profile,
                      isCurrent: currentAsync.value?.id == profile.id,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTile extends ConsumerWidget {
  const _ProfileTile({
    required this.namespace,
    required this.profile,
    required this.isCurrent,
  });

  final String namespace;
  final Profile profile;
  final bool isCurrent;

  Future<void> _select(BuildContext context, WidgetRef ref) async {
    await ref.read(profileControllerProvider(namespace)).select(profile);
    if (context.mounted) {
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _rename(BuildContext context, WidgetRef ref) async {
    final name = await ProfileNameDialog.show(context, initial: profile.name);
    if (name == null || name.isEmpty) {
      return;
    }
    await ref.read(profileControllerProvider(namespace)).rename(profile, name);
  }

  Future<void> _delete(WidgetRef ref) async {
    await ref.read(profileControllerProvider(namespace)).delete(profile);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListItemTile(
      label: profile.name,
      onTap: () => _select(context, ref),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => _rename(context, ref),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => _delete(ref),
          ),
          SizedBox(
            width: 24,
            child: isCurrent ? const Icon(Icons.check) : null,
          ),
        ],
      ),
    );
  }
}
