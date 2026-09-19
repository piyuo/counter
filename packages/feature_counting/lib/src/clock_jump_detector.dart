import 'dart:async';

/// Detects when the wall clock jumps relative to the monotonic clock,
/// indicating NTP corrections, host sleep/wake, or DST changes.
///
/// Samples automatically every [_samplingInterval] by comparing the wall-clock
/// delta against the monotonic delta. If they diverge by more than [threshold],
/// [onJumpDetected] is fired. Call [dispose] when the owning object is destroyed.
class ClockJumpDetector {
  static const Duration _samplingInterval = Duration(seconds: 5);

  final DateTime Function() _now;
  final Duration Function() _monotonicNow;
  final Duration _threshold;
  final void Function(DateTime now) _onJumpDetected;

  DateTime? _lastObserved;
  Duration? _lastObservedMonotonic;

  Timer? _timer;

  ClockJumpDetector({
    Duration Function()? monotonicNow,
    required Duration threshold,
    required void Function(DateTime now) onJumpDetected,
    DateTime Function()? nowProvider,
  })  : _monotonicNow = monotonicNow ??
            (() {
              _monotonicClock ??= Stopwatch()..start();
              return _monotonicClock!.elapsed;
            }),
        _threshold = threshold,
        _onJumpDetected = onJumpDetected,
        _now = nowProvider ?? (() => DateTime.now()) {
    _timer = Timer.periodic(_samplingInterval, (_) => checkAndReport(_now()));
  }

  /// Shared monotonic stopwatch used when no [monotonicNow] is injected.
  /// Static so it persists across detector instances in the same process.
  static Stopwatch? _monotonicClock;

  /// Cancels the sampling timer. Must be called when the owning object is disposed.
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }

  /// Checks if a clock jump occurred between [now] and the last observation.
  /// Returns `true` if a jump was detected (and [onJumpDetected] was fired).
  /// Called automatically by the internal timer; may also be called manually.
  bool checkAndReport(DateTime now) {
    final monotonicNow = _monotonicNow();

    if (_lastObserved == null) {
      _lastObserved = now;
      _lastObservedMonotonic = monotonicNow;
      return false;
    }

    final delta = now.difference(_lastObserved!).abs();
    final monotonicDelta =
        _lastObservedMonotonic == null ? Duration.zero : (monotonicNow - _lastObservedMonotonic!).abs();

    _lastObserved = now;
    _lastObservedMonotonic = monotonicNow;

    if ((delta - monotonicDelta).abs() < _threshold) {
      return false;
    }

    _onJumpDetected(now);
    return true;
  }

  /// Resets the observation state. Called after a jump or when rewinding.
  void reset() {
    _lastObserved = null;
    _lastObservedMonotonic = null;
  }
}
