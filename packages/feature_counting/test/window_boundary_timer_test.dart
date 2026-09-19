import 'package:fake_async/fake_async.dart';
import 'package:feature_counting/src/window_boundary_timer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WindowBoundaryTimer', () {
    test('scheduleNext calculates delay to next 5-minute boundary', () {
      fakeAsync((async) {
        DateTime now = DateTime.utc(2024, 1, 1, 10, 2, 30);
        int tickCount = 0;

        final timer = WindowBoundaryTimer(now: () => now, onBoundaryTick: () => tickCount++);

        timer.scheduleNext(now: now);

        // Next boundary is 10:05 (2:30 away)
        async.elapse(const Duration(minutes: 2, seconds: 29));
        expect(tickCount, 0, reason: "Should not tick before boundary");

        async.elapse(const Duration(seconds: 2));
        expect(tickCount, 1, reason: "Should tick at boundary");

        timer.dispose();
      });
    });

    test('automatically reschedules after each boundary tick', () {
      fakeAsync((async) {
        DateTime now = DateTime.utc(2024, 1, 1, 10, 0, 0);
        int tickCount = 0;

        final timer = WindowBoundaryTimer(now: () => now, onBoundaryTick: () => tickCount++);

        timer.scheduleNext(now: now);

        // First tick at 10:05
        async.elapse(const Duration(minutes: 5));
        expect(tickCount, 1);

        now = now.add(const Duration(minutes: 5));

        // Second tick at 10:10
        async.elapse(const Duration(minutes: 5));
        expect(tickCount, 2);

        now = now.add(const Duration(minutes: 5));

        // Third tick at 10:15
        async.elapse(const Duration(minutes: 5));
        expect(tickCount, 3);

        timer.dispose();
      });
    });

    test('handles mid-boundary scheduling correctly', () {
      fakeAsync((async) {
        DateTime now = DateTime.utc(2024, 1, 1, 10, 3, 45);
        int tickCount = 0;

        final timer = WindowBoundaryTimer(now: () => now, onBoundaryTick: () => tickCount++);

        timer.scheduleNext(now: now);

        // Next boundary is 10:05 (1:15 away)
        async.elapse(const Duration(minutes: 1, seconds: 14));
        expect(tickCount, 0);

        async.elapse(const Duration(seconds: 2));
        expect(tickCount, 1);

        timer.dispose();
      });
    });

    test('dispose cancels pending timer', () {
      fakeAsync((async) {
        DateTime now = DateTime.utc(2024, 1, 1, 10, 0, 0);
        int tickCount = 0;

        final timer = WindowBoundaryTimer(now: () => now, onBoundaryTick: () => tickCount++);

        timer.scheduleNext(now: now);
        timer.dispose();

        // Even after elapsing to the boundary, tick should not fire
        async.elapse(const Duration(minutes: 5));
        expect(tickCount, 0);
      });
    });

    test('snaps to correct 5-minute boundary when called mid-interval', () {
      fakeAsync((async) {
        DateTime now = DateTime.utc(2024, 1, 1, 10, 7, 30);
        int tickCount = 0;

        final timer = WindowBoundaryTimer(now: () => now, onBoundaryTick: () => tickCount++);

        // Current minute is 7, snapped to 5 (7 - (7 % 5) = 5)
        // Next boundary should be 10:10
        timer.scheduleNext(now: now);

        async.elapse(const Duration(minutes: 2, seconds: 30));
        expect(tickCount, 1);

        timer.dispose();
      });
    });

    test('handles boundary times exactly at minute 0, 5, 10, etc', () {
      fakeAsync((async) {
        DateTime now = DateTime.utc(2024, 1, 1, 10, 5, 0); // Exactly at boundary
        int tickCount = 0;

        final timer = WindowBoundaryTimer(now: () => now, onBoundaryTick: () => tickCount++);

        timer.scheduleNext(now: now);

        // Next boundary is 10:10
        async.elapse(const Duration(minutes: 5));
        expect(tickCount, 1);

        timer.dispose();
      });
    });

    test('reschedules correctly across hour boundaries', () {
      fakeAsync((async) {
        DateTime now = DateTime.utc(2024, 1, 1, 10, 57, 0);
        int tickCount = 0;

        final timer = WindowBoundaryTimer(now: () => now, onBoundaryTick: () => tickCount++);

        timer.scheduleNext(now: now);

        // Next boundary is 11:00
        async.elapse(const Duration(minutes: 3));
        expect(tickCount, 1);

        now = now.add(const Duration(minutes: 3));

        // Next boundary is 11:05
        async.elapse(const Duration(minutes: 5));
        expect(tickCount, 2);

        timer.dispose();
      });
    });
  });
}
