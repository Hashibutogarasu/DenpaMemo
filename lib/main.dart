import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/denpa_men/objectbox_denpa_men_repository.dart';
import 'data/master_data/json_master_data_repository.dart';
import 'data/objectbox/objectbox.dart';
import 'domain/denpa_men/denpa_men_hash_migration.dart';
import 'i18n/gen/strings.g.dart';
import 'providers/objectbox_providers.dart';
import 'routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final objectBox = await ObjectBox.create();
  final masterData = await JsonMasterDataRepository().load();
  migrateDenpaMenHashes(ObjectBoxDenpaMenRepository(objectBox), masterData);
  runApp(MyApp(objectBox: objectBox));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.objectBox});

  final ObjectBox objectBox;

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: ProviderScope(
        overrides: [objectBoxProvider.overrideWithValue(objectBox)],
        child: MaterialApp.router(
          title: t.app.name,
          theme: ThemeData(
            colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          ),
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
