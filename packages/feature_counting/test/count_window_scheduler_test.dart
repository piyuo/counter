import 'package:fake_async/fake_async.dart';
import 'package:feature_counting/src/count_window_scheduler.dart';
import 'package:feature_counting/src/window_count_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CountWindowScheduler (Core & Alignment)', () {
    test('initializes and schedules first window correctly', () {
      fakeAsync((async) {
        final now = DateTime.utc(2024, 1, 1, 10, 0, 0); // At 10:00 zero seconds
        DateTime? currentNow = now;
        Duration currentMonotonic = Duration.zero;

        bool windowStarted = false;
        DateTime? windowStart;
        DateTime? windowStartBusiness;
        Duration missingAtStart = Duration.zero;

        final scheduler = CountWindowScheduler(
          nowProvider: () => currentNow!,
          monotonicNowProvider: () => currentMonotonic,
          onWindowStart: (startUtc, startBusiness, missing) {
            windowStarted = true;
            windowStart = startUtc;
            windowStartBusiness = startBusiness;
            missingAtStart = missing;
          },
          onWindowEnd: (_, __, ___) {},
        );

        scheduler.start();
        scheduler.onSourceStarted();

        expect(windowStarted, true);
        expect(windowStart, DateTime.utc(2024, 1, 1, 10, 0, 0));
        expect(windowStartBusiness!.toUtc(), windowStart); // Local time should convert back to same UTC
        expect(scheduler.windowEndUtc, DateTime.utc(2024, 1, 1, 10, 5, 0));
        expect(missingAtStart, Duration.zero, reason: "First window started exactly at boundary, so start-gap is zero");

        // Fast forward past boundary
        currentNow = currentNow.add(const Duration(minutes: 5, seconds: 1));
        currentMonotonic += const Duration(minutes: 5, seconds: 1);

        async.elapse(const Duration(minutes: 5, seconds: 1));

        expect(windowStart, DateTime.utc(2024, 1, 1, 10, 5, 0));
        expect(windowStartBusiness!.toUtc(), windowStart); // Local time should convert back to same UTC
        expect(scheduler.windowEndUtc, DateTime.utc(2024, 1, 1, 10, 10, 0));
        expect(missingAtStart, Duration.zero, reason: "Continuous rollover has no missing duration");

        scheduler.dispose();
      });
    });

    test('onSourceStarted is idempotent with an active window', () {
      final now = DateTime.utc(2024, 1, 1, 10, 0, 0);
      var startCount = 0;

      final scheduler = CountWindowScheduler(
        nowProvider: () => now,
        monotonicNowProvider: () => Duration.zero,
        onWindowStart: (_, __, ___) => startCount++,
        onWindowEnd: (_, __, ___) {},
      );

      scheduler.onSourceStarted();
      expect(startCount, 1);

      scheduler.onSourceStarted();
      expect(startCount, 1, reason: 'No new window should open while current window is still active');

      scheduler.dispose();
    });
  });

  group('CountWindowScheduler (Extreme Cases)', () {
    test('clock jump rolls window without discarding', () {
      fakeAsync((async) {
        DateTime currentNow = DateTime.utc(2024, 1, 1, 10, 0, 0);
        Duration currentMonotonic = Duration.zero;
        bool started = false;
        Duration? missingAtStart;

        final scheduler = CountWindowScheduler(
          nowProvider: () => currentNow,
          monotonicNowProvider: () => currentMonotonic,
          onWindowStart: (_, __, missing) {
            started = true;
            missingAtStart = missing;
          },
          onWindowEnd: (_, __, ___) {},
        );

        scheduler.onSourceStarted();
        expect(started, true);

        // First detector tick: establishes the baseline observation.
        async.elapse(const Duration(seconds: 5));
        started = false;

        // Simulate clock jump: wall clock jumps 2 hours, monotonic only moves 1s.
        currentNow = currentNow.add(const Duration(hours: 2));
        currentMonotonic += const Duration(seconds: 1);

        // Next detector tick: divergence > threshold fires onJumpDetected.
        async.elapse(const Duration(seconds: 5));

        expect(started, true, reason: "Should immediately ensure new window");
        expect(missingAtStart, isNotNull);

        scheduler.dispose();
      });
    });
  });

  group('CountWindowScheduler (Gap & Continuity)', () {
    test('missingAtStart reports gap when source restarts late into a window', () {
      DateTime currentNow = DateTime.utc(2024, 1, 1, 10, 0, 0);
      Duration? reportedMissingAtStart;

      final scheduler = CountWindowScheduler(
        nowProvider: () => currentNow,
        monotonicNowProvider: () => Duration.zero,
        onWindowStart: (_, __, missing) => reportedMissingAtStart = missing,
        onWindowEnd: (_, __, ___) {},
      );

      // First window starts at 10:00
      scheduler.onSourceStarted();

      // Source goes down. Restart 30 seconds into the 10:15 window.
      currentNow = DateTime.utc(2024, 1, 1, 10, 15, 30);
      scheduler.onSourceStarted();

      // Gap from window start (10:15:00) to first frame (10:15:30) = 30 seconds
      expect(
        reportedMissingAtStart,
        const Duration(seconds: 30),
        reason: "Coverage loss at window start (nowUtc − windowStartUtc) must be reported",
      );
    });
    test('ensureWindowActive reports start-gap after reset', () {
      DateTime currentNow = DateTime.utc(2024, 1, 1, 10, 0, 0);
      Duration? missingAtStart;

      final scheduler = CountWindowScheduler(
        nowProvider: () => currentNow,
        monotonicNowProvider: () => Duration.zero,
        onWindowStart: (_, __, missing) => missingAtStart = missing,
        onWindowEnd: (_, __, ___) {},
      );

      scheduler.onSourceStarted();

      // Reset and reopen 30 seconds into a window — gap should be reported.
      currentNow = DateTime.utc(2024, 1, 1, 11, 0, 30);
      scheduler.reset();
      scheduler.ensureWindowActive();

      expect(
        missingAtStart,
        const Duration(seconds: 30),
        reason: 'Start-gap must be reported for every freshly opened window after reset',
      );

      scheduler.dispose();
    });

    test('reset clears active window so source start can open a new window', () {
      DateTime currentNow = DateTime.utc(2024, 1, 1, 10, 0, 0);
      var startCount = 0;

      final scheduler = CountWindowScheduler(
        nowProvider: () => currentNow,
        monotonicNowProvider: () => Duration.zero,
        onWindowStart: (_, __, ___) => startCount++,
        onWindowEnd: (_, __, ___) {},
      );

      scheduler.onSourceStarted();
      expect(startCount, 1);

      scheduler.reset();

      // Move to next window to ensure a fresh open would be observable.
      currentNow = DateTime.utc(2024, 1, 1, 10, 5, 0);
      scheduler.onSourceStarted();

      expect(startCount, 2, reason: 'reset() should clear active window state for a new counting session');

      scheduler.dispose();
    });

    test('debugForceWindowEnd invokes onWindowEnd and clears active window', () {
      DateTime currentNow = DateTime.utc(2024, 1, 1, 10, 0, 0);
      var endCount = 0;

      final scheduler = CountWindowScheduler(
        nowProvider: () => currentNow,
        monotonicNowProvider: () => Duration.zero,
        onWindowStart: (_, __, ___) {},
        onWindowEnd: (_, __, ___) => endCount++,
      );

      scheduler.onSourceStarted();
      expect(scheduler.windowEndUtc, DateTime.utc(2024, 1, 1, 10, 5, 0));

      scheduler.debugForceWindowEnd();

      expect(endCount, 1, reason: 'debug force-end must call onWindowEnd once for an active window');
      expect(scheduler.windowEndUtc, isNull, reason: 'debug force-end should clear active window state');

      scheduler.dispose();
    });

    test('debugForceWindowEnd is a no-op when no window is active', () {
      DateTime currentNow = DateTime.utc(2024, 1, 1, 10, 0, 0);
      var endCount = 0;

      final scheduler = CountWindowScheduler(
        nowProvider: () => currentNow,
        monotonicNowProvider: () => Duration.zero,
        onWindowStart: (_, __, ___) {},
        onWindowEnd: (_, __, ___) => endCount++,
      );

      scheduler.debugForceWindowEnd();

      expect(endCount, 0);
      expect(scheduler.windowEndUtc, isNull);

      scheduler.dispose();
    });
  });

  group('CountWindowScheduler (Static window-boundary helpers)', () {
    test('createStartLocal snaps down to nearest 5-minute boundary in local time', () {
      // createStartLocal always returns local time
      expect(
        CountWindowScheduler.createStartLocal(DateTime.utc(2024, 1, 1, 10, 0, 0)).toUtc(),
        DateTime.utc(2024, 1, 1, 10, 0, 0),
      );
      expect(
        CountWindowScheduler.createStartLocal(DateTime.utc(2024, 1, 1, 10, 3, 42)).toUtc(),
        DateTime.utc(2024, 1, 1, 10, 0, 0),
      );
      expect(
        CountWindowScheduler.createStartLocal(DateTime.utc(2024, 1, 1, 10, 59, 59)).toUtc(),
        DateTime.utc(2024, 1, 1, 10, 55, 0),
      );
    });

    test('createStartLocal + kWindowDuration returns end for current window', () {
      // createStartLocal returns local time, convert to UTC for comparison
      final start1 = CountWindowScheduler.createStartLocal(DateTime.utc(2024, 1, 1, 10, 0, 0));
      expect(start1.add(kWindowDuration).toUtc(), DateTime.utc(2024, 1, 1, 10, 5, 0));
      final start2 = CountWindowScheduler.createStartLocal(DateTime.utc(2024, 1, 1, 10, 3, 42));
      expect(start2.add(kWindowDuration).toUtc(), DateTime.utc(2024, 1, 1, 10, 5, 0));
      final start3 = CountWindowScheduler.createStartLocal(DateTime.utc(2024, 1, 1, 10, 59, 59));
      expect(start3.add(kWindowDuration).toUtc(), DateTime.utc(2024, 1, 1, 11, 0, 0));
    });
  });
}
