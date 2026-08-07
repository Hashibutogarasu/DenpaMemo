import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/denpa_men/denpa_men_record.dart';
import '../domain/master_data/master_data.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_providers.dart';
import '../providers/master_data_providers.dart';
import '../routing/app_router.dart';
import '../widgets/denpa_men_status.dart';
import '../widgets/label/outlined_title.dart';
import '../widgets/scaffold/app_scaffold.dart';
import 'denpa_men_editor.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final masterDataAsync = ref.watch(masterDataProvider);

    return AppScaffold(
      title: OutlinedTitleText(text: context.t.page.home),
      body: masterDataAsync.when(
        data: (masterData) => _HomeBody(masterData: masterData),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('$error')),
      ),
      floatingActionButton: masterDataAsync.maybeWhen(
        data: (masterData) => FloatingActionButton(
          onPressed: () => AddDenpaMenRoute(
            $extra: DenpaMenEditorArgs(masterData: masterData),
          ).push(context),
          child: const Icon(Icons.add),
        ),
        orElse: () => null,
      ),
    );
  }
}

/// Scrollable accordion listing every saved [DenpaMen] as a collapsed
/// preview; expanding an entry reveals its full [DenpaMenStatus] plus edit
/// and delete actions.
class _HomeBody extends ConsumerWidget {
  const _HomeBody({required this.masterData});

  final MasterData masterData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(denpaMenListProvider(masterData));

    return recordsAsync.when(
      data: (records) {
        if (records.isEmpty) {
          return Center(child: Text(context.t.home.empty));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: records.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _DenpaMenAccordionTile(
              record: records[index],
              masterData: masterData,
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('$error')),
    );
  }
}

class _DenpaMenAccordionTile extends ConsumerWidget {
  const _DenpaMenAccordionTile({
    required this.record,
    required this.masterData,
  });

  final DenpaMenRecord record;
  final MasterData masterData;

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final t = context.t;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.home.deleteConfirmTitle),
        content: Text(t.home.deleteConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(t.common.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(t.common.delete),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      ref.read(denpaMenRepositoryProvider).delete(record.id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        title: Text(record.denpaMen.name),
        subtitle: Text('${t.denpaMenStatus.level} ${record.denpaMen.level}'),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DenpaMenStatus.fromDenpaMen(
              record.denpaMen,
              totalAttributeCount: masterData.attributes.length,
            ),
          ),
          OverflowBar(
            alignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () => AddDenpaMenRoute(
                  $extra: DenpaMenEditorArgs(
                    masterData: masterData,
                    initial: record,
                  ),
                ).push(context),
                icon: const Icon(Icons.edit),
                label: Text(t.common.edit),
              ),
              TextButton.icon(
                onPressed: () => _delete(context, ref),
                icon: const Icon(Icons.delete),
                label: Text(t.common.delete),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
