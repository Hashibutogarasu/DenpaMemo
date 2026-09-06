import 'package:denpamen_logics/denpamen_logics.dart';
import 'package:flutter/material.dart' hide TableRow;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const engine = StatusMatchingEngine();
    final matches = engine.findMatchingColumns(
      primary: const StatusCriterion(
        rows: [TableRow(group: ['demo'], lineOffset: 0, values: [0])],
        targetValue: 0,
      ),
      others: const [],
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('denpamen_logics example')),
        body: Center(child: Text('Matches found: ${matches.length}')),
      ),
    );
  }
}
