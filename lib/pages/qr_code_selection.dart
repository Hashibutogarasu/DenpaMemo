import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_providers.dart';
import '../providers/denpa_men_session_providers.dart';
import '../providers/qr_code_providers.dart';
import '../routing/app_router.dart';
import 'denpa_men_editor.dart';

/// Lets the user pick an already-saved QR code to add more individuals
/// under, resuming its catch order instead of starting a new group.
class QrCodeSelectionPage extends ConsumerWidget {
  const QrCodeSelectionPage({super.key, required this.masterData});

  final MasterData masterData;

  String _twoDigits(int value) => value.toString().padLeft(2, '0');

  String _formatDate(DateTime dateTime) {
    return '${dateTime.year}/${_twoDigits(dateTime.month)}/${_twoDigits(dateTime.day)} '
        '${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)}';
  }

  void _select(BuildContext context, WidgetRef ref, QrCodeRecord record) {
    final denpaMenRecords =
        ref.read(denpaMenListProvider(masterData)).value ?? [];
    final existingDenpaMenCount = denpaMenRecords
        .where((r) => r.denpaMen.parentIds.isEmpty)
        .length;
    ref
        .read(denpaMenSessionProvider.notifier)
        .start(
          record.qrCode.rawValue,
          existingQrCode: record.qrCode,
          qrCodeEntityId: record.id,
          existingDenpaMenCount: existingDenpaMenCount,
        );
    AddDenpaMenRoute(
      $extra: DenpaMenEditorArgs(masterData: masterData, sessionMode: true),
    ).push(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final recordsAsync = ref.watch(qrCodeListProvider);

    return AppScaffold(
      title: OutlinedTitleText(text: t.page.selectQrCode),
      body: recordsAsync.when(
        data: (records) {
          if (records.isEmpty) {
            return Center(child: Text(t.home.empty));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 320,
              mainAxisExtent: 96,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              return InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => _select(context, ref, record),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      QrImageView(data: record.qrCode.rawValue, size: 72),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              record.qrCode.name ?? record.qrCode.id,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              _formatDate(record.qrCode.createdAt),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('$error')),
      ),
    );
  }
}
