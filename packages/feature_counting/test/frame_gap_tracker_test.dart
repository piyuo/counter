// TOC
// 1. FrameGapTracker tests

import 'package:feature_counting/src/frame_gap_tracker.dart';
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

  test('reset clears state so next observation reports no missing time', () {
    final tracker = FrameGapTracker();
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);

    tracker.consumeGap(start);
    tracker.reset();

    expect(tracker.consumeGap(start.add(const Duration(minutes: 5))), Duration.zero);
  });
}
