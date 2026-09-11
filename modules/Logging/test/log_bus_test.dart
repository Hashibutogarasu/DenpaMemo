import 'package:app_logging/app_logging.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('marks pending requests as offline timeouts immediately', () async {
    const id = 'offline-timeout-test';
    final entries = <LogEntry>[];
    final subscription = LogBus.instance.network.listen((entry) {
      if (entry.id == id) entries.add(entry);
    });
    addTearDown(subscription.cancel);

    LogBus.instance.addNetwork(
      LogEntry.network(
        id: id,
        timestamp: DateTime.now(),
        level: LogLevel.info,
        protocol: NetworkProtocol.rest,
        status: NetworkLogStatus.pending,
      ),
    );
    LogBus.instance.markPendingNetworkRequestsOffline();
    await Future<void>.delayed(Duration.zero);

    final entry = entries.last as NetworkLogEntry;
    expect(entry.status, NetworkLogStatus.skipped);
    expect(entry.isTimeout, isTrue);
    expect(entry.errorMessage, 'offline');
  });
}
