import 'package:core_domain/model/observation_payload.dart';
import 'package:core_runtime/observation/observation_scheduler.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ObservationScheduler (Core & Alignment)', () {
    test('initializes and schedules first window correctly', () {
      fakeAsync((async) {
        final now = DateTime.utc(2024, 1, 1, 10, 0, 0); // At 10:00 zero seconds
        DateTime? currentNow = now;
        Duration currentMonotonic = Duration.zero;

        bool windowStarted = false;
        Duration missingAtStart = Duration.zero;

        final scheduler = ObservationScheduler(
          nowProvider: () => currentNow!,
          monotonicNowProvider: () => currentMonotonic,
          onWindowStart: (startBusiness, missing) {
            windowStarted = true;
            missingAtStart = missing;
          },
          onWindowEnd: (_) {},
        );
        addTearDown(scheduler.stop);

        scheduler.start();
        scheduler.ensureWindowActive();

        expect(windowStarted, true);
        expect(scheduler.windowEndUtc, DateTime.utc(2024, 1, 1, 10, 5, 0));
        expect(missingAtStart, Duration.zero, reason: "First window started exactly at boundary, so start-gap is zero");

        // Fast forward past boundary
        currentNow = currentNow.add(const Duration(minutes: 5, seconds: 1));
        currentMonotonic += const Duration(minutes: 5, seconds: 1);

        async.elapse(const Duration(minutes: 5, seconds: 1));

        expect(scheduler.windowEndUtc, DateTime.utc(2024, 1, 1, 10, 10, 0));
        expect(missingAtStart, Duration.zero, reason: "Continuous rollover has no missing duration");
      });
    });

    test('ensureWindowActive is idempotent within a window', () {
      final now = DateTime.utc(2024, 1, 1, 10, 0, 0);
      var startCount = 0;

      final scheduler = ObservationScheduler(
        nowProvider: () => now,
        monotonicNowProvider: () => Duration.zero,
        onWindowStart: (_, _) => startCount++,
        onWindowEnd: (_) {},
      );
      addTearDown(scheduler.stop);

      scheduler.start();
      scheduler.ensureWindowActive();
      expect(startCount, 1);

      scheduler.ensureWindowActive();
      expect(startCount, 1, reason: 'No new window should open while current window is still active');
    });

    test('stop discards the window and restart establishes a fresh clock baseline', () {
      fakeAsync((async) {
        var wall = DateTime.utc(2024, 1, 1, 10, 1);
        var monotonic = Duration.zero;
        var jumpCount = 0;
        var startCount = 0;
        var endCount = 0;
        final scheduler = ObservationScheduler(
          nowProvider: () => wall,
          monotonicNowProvider: () => monotonic,
          onWindowStart: (_, _) => startCount++,
          onWindowEnd: (_) => endCount++,
          onClockJump: (_) => jumpCount++,
        );
        addTearDown(scheduler.stop);

        expect(scheduler.isRunning, isFalse);
        scheduler.start();
        scheduler.start();
        expect(scheduler.isRunning, isTrue);
        scheduler.ensureWindowActive();
        async.elapse(const Duration(seconds: 5));

        scheduler.stop();
        expect(scheduler.isRunning, isFalse);
        expect(scheduler.windowStartUtc, isNull);
        expect(endCount, 0, reason: 'Stopping discards without ending the window');
        scheduler.ensureWindowActive();
        expect(startCount, 1, reason: 'A stopped scheduler must not open a window');

        wall = wall.add(const Duration(hours: 2));
        monotonic += const Duration(hours: 2);
        scheduler.start();
        scheduler.ensureWindowActive();
        expect(startCount, 2, reason: 'Restart should allow a fresh window to open');
        async.elapse(const Duration(seconds: 5));
        expect(jumpCount, 0, reason: 'Restart begins with a fresh detector baseline');

        wall = wall.add(const Duration(hours: 2));
        monotonic += const Duration(seconds: 5);
        async.elapse(const Duration(seconds: 5));
        expect(jumpCount, 1);
      });
    });

    test('scheduler window length equals kWindowDuration', () {
      final clock = DateTime.utc(2026, 1, 1, 10, 0, 1);
      final scheduler = ObservationScheduler(
        nowProvider: () => clock,
        monotonicNowProvider: () => Duration.zero,
        onWindowStart: (_, _) {},
        onWindowEnd: (_) {},
      );
      addTearDown(scheduler.stop);

      scheduler.start();
      scheduler.ensureWindowActive();
      expect(scheduler.windowEndUtc!.difference(scheduler.windowStartUtc!), kWindowDuration);
    });
  });

  group('ObservationScheduler (Extreme Cases)', () {
    test('onClockJump fires before the window rolls', () {
      fakeAsync((async) {
        var wall = DateTime(2026, 6, 1, 12, 1);
        var monotonic = Duration.zero;
        final events = <String>[];

        final scheduler = ObservationScheduler(
          nowProvider: () => wall,
          monotonicNowProvider: () => monotonic,
          onWindowStart: (_, _) => events.add('start'),
          onWindowEnd: (_) => events.add('end'),
          onClockJump: (_) => events.add('jump'),
        );
        addTearDown(scheduler.stop);
        scheduler.start();
        scheduler.ensureWindowActive();
        async.elapse(const Duration(seconds: 5));
        events.clear();

        wall = wall.add(const Duration(minutes: 10));
        monotonic += const Duration(seconds: 5);
        async.elapse(const Duration(seconds: 5));

        expect(events, ['jump', 'end', 'start']);
      });
    });
    test('clock jump rolls window without discarding', () {
      fakeAsync((async) {
        DateTime currentNow = DateTime.utc(2024, 1, 1, 10, 0, 0);
        Duration currentMonotonic = Duration.zero;
        bool started = false;
        var ended = false;
        Duration? missingAtStart;

        final scheduler = ObservationScheduler(
          nowProvider: () => currentNow,
          monotonicNowProvider: () => currentMonotonic,
          onWindowStart: (_, missing) {
            started = true;
            missingAtStart = missing;
          },
          onWindowEnd: (_) => ended = true,
        );
        addTearDown(scheduler.stop);
        scheduler.start();

        scheduler.ensureWindowActive();
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
        expect(ended, isTrue);
      });
    });

    test('backward clock jump rolls the window', () {
      fakeAsync((async) {
        var wall = DateTime(2026, 6, 1, 12, 1);
        var monotonic = Duration.zero;
        final events = <String>[];
        final scheduler = ObservationScheduler(
          nowProvider: () => wall,
          monotonicNowProvider: () => monotonic,
          onWindowStart: (_, _) => events.add('start'),
          onWindowEnd: (_) => events.add('end'),
          onClockJump: (_) => events.add('jump'),
        );
        addTearDown(scheduler.stop);
        scheduler.start();
        scheduler.ensureWindowActive();
        async.elapse(const Duration(seconds: 5));
        events.clear();

        wall = wall.subtract(const Duration(hours: 2));
        monotonic += const Duration(seconds: 5);
        async.elapse(const Duration(seconds: 5));

        expect(events, ['jump', 'end', 'start']);
        expect(scheduler.windowStartUtc, DateTime(2026, 6, 1, 10).toUtc());
      });
    });
  });

  group('ObservationScheduler (Gap & Continuity)', () {
    test('missingAtStart reports gap when source restarts late into a window', () {
      DateTime currentNow = DateTime.utc(2024, 1, 1, 10, 0, 0);
      Duration? reportedMissingAtStart;

      final scheduler = ObservationScheduler(
        nowProvider: () => currentNow,
        monotonicNowProvider: () => Duration.zero,
        onWindowStart: (_, missing) => reportedMissingAtStart = missing,
        onWindowEnd: (_) {},
      );
      addTearDown(scheduler.stop);

      scheduler.start();
      // First window starts at 10:00
      scheduler.ensureWindowActive();

      // Source goes down. Restart 30 seconds into the 10:15 window.
      currentNow = DateTime.utc(2024, 1, 1, 10, 15, 30);
      scheduler.ensureWindowActive();

      // Gap from window start (10:15:00) to first frame (10:15:30) = 30 seconds
      expect(
        reportedMissingAtStart,
        const Duration(seconds: 30),
        reason: "Coverage loss at window start (nowUtc − windowStartUtc) must be reported",
      );
    });

    test('window rolls exactly at the boundary, not before', () {
      var clock = DateTime(2026, 6, 1, 12, 0, 1);
      var starts = 0;
      final scheduler = ObservationScheduler(
        nowProvider: () => clock,
        monotonicNowProvider: () => Duration.zero,
        onWindowStart: (_, _) => starts++,
        onWindowEnd: (_) {},
      );
      addTearDown(scheduler.stop);

      scheduler.start();
      scheduler.ensureWindowActive();
      clock = DateTime(2026, 6, 1, 12, 4, 59, 999);
      scheduler.ensureWindowActive();
      expect(starts, 1);

      clock = DateTime(2026, 6, 1, 12, 5);
      scheduler.ensureWindowActive();
      expect(starts, 2);
    });

    test('debugForceWindowEnd invokes onWindowEnd and clears active window', () {
      DateTime currentNow = DateTime.utc(2024, 1, 1, 10, 0, 0);
      var endCount = 0;

      final scheduler = ObservationScheduler(
        nowProvider: () => currentNow,
        monotonicNowProvider: () => Duration.zero,
        onWindowStart: (_, _) {},
        onWindowEnd: (_) => endCount++,
      );
      addTearDown(scheduler.stop);

      scheduler.start();
      scheduler.ensureWindowActive();
      expect(scheduler.windowEndUtc, DateTime.utc(2024, 1, 1, 10, 5, 0));

      scheduler.debugForceWindowEnd();

      expect(endCount, 1, reason: 'debug force-end must call onWindowEnd once for an active window');
      expect(scheduler.windowEndUtc, isNull, reason: 'debug force-end should clear active window state');
    });

    test('debugForceWindowEnd is a no-op when no window is active', () {
      DateTime currentNow = DateTime.utc(2024, 1, 1, 10, 0, 0);
      var endCount = 0;

      final scheduler = ObservationScheduler(
        nowProvider: () => currentNow,
        monotonicNowProvider: () => Duration.zero,
        onWindowStart: (_, _) {},
        onWindowEnd: (_) => endCount++,
      );
      addTearDown(scheduler.stop);

      scheduler.debugForceWindowEnd();

      expect(endCount, 0);
      expect(scheduler.windowEndUtc, isNull);
    });

    test('debugForceWindowEnd after stop is a no-op', () {
      final clock = DateTime.utc(2024, 1, 1, 10);
      var endCount = 0;
      final scheduler = ObservationScheduler(
        nowProvider: () => clock,
        monotonicNowProvider: () => Duration.zero,
        onWindowStart: (_, _) {},
        onWindowEnd: (_) => endCount++,
      );
      addTearDown(scheduler.stop);

      scheduler.start();
      scheduler.ensureWindowActive();
      scheduler.stop();
      scheduler.debugForceWindowEnd();

      expect(endCount, 0);
      expect(scheduler.windowEndUtc, isNull);
    });
  });

  group('ObservationScheduler (Static window-boundary helpers)', () {
    test('createStartLocal snaps down to nearest 5-minute boundary in local time', () {
      // createStartLocal always returns local time
      expect(
        ObservationScheduler.createStartLocal(DateTime.utc(2024, 1, 1, 10, 0, 0)).toUtc(),
        DateTime.utc(2024, 1, 1, 10, 0, 0),
      );
      expect(
        ObservationScheduler.createStartLocal(DateTime.utc(2024, 1, 1, 10, 3, 42)).toUtc(),
        DateTime.utc(2024, 1, 1, 10, 0, 0),
      );
      expect(
        ObservationScheduler.createStartLocal(DateTime.utc(2024, 1, 1, 10, 59, 59)).toUtc(),
        DateTime.utc(2024, 1, 1, 10, 55, 0),
      );
    });

    test('createStartLocal + kWindowDuration returns end for current window', () {
      // createStartLocal returns local time, convert to UTC for comparison
      final start1 = ObservationScheduler.createStartLocal(DateTime.utc(2024, 1, 1, 10, 0, 0));
      expect(start1.add(kWindowDuration).toUtc(), DateTime.utc(2024, 1, 1, 10, 5, 0));
      final start2 = ObservationScheduler.createStartLocal(DateTime.utc(2024, 1, 1, 10, 3, 42));
      expect(start2.add(kWindowDuration).toUtc(), DateTime.utc(2024, 1, 1, 10, 5, 0));
      final start3 = ObservationScheduler.createStartLocal(DateTime.utc(2024, 1, 1, 10, 59, 59));
      expect(start3.add(kWindowDuration).toUtc(), DateTime.utc(2024, 1, 1, 11, 0, 0));
    });
  });
}
