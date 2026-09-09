import 'dart:async';

import 'package:data_pack/data_pack.dart';
import 'package:dm_file/dm_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/data/cloud_file/objectbox_cloud_file_repository.dart';
import 'package:denpa_memo/data/objectbox/objectbox.dart';
import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/providers/app_notification_providers.dart';
import 'package:denpa_memo/providers/cancellation.dart';
import 'package:denpa_memo/providers/cloud_backup_restore_providers.dart';
import 'package:denpa_memo/providers/cloud_backup_upload_providers.dart';
import 'package:denpa_memo/providers/pending_operation_result_providers.dart';
import 'package:denpa_memo/routing/app_router.dart';
import 'package:denpa_memo/widgets/dialog/export_complete_dialog.dart';
import 'package:denpa_memo/widgets/dialog/import_complete_dialog.dart';
import '../support/test_app.dart';

/// A throwaway [Ref] to satisfy [CloudBackupRestoreController]'s/
/// [CloudBackupUploadController]'s constructor — the fake subclasses below
/// never read it, since they short-circuit `restore`/`upload` entirely, so
/// it doesn't need to be bound to the same container as the widget tree
/// under test.
final _dummyRefProvider = Provider<Ref>((ref) => ref);

class _FakeRestoreController extends CloudBackupRestoreController {
  _FakeRestoreController(super.ref, this.completer);

  final Completer<ImportResult?> completer;

  @override
  Future<ImportResult?> restore(
    BuildContext context, {
    required Cancellation cancellation,
    CloudFile? target,
  }) => completer.future;
}

class _FakeUploadController extends CloudBackupUploadController {
  _FakeUploadController(super.ref, this.completer);

  final Completer<ExportResult> completer;

  @override
  Future<ExportResult> upload(
    MasterData masterData, {
    required Cancellation cancellation,
  }) => completer.future;
}

Future<void> _pumpUntilSettled(WidgetTester tester) async {
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 200));
  }
}

void main() {
  testWidgets('restoring from the history screen still shows the import result '
      'dialog after navigating away to an unrelated screen before it '
      'completes', (WidgetTester tester) async {
    final objectBox = ObjectBox.createInMemory();
    addTearDown(objectBox.store.close);
    ObjectBoxCloudFileRepository(objectBox).save(
      CloudFile(
        fileId: 'f1',
        filename: 'backup.dm',
        uploadedAt: DateTime.now(),
      ),
    );

    final completer = Completer<ImportResult?>();
    final dummyRefContainer = ProviderContainer();
    addTearDown(dummyRefContainer.dispose);
    final dummyRef = dummyRefContainer.read(_dummyRefProvider);

    await tester.pumpWidget(
      TestApp(
        objectBox: objectBox,
        overrides: [
          cloudBackupRestoreControllerProvider.overrideWithValue(
            _FakeRestoreController(dummyRef, completer),
          ),
        ],
      ),
    );
    await _pumpUntilSettled(tester);

    final context = tester.element(find.byType(Scaffold).first);
    final container = ProviderScope.containerOf(context, listen: false);
    const CloudBackupHistoryRoute().push(context);
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.more_vert).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text(t.cloudBackup.restoreAction));
    await tester.pump();

    // Simulate what the real CloudBackupRestoreController.restore would
    // have already done at this point (the fake overrides it away
    // entirely) — a `running` AppNotification, so the global result
    // listener in main.dart has a `running` state to transition from.
    container
        .read(appNotificationsProvider.notifier)
        .setStatus(
          'cloud_backup_restore',
          status: AppNotificationStatus.running,
          progress: 0,
        );

    final elsewhereContext = tester.element(find.byType(Scaffold).first);
    const HomeRoute().go(elsewhereContext);
    await tester.pumpAndSettle();

    // Simulate the controller's success path: stash the result payload,
    // then flip the notification to completed.
    const result = ImportResult();
    container
        .read(pendingOperationResultProvider.notifier)
        .set('cloud_backup_restore', result);
    container
        .read(appNotificationsProvider.notifier)
        .setStatus(
          'cloud_backup_restore',
          status: AppNotificationStatus.completed,
          progress: 1,
        );
    completer.complete(result);
    await tester.pumpAndSettle();

    expect(find.byType(ImportCompleteDialog), findsOneWidget);
  });

  testWidgets('uploading from the cloud backup screen still shows the export '
      'result dialog after navigating away to an unrelated screen before '
      'it completes', (WidgetTester tester) async {
    final objectBox = ObjectBox.createInMemory();
    addTearDown(objectBox.store.close);

    final completer = Completer<ExportResult>();
    final dummyRefContainer = ProviderContainer();
    addTearDown(dummyRefContainer.dispose);
    final dummyRef = dummyRefContainer.read(_dummyRefProvider);

    await tester.pumpWidget(
      TestApp(
        objectBox: objectBox,
        overrides: [
          cloudBackupUploadControllerProvider.overrideWithValue(
            _FakeUploadController(dummyRef, completer),
          ),
        ],
      ),
    );
    await _pumpUntilSettled(tester);

    final context = tester.element(find.byType(Scaffold).first);
    final container = ProviderScope.containerOf(context, listen: false);
    const CloudBackupRoute().push(context);
    await tester.pumpAndSettle();

    await tester.tap(find.text(t.cloudBackup.latestBackupLabel));
    await tester.pump();

    container
        .read(appNotificationsProvider.notifier)
        .setStatus(
          'cloud_backup_upload',
          status: AppNotificationStatus.running,
          progress: 0,
        );

    final elsewhereContext = tester.element(find.byType(Scaffold).first);
    const HomeRoute().go(elsewhereContext);
    await tester.pumpAndSettle();

    const result = ExportResult();
    container
        .read(pendingOperationResultProvider.notifier)
        .set('cloud_backup_upload', result);
    container
        .read(appNotificationsProvider.notifier)
        .setStatus(
          'cloud_backup_upload',
          status: AppNotificationStatus.completed,
          progress: 1,
        );
    completer.complete(result);
    await tester.pumpAndSettle();

    expect(find.byType(ExportCompleteDialog), findsOneWidget);
  });
}
