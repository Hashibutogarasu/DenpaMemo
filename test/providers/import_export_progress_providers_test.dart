import 'package:denpa_memo/providers/import_export_progress_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('importExportProgressProvider starts null and reflects state updates', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(importExportProgressProvider), isNull);

    container.read(importExportProgressProvider.notifier).state = 0.5;

    expect(container.read(importExportProgressProvider), 0.5);
  });
}
