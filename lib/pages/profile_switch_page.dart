import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension, Translations, t;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/profile/profile.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/profile_providers.dart';
import '../widgets/list/list_item_container.dart';
import '../widgets/list/list_item_tile.dart';
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
    if (name == null || name.isEmpty || !context.mounted) {
      return;
    }
    final storage = ref.read(profileStorageProvider(namespace));
    final profile = await storage.create(name);
    await storage.saveCurrentId(profile.id);
    ref.invalidate(profileListProvider(namespace));
    ref.invalidate(currentProfileProvider(namespace));
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
            ListItemContainer(
              children: [
                for (final profile in profiles)
                  _ProfileTile(
                    namespace: namespace,
                    profile: profile,
                    isCurrent: currentAsync.value?.id == profile.id,
                  ),
              ],
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
    final storage = ref.read(profileStorageProvider(namespace));
    await storage.saveCurrentId(profile.id);
    ref.invalidate(currentProfileProvider(namespace));
    if (context.mounted) {
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _rename(BuildContext context, WidgetRef ref) async {
    final name = await ProfileNameDialog.show(context, initial: profile.name);
    if (name == null || name.isEmpty || !context.mounted) {
      return;
    }
    final storage = ref.read(profileStorageProvider(namespace));
    await storage.update(profile.copyWith(name: name));
    ref.invalidate(profileListProvider(namespace));
    ref.invalidate(currentProfileProvider(namespace));
  }

  Future<void> _delete(WidgetRef ref) async {
    final storage = ref.read(profileStorageProvider(namespace));
    await storage.delete(profile.id);
    ref.invalidate(profileListProvider(namespace));
    ref.invalidate(currentProfileProvider(namespace));
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
