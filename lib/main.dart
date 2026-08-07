import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/objectbox/objectbox.dart';
import 'i18n/gen/strings.g.dart';
import 'providers/objectbox_providers.dart';
import 'routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final objectBox = await ObjectBox.create();
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
          title: 'denpa_memo',
          theme: ThemeData(
            colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          ),
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
