import 'package:data_pack/data_pack.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/data/settings/app_settings_entity.dart';
import 'package:denpa_memo/data/settings/app_settings_mapper.dart';

void main() {
  group('AppSettingsEntityToDomain', () {
    test('reads back a fully populated entity', () {
      final entity = AppSettingsEntity(
        themeMode: 'dark',
        contrastLevel: 'high',
        buildTrackerEnabled: true,
      );

      final settings = entity.toDomain();

      expect(settings.themeMode, AppThemeMode.dark);
      expect(settings.contrastLevel, AppContrastLevel.high);
      expect(settings.buildTrackerEnabled, isTrue);
    });

    test(
      'defaults contrastLevel to standard for a row persisted before the '
      'column existed (ObjectBox backfills an empty string, not the '
      'constructor default, for a newly added non-nullable String column)',
      () {
        final entity = AppSettingsEntity(
          themeMode: 'system',
          contrastLevel: '',
        );

        final settings = entity.toDomain();

        expect(settings.contrastLevel, AppContrastLevel.standard);
      },
    );
  });
}
