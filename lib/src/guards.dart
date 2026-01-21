/// Guard helpers for enforcing domain invariants.
///
/// These helpers are intentionally small and infrastructure-free.
/// They exist to make invariant enforcement explicit and consistent.
///
/// Guard helpers for enforcing invariants.
///
/// The helpers are static to avoid requiring instantiation.
abstract final class Guard {
  /// Throws a [StateError] with [message] when [condition] is false.
  ///
  /// Use this in state transitions to prevent illegal states.
  static void invariant(bool condition, String message) {
    if (!condition) {
      throw StateError(message);
    }
  }
}
