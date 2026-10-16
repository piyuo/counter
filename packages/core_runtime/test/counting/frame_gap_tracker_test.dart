// TOC
// 1. FrameGapTracker tests

import 'package:core_runtime/observation/frame_gap_tracker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('first observation reports no missing time', () {
    final tracker = FrameGapTracker();

    expect(tracker.consumeGap(DateTime.utc(2026, 1, 1, 10, 0, 0)), Duration.zero);
  });

  test('sub-threshold jitter is ignored', () {
    final tracker = FrameGapTracker();
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);

    tracker.consumeGap(start);

    expect(tracker.consumeGap(start.add(const Duration(milliseconds: 500))), Duration.zero);
  });

  test('larger gaps are reported exactly', () {
    final tracker = FrameGapTracker();
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);

    tracker.consumeGap(start);

    expect(tracker.consumeGap(start.add(const Duration(seconds: 12))), const Duration(seconds: 12));
  });

  test('an interval of exactly the jitter threshold is missing', () {
    final start = DateTime.utc(2026, 1, 1, 12);
    final tracker = FrameGapTracker()..consumeFrameTiming(start);

    final interval = tracker.consumeFrameTiming(start.add(kFrameGapJitterThreshold));
    expect(interval.missingDuration, kFrameGapJitterThreshold);
    expect(interval.validDuration, Duration.zero);
  });

  test('frame intervals split valid time from missing time', () {
    final tracker = FrameGapTracker();
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);

    final first = tracker.consumeFrameTiming(start);
    expect(first.validDuration, Duration.zero);
    expect(first.missingDuration, Duration.zero);

    final valid = tracker.consumeFrameTiming(start.add(const Duration(milliseconds: 1500)));
    expect(valid.validDuration, const Duration(milliseconds: 1500));
    expect(valid.missingDuration, Duration.zero);

    final missing = tracker.consumeFrameTiming(start.add(const Duration(seconds: 5)));
    expect(missing.validDuration, Duration.zero);
    expect(missing.missingDuration, const Duration(milliseconds: 3500));
  });

  test('advanceTo moves the baseline forward but never backward', () {
    final tracker = FrameGapTracker();
    final start = DateTime.utc(2026, 1, 1, 10);
    final accountedThrough = start.add(const Duration(minutes: 5, seconds: 30));

    tracker.consumeFrameTiming(start);
    tracker.advanceTo(accountedThrough);
    tracker.advanceTo(start.add(const Duration(minutes: 4)));

    final nextFrame = tracker.consumeFrameTiming(accountedThrough);
    expect(nextFrame.previousFrameAt, accountedThrough);
    expect(nextFrame.elapsedDuration, Duration.zero);
    expect(nextFrame.missingDuration, Duration.zero);
  });

  test('advanceTo is a no-op before the first frame', () {
    final start = DateTime.utc(2026, 1, 1, 12);
    final tracker = FrameGapTracker()..advanceTo(start);

    expect(tracker.lastFrameAt, isNull);
  });

  test('time before an advanced baseline is not reported as missing', () {
    final start = DateTime.utc(2026, 1, 1, 12);
    final baseline = start.add(const Duration(minutes: 5));
    final tracker = FrameGapTracker()..consumeFrameTiming(start);
    tracker.advanceTo(baseline);

    final interval = tracker.consumeFrameTiming(baseline.add(const Duration(seconds: 1)));
    expect(interval.missingDuration, Duration.zero);
    expect(interval.validDuration, const Duration(seconds: 1));
  });

  test('an interval at the jitter threshold is missing', () {
    final start = DateTime.utc(2026, 1, 1, 12);
    final tracker = FrameGapTracker()..consumeFrameTiming(start);

    final interval = tracker.consumeFrameTiming(start.add(kFrameGapJitterThreshold));
    expect(interval.missingDuration, kFrameGapJitterThreshold);
    expect(interval.validDuration, Duration.zero);
  });

  test('non-positive frame intervals are neither valid nor missing', () {
    final tracker = FrameGapTracker();
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);

    tracker.consumeFrameTiming(start);
    final zero = tracker.consumeFrameTiming(start);
    expect(zero.validDuration, Duration.zero);
    expect(zero.missingDuration, Duration.zero);

    final negative = tracker.consumeFrameTiming(start.subtract(const Duration(seconds: 1)));
    expect(negative.validDuration, Duration.zero);
    expect(negative.missingDuration, Duration.zero);
  });

  test('reset clears state so next observation reports no missing time', () {
    final tracker = FrameGapTracker();
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);

    tracker.consumeGap(start);
    tracker.reset();

    expect(tracker.consumeGap(start.add(const Duration(minutes: 5))), Duration.zero);
  });
}
