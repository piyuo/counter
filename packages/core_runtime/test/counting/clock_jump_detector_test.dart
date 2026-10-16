import 'package:core_runtime/observation/clock_jump_detector.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClockJumpDetector (Manual checkAndReport)', () {
    late DateTime wall;
    late Duration monotonic;
    late List<DateTime> jumps;
    late ClockJumpDetector detector;

    setUp(() {
      wall = DateTime.utc(2026, 1, 1, 12);
      monotonic = Duration.zero;
      jumps = [];
      detector = ClockJumpDetector(
        nowProvider: () => wall,
        monotonicNow: () => monotonic,
        threshold: const Duration(minutes: 1),
        onJumpDetected: jumps.add,
      );
      addTearDown(detector.dispose);
    });

    test('the first sample only sets the baseline', () {
      expect(detector.checkAndReport(wall), isFalse);
      expect(jumps, isEmpty);
    });

    test('normal drift is ignored', () {
      detector.checkAndReport(wall);
      wall = wall.add(const Duration(seconds: 5));
      monotonic += const Duration(seconds: 5, milliseconds: 200);
      expect(detector.checkAndReport(wall), isFalse);
    });

    test('divergence just under the threshold is ignored, at the threshold fires', () {
      detector.checkAndReport(wall);
      wall = wall.add(const Duration(seconds: 59));
      expect(detector.checkAndReport(wall), isFalse);

      wall = wall.add(const Duration(seconds: 60));
      expect(detector.checkAndReport(wall), isTrue);
      expect(jumps, [wall]);
    });

    test('a backward jump fires', () {
      detector.checkAndReport(wall);
      wall = wall.subtract(const Duration(hours: 2));
      monotonic += const Duration(seconds: 5);
      expect(detector.checkAndReport(wall), isTrue);
    });

    test('the baseline moves after a jump so it fires once', () {
      detector.checkAndReport(wall);
      wall = wall.add(const Duration(hours: 1));
      expect(detector.checkAndReport(wall), isTrue);
      expect(detector.checkAndReport(wall), isFalse);
    });

    test('reset forgets the baseline', () {
      detector.checkAndReport(wall);
      detector.reset();
      wall = wall.add(const Duration(hours: 1));
      expect(detector.checkAndReport(wall), isFalse, reason: 'becomes the new baseline');
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
