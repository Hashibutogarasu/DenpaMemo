import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/objectbox/objectbox.dart';
import '../../i18n/gen/strings.g.dart';
import '../../providers/denpa_men_icon_providers.dart';
import '../../providers/master_data_providers.dart';
import '../../providers/objectbox_providers.dart';
import '../denpa_men/denpa_men_data.dart';

/// A single throwaway in-memory [ObjectBox] shared by every use case in
/// this Widgetbook session, so widgets backed by
/// `objectBoxProvider`-derived repositories have somewhere to read from
/// and write to without touching the real on-device store.
final ObjectBox widgetbookObjectBox = ObjectBox.createInMemory();

/// [Widgetbook.appBuilder] wrapping every use case with the same
/// [ProviderScope] and [TranslationProvider] `MyApp` provides, using
/// [DenpaMenData.masterData] and [widgetbookObjectBox] in place of live
/// GraphQL/on-device data.
Widget widgetbookScope(BuildContext context, Widget child) {
  return TranslationProvider(
    child: ProviderScope(
      overrides: [
        objectBoxProvider.overrideWithValue(widgetbookObjectBox),
        masterDataProvider.overrideWithValue(AsyncData(DenpaMenData.masterData)),
        denpaMenIconProvider.overrideWith((ref, id) async => null),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: Material(child: child),
      ),
    ),
  );
}
