double stepProgress(int step, int totalSteps) => step / totalSteps;

double stepProgressWithinEntries(
  int step,
  int totalSteps,
  int entryIndex,
  int entryCount,
) {
  if (entryCount == 0) {
    return stepProgress(step, totalSteps);
  }
  final stepStart = (step - 1) / totalSteps;
  final stepSpan = 1 / totalSteps;
  return stepStart + stepSpan * (entryIndex + 1) / entryCount;
}
