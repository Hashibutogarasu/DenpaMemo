import 'package:denpamemo_widgets/denpamemo_widgets.dart' hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n/gen/strings.g.dart';
import '../providers/account_providers.dart';

/// Read-only display of the current account's id and creation date.
class AccountSettingsPage extends ConsumerWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final account = ref.watch(currentAccountProvider).account;
    final createdAt = account.createdAt;
    return AppScaffold(
      title: OutlinedTitleText(text: t.page.accountSettings),
      body: ListView(
        children: [
          ListTile(
            title: Text(t.settings.accountCuidLabel),
            subtitle: Text(account.cuid),
          ),
          ListTile(
            title: Text(t.settings.accountCreatedAtLabel),
            subtitle: Text(
              '${createdAt.year}/${createdAt.month}/${createdAt.day}',
            ),
          ),
        ],
      ),
    );
  }
}
