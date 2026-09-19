import 'package:fake_async/fake_async.dart';
import 'package:feature_counting/src/clock_jump_detector.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClockJumpDetector (Manual checkAndReport)', () {
    test('returns false on first check', () {
      final now = DateTime.utc(2024, 1, 1, 10, 0, 0);
      Duration monotonicTime = Duration.zero;

      bool jumpDetected = false;
      final detector = ClockJumpDetector(
        monotonicNow: () => monotonicTime,
        threshold: const Duration(minutes: 1),
        onJumpDetected: (_) => jumpDetected = true,
      );

      final result = detector.checkAndReport(now);
      expect(result, false);
      expect(jumpDetected, false);
      detector.dispose();
    });

    test('returns false for normal drift within threshold', () {
      final now1 = DateTime.utc(2024, 1, 1, 10, 0, 0);
      final now2 = now1.add(const Duration(seconds: 30));
      Duration monotonicTime = Duration.zero;

      bool jumpDetected = false;
      final detector = ClockJumpDetector(
        monotonicNow: () => monotonicTime,
        threshold: const Duration(minutes: 1),
        onJumpDetected: (_) => jumpDetected = true,
      );

      detector.checkAndReport(now1);
      monotonicTime += const Duration(seconds: 30);

      final result = detector.checkAndReport(now2);
      expect(result, false);
      expect(jumpDetected, false);
      detector.dispose();
    });

    test('detects forward jump when wall clock diverges beyond threshold', () {
      final now1 = DateTime.utc(2024, 1, 1, 10, 0, 0);
      final now2 = now1.add(const Duration(minutes: 5)); // Wall clock jumps 5 minutes
      Duration monotonicTime = Duration.zero;

      bool jumpDetected = false;
      DateTime? detectedAt;
      final detector = ClockJumpDetector(
        monotonicNow: () => monotonicTime,
        threshold: const Duration(minutes: 1),
        onJumpDetected: (time) {
          jumpDetected = true;
          detectedAt = time;
        },
      );

      detector.checkAndReport(now1);
      monotonicTime += const Duration(seconds: 10); // Monotonic only moves 10s

      final result = detector.checkAndReport(now2);
      expect(result, true, reason: "|5min - 10s| > 1 min threshold");
      expect(jumpDetected, true);
      expect(detectedAt, now2);
      detector.dispose();
    });

    test('detects backward clock jump (e.g. DST fall-back)', () {
      final now1 = DateTime.utc(2024, 1, 1, 10, 0, 0);
      final now2 = now1.subtract(const Duration(hours: 1)); // Wall clock goes back 1 hour
      Duration monotonicTime = Duration.zero;

      bool jumpDetected = false;
      final detector = ClockJumpDetector(
        monotonicNow: () => monotonicTime,
        threshold: const Duration(minutes: 1),
        onJumpDetected: (_) => jumpDetected = true,
      );

      detector.checkAndReport(now1);
      monotonicTime += const Duration(seconds: 10); // Monotonic moves forward normally

      final result = detector.checkAndReport(now2);
      expect(result, true, reason: "|-1h - 10s| >> 1 min threshold");
      expect(jumpDetected, true);
      detector.dispose();
    });

    test('exact threshold divergence triggers jump', () {
      final now1 = DateTime.utc(2024, 1, 1, 10, 0, 0);
      final now2 = now1.add(const Duration(minutes: 1)); // Wall moves exactly 1 min
      Duration monotonicTime = Duration.zero;
      // Monotonic stays at zero → divergence = |1min - 0| = 1min, which is NOT < threshold

      bool jumpDetected = false;
      final detector = ClockJumpDetector(
        monotonicNow: () => monotonicTime,
        threshold: const Duration(minutes: 1),
        onJumpDetected: (_) => jumpDetected = true,
      );

      detector.checkAndReport(now1);
      final result = detector.checkAndReport(now2);
      expect(result, true, reason: "Divergence equal to threshold is not < threshold, so it triggers a jump");
      expect(jumpDetected, true);
      detector.dispose();
    });

    test('reset clears observation so next check returns false', () {
      DateTime currentNow = DateTime.utc(2024, 1, 1, 10, 0, 0);
      Duration monotonicTime = Duration.zero;
      bool jumpDetected = false;

      final detector = ClockJumpDetector(
        nowProvider: () => currentNow,
        monotonicNow: () => monotonicTime,
        threshold: const Duration(minutes: 1),
        onJumpDetected: (_) => jumpDetected = true,
      );

      // Establish baseline.
      detector.checkAndReport(currentNow);

      // Advance to a state that would normally trigger a jump.
      currentNow = currentNow.add(const Duration(hours: 2));
      monotonicTime += const Duration(seconds: 1);

      detector.reset();

      // First check after reset acts as a new first observation — no jump.
      final result = detector.checkAndReport(currentNow);
      expect(result, false);
      expect(jumpDetected, false);
      detector.dispose();
    });

    test('resumes normal operation after reset without false positives', () {
      DateTime currentNow = DateTime.utc(2024, 1, 1, 10, 0, 0);
      Duration monotonicTime = Duration.zero;
      bool jumpDetected = false;

      final detector = ClockJumpDetector(
        nowProvider: () => currentNow,
        monotonicNow: () => monotonicTime,
        threshold: const Duration(minutes: 1),
        onJumpDetected: (_) => jumpDetected = true,
      );

      // Baseline → jump state → reset → two normal ticks.
      detector.checkAndReport(currentNow);
      currentNow = currentNow.add(const Duration(hours: 2));
      monotonicTime += const Duration(seconds: 1);
      detector.reset();

      detector.checkAndReport(currentNow); // first check after reset (baseline)
      currentNow = currentNow.add(const Duration(seconds: 30));
      monotonicTime += const Duration(seconds: 30);
      final result = detector.checkAndReport(currentNow); // normal drift
      expect(result, false);
      expect(jumpDetected, false);
      detector.dispose();
    });
  });

  group('ClockJumpDetector (Auto-sampling timer)', () {
    test('timer samples automatically and detects jump', () {
      fakeAsync((async) {
        DateTime currentNow = DateTime.utc(2024, 1, 1, 10, 0, 0);
        Duration currentMonotonic = Duration.zero;
        bool jumpDetected = false;

        final detector = ClockJumpDetector(
          nowProvider: () => currentNow,
          monotonicNow: () => currentMonotonic,
          threshold: const Duration(minutes: 1),
          onJumpDetected: (_) => jumpDetected = true,
        );

        // First 5-second tick: establishes baseline.
        async.elapse(const Duration(seconds: 5));
        expect(jumpDetected, false);

        // Wall clock jumps 2 hours, monotonic barely moves.
        currentNow = currentNow.add(const Duration(hours: 2));
        currentMonotonic += const Duration(seconds: 1);

        // Second 5-second tick: divergence exceeds threshold.
        async.elapse(const Duration(seconds: 5));
        expect(jumpDetected, true);

        detector.dispose();
      });
    });

    test('dispose cancels timer so no further samples fire', () {
      fakeAsync((async) {
        DateTime currentNow = DateTime.utc(2024, 1, 1, 10, 0, 0);
        Duration currentMonotonic = Duration.zero;
        int jumpCount = 0;

        final detector = ClockJumpDetector(
          nowProvider: () => currentNow,
          monotonicNow: () => currentMonotonic,
          threshold: const Duration(minutes: 1),
          onJumpDetected: (_) => jumpCount++,
        );

        // First tick: establishes baseline.
        async.elapse(const Duration(seconds: 5));

        detector.dispose();

        // Introduce a jump after dispose.
        currentNow = currentNow.add(const Duration(hours: 2));
        currentMonotonic += const Duration(seconds: 1);

        // Timer must not fire anymore.
        async.elapse(const Duration(seconds: 10));
        expect(jumpCount, 0);
      });
    });

    test('no jump reported for steady stream of normal ticks', () {
      fakeAsync((async) {
        DateTime currentNow = DateTime.utc(2024, 1, 1, 10, 0, 0);
        Duration currentMonotonic = Duration.zero;
        bool jumpDetected = false;

        final detector = ClockJumpDetector(
          nowProvider: () => currentNow,
          monotonicNow: () => currentMonotonic,
          threshold: const Duration(minutes: 1),
          onJumpDetected: (_) => jumpDetected = true,
        );

        // Advance both clocks in lock-step for 1 minute (12 ticks).
        for (int i = 0; i < 12; i++) {
          currentNow = currentNow.add(const Duration(seconds: 5));
          currentMonotonic += const Duration(seconds: 5);
          async.elapse(const Duration(seconds: 5));
        }

        expect(jumpDetected, false);
        detector.dispose();
      });
    });
  });
}
