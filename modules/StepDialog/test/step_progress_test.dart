import 'package:flutter_test/flutter_test.dart';
import 'package:step_dialog/step_dialog.dart';

void main() {
  test('stepProgress returns step / totalSteps', () {
    expect(stepProgress(1, 4), 0.25);
    expect(stepProgress(4, 4), 1.0);
  });

  test('stepProgressWithinEntries falls back to stepProgress when entryCount is 0', () {
    expect(
      stepProgressWithinEntries(2, 4, 0, 0),
      stepProgress(2, 4),
    );
  });

  test('stepProgressWithinEntries reaches the next step boundary at the last entry', () {
    final atLastEntry = stepProgressWithinEntries(2, 4, 2, 3);

    expect(atLastEntry, stepProgress(2, 4));
  });
}
