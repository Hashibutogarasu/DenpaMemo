/// A cooperative cancellation flag: a long-running operation polls
/// [isRequested] at points where stopping is safe, rather than being
/// forcibly torn down mid-operation.
class Cancellation {
  bool _requested = false;

  void request() => _requested = true;

  bool get isRequested => _requested;
}

/// Thrown when a [Cancellation] is observed requested partway through the
/// operation it was passed to.
class CancelledException implements Exception {
  const CancelledException();
}
