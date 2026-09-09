/// Throttled bytes/sec estimator for a monotonically increasing byte
/// count (e.g. bytes sent/received so far in a streamed upload/download).
/// Resamples at most once per [minSampleInterval] as [sample] is called
/// with the latest cumulative byte count, so a burst of chunks arriving
/// faster than that doesn't produce a noisy rate on every call. Returns
/// `null` until the first resample window has elapsed.
class RollingTransferRate {
  RollingTransferRate({
    this.minSampleInterval = const Duration(milliseconds: 300),
  });

  final Duration minSampleInterval;

  final Stopwatch _stopwatch = Stopwatch()..start();
  int _lastSampleBytes = 0;
  Duration _lastSampleAt = Duration.zero;

  double? sample(int cumulativeBytes) {
    final now = _stopwatch.elapsed;
    final elapsedSinceLastSample = now - _lastSampleAt;
    if (elapsedSinceLastSample < minSampleInterval) return null;

    final bytesSinceLastSample = cumulativeBytes - _lastSampleBytes;
    final rate =
        bytesSinceLastSample / elapsedSinceLastSample.inMicroseconds * 1e6;
    _lastSampleBytes = cumulativeBytes;
    _lastSampleAt = now;
    return rate;
  }
}

/// Simple cumulative-average items/sec estimator: tracks the wall-clock
/// time of the first [started] call and a running count, so `count /
/// elapsedSeconds` gives a stable (non-jittery) rate across the whole
/// operation rather than a per-item instantaneous one.
class CumulativeItemRate {
  DateTime? _firstStartedAt;
  int _count = 0;

  double? started() {
    final now = DateTime.now();
    _firstStartedAt ??= now;
    _count++;
    final elapsedSeconds =
        now.difference(_firstStartedAt!).inMicroseconds / 1e6;
    if (elapsedSeconds <= 0) return null;
    return _count / elapsedSeconds;
  }
}
