import 'dart:async';

/// Fires at each 5-minute wall-clock boundary (4:00, 4:05, 4:10, ...) and
/// reschedules itself after every tick.
///
/// The scheduler uses it to roll windows on time even when no frames arrive.
///
/// Boundaries are computed on UTC instants. This matches local 5-minute marks
/// because every current timezone offset is a multiple of 15 minutes, and it
/// stays correct across DST changes because UTC has no gaps or repeats.
class WindowBoundaryTimer {
  final DateTime Function() _now;
  final void Function() _onBoundaryTick;

  Timer? _windowTimer;

  WindowBoundaryTimer({required this._now, required this._onBoundaryTick});

  /// Schedules a one-shot timer for the next 5-minute boundary. The timer
  /// calls [_onBoundaryTick] and schedules the following boundary unless it is
  /// disposed during the callback, so ticks stay aligned to the wall clock
  /// instead of drifting like `Timer.periodic`.
  ///
  /// [now] overrides the current time (for tests).
  void scheduleNext({DateTime? now}) {
    // Force the baseline time to UTC before doing ANY math
    final currentTime = (now ?? _now()).toUtc();
    final minute = currentTime.minute - (currentTime.minute % 5);

    // Now these components are safely UTC components
    var windowStart = DateTime.utc(currentTime.year, currentTime.month, currentTime.day, currentTime.hour, minute);

    var nextBoundary = windowStart.add(const Duration(minutes: 5));
    if (!nextBoundary.isAfter(currentTime)) {
      nextBoundary = nextBoundary.add(const Duration(minutes: 5));
    }

    final delay = nextBoundary.difference(currentTime);
    _windowTimer?.cancel();
    //  Delay will now correctly be between 0 and 300 seconds (positive!)
    late final Timer timer;
    timer = Timer(delay, () {
      _onBoundaryTick();
      if (identical(_windowTimer, timer)) scheduleNext();
    });
    _windowTimer = timer;
  }

  /// Cancels the pending timer.
  void dispose() {
    _windowTimer?.cancel();
    _windowTimer = null;
  }
}
