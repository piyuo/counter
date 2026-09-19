import 'dart:async';

import 'package:flutter_appkit/flutter_appkit.dart' as appkit;

/// Manages a timer that fires at each 5-minute wall-clock boundary (e.g.
/// 4:00, 4:05, 4:10, …). Automatically reschedules after each boundary.
///
/// This timer is used to drive the periodic window rollover and missing-duration
/// reporting logic in the scheduler.
class WindowBoundaryTimer {
  final DateTime Function() _now;
  final void Function() _onBoundaryTick;

  Timer? _windowTimer;

  WindowBoundaryTimer({
    required DateTime Function() now,
    required void Function() onBoundaryTick,
  })  : _now = now,
        _onBoundaryTick = onBoundaryTick;

  /// Schedules the next timer to fire at the next 5-minute wall-clock boundary.
  /// Automatically reschedules after each tick.
  ///
  /// Optionally accepts [now] to override the current time (useful in testing).
  void scheduleNext({DateTime? now}) {
    // 1. Force the baseline time to UTC before doing ANY math
    final currentTime = (now ?? _now()).toUtc();
    final minute = currentTime.minute - (currentTime.minute % 5);

    // 2. Now these components are safely UTC components
    var windowStart = DateTime.utc(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      currentTime.hour,
      minute,
    );

    var nextBoundary = windowStart.add(const Duration(minutes: 5));
    if (!nextBoundary.isAfter(currentTime)) {
      nextBoundary = nextBoundary.add(const Duration(minutes: 5));
    }

    Duration delay = nextBoundary.difference(currentTime);
    if (delay.isNegative) {
      appkit.logError('Calculated a negative delay! Defaulting to 5 minutes to prevent infinite loop.');
      delay = const Duration(minutes: 5);
    }

    _windowTimer?.cancel();

    // 3. Delay will now correctly be between 0 and 300 seconds (positive!)
    _windowTimer = Timer(delay, () {
      _onBoundaryTick();
      scheduleNext();
    });
  }

  /// Cancels the timer. Called only on dispose.
  void dispose() {
    _windowTimer?.cancel();
    _windowTimer = null;
  }
}
