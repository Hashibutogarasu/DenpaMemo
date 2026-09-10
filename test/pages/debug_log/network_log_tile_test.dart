import 'package:app_logging/app_logging.dart';
import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:denpa_memo/i18n/gen/strings.g.dart';
import 'package:denpa_memo/pages/debug_log/network_log_tile.dart';
import 'package:denpa_memo/theme/app_theme.dart';

NetworkLogEntry _entry({
  required NetworkLogStatus status,
  String operation = 'GET /tables',
  String? uri,
  String? requestBody,
  String? responseBody,
  int? requestBytes,
  int? responseBytes,
}) =>
    LogEntry.network(
          id: 'entry-1',
          timestamp: DateTime(2026, 1, 1),
          level: LogLevel.info,
          protocol: NetworkProtocol.rest,
          status: status,
          operation: operation,
          uri: uri,
          requestBody: requestBody,
          responseBody: responseBody,
          requestBytes: requestBytes,
          responseBytes: responseBytes,
          statusCode: status == NetworkLogStatus.success ? 200 : null,
          duration: const Duration(milliseconds: 42),
        )
        as NetworkLogEntry;

Future<void> _pump(WidgetTester tester, NetworkLogEntry entry) =>
    tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          theme: AppLightTheme.forContrast(AppContrastLevel.standard),
          home: Scaffold(body: NetworkLogTile(entry: entry)),
        ),
      ),
    );

void main() {
  testWidgets('pending entries show no transfer arrow yet', (tester) async {
    await _pump(tester, _entry(status: NetworkLogStatus.pending));
    await tester.pump();

    expect(find.byIcon(Icons.arrow_upward), findsNothing);
    expect(find.byIcon(Icons.arrow_downward), findsNothing);
  });

  testWidgets('a response bigger than the request shows the download arrow', (
    tester,
  ) async {
    await _pump(
      tester,
      _entry(
        status: NetworkLogStatus.success,
        requestBytes: 1,
        responseBytes: 100,
      ),
    );
    await tester.pump();

    expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
    expect(find.byIcon(Icons.arrow_upward), findsNothing);
  });

  testWidgets('a request bigger than the response shows the upload arrow', (
    tester,
  ) async {
    await _pump(
      tester,
      _entry(
        status: NetworkLogStatus.success,
        requestBytes: 100,
        responseBytes: 1,
      ),
    );
    await tester.pump();

    expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
    expect(find.byIcon(Icons.arrow_downward), findsNothing);
  });

  testWidgets(
    'a binary upload with no text body still counts as an upload by its byte size',
    (tester) async {
      await _pump(
        tester,
        _entry(status: NetworkLogStatus.success, requestBytes: 65536),
      );
      await tester.pump();

      expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
      expect(find.byIcon(Icons.arrow_downward), findsNothing);
    },
  );

  testWidgets('expanding shows both the sent and received body', (
    tester,
  ) async {
    await _pump(
      tester,
      _entry(
        status: NetworkLogStatus.success,
        requestBody: 'the request body',
        responseBody: 'the response body',
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ExpansionTile));
    await tester.pumpAndSettle();

    expect(find.text('the request body'), findsOneWidget);
    expect(find.text('the response body'), findsOneWidget);
  });
}
