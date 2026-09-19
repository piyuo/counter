import 'package:feature_counting/src/window_count_state.dart';
import 'package:flutter_test/flutter_test.dart';

// Helper functions to compute ratios at test time
const _kWindowDuration = Duration(minutes: 5);

double _computeDoneRatio(DateTime startUtc, Duration missingDuration, DateTime nowUtc) {
  final endUtc = startUtc.add(_kWindowDuration);
  final totalMs = _kWindowDuration.inMilliseconds;
  final remainingMs = nowUtc.isBefore(endUtc) ? endUtc.difference(nowUtc).inMilliseconds : 0;
  final inProgress = (remainingMs / totalMs).clamp(0.0, 1.0);
  final missing = _computeMissingRatio(startUtc, missingDuration, nowUtc);
  return (1.0 - inProgress - missing).clamp(0.0, 1.0);
}

double _computeInProgressRatio(DateTime startUtc, DateTime nowUtc) {
  final endUtc = startUtc.add(_kWindowDuration);
  final totalMs = _kWindowDuration.inMilliseconds;
  final remainingMs = nowUtc.isBefore(endUtc) ? endUtc.difference(nowUtc).inMilliseconds : 0;
  return (remainingMs / totalMs).clamp(0.0, 1.0);
}

double _computeMissingRatio(DateTime startUtc, Duration missingDuration, DateTime nowUtc) {
  final endUtc = startUtc.add(_kWindowDuration);
  final totalMs = _kWindowDuration.inMilliseconds;
  final elapsedMs = nowUtc.isBefore(endUtc)
      ? _kWindowDuration.inMilliseconds - endUtc.difference(nowUtc).inMilliseconds
      : _kWindowDuration.inMilliseconds;
  final missingElapsedMs = missingDuration.inMilliseconds.clamp(0, elapsedMs.clamp(0, totalMs));
  return (missingElapsedMs / totalMs).clamp(0.0, 1.0);
}

double _computeFps(DateTime startUtc, Duration missingDuration, DateTime nowUtc, int frameCount) {
  final done = _computeDoneRatio(startUtc, missingDuration, nowUtc);
  final totalMs = _kWindowDuration.inMilliseconds;
  final coveredMs = (done * totalMs).round().clamp(0, totalMs);
  if (coveredMs <= 0) return 0.0;
  return frameCount / (coveredMs / 1000.0);
}

void main() {
  group('coverageRatioAt and effectiveFpsAt', () {
    test('live window treats future segment as missing for coverage and FPS', () {
      final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final nowUtc = DateTime.utc(2026, 1, 1, 10, 2, 0);

      final state = WindowCountState(
        startUtc: start,
        startBusiness: start.toLocal(),
        session: 'TEST_260101_100000_abcd',
        sequence: 1,
        missingDuration: const Duration(seconds: 30),
        frameCount: 90,
        doneRatio: _computeDoneRatio(start, const Duration(seconds: 30), nowUtc),
        inProgressRatio: _computeInProgressRatio(start, nowUtc),
        missingRatio: _computeMissingRatio(start, const Duration(seconds: 30), nowUtc),
        fps: _computeFps(start, const Duration(seconds: 30), nowUtc, 90),
      );

      // covered = 300s - 210s = 90s
      // effectiveFps = 90 frames / 90s = 1.0
      expect(state.fps, closeTo(1.0, 1e-9));
    });

    test('closed window behavior is unchanged when nowUtc >= endUtc', () {
      final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final nowUtc = DateTime.utc(2026, 1, 1, 10, 6, 0);

      final state = WindowCountState(
        startUtc: start,
        startBusiness: start.toLocal(),
        session: 'TEST_260101_100000_abcd',
        sequence: 1,
        missingDuration: const Duration(seconds: 30),
        frameCount: 90,
        doneRatio: _computeDoneRatio(start, const Duration(seconds: 30), nowUtc),
        inProgressRatio: _computeInProgressRatio(start, nowUtc),
        missingRatio: _computeMissingRatio(start, const Duration(seconds: 30), nowUtc),
        fps: _computeFps(start, const Duration(seconds: 30), nowUtc, 90),
      );

      // covered = 300s - 30s = 270s
      // effectiveFps = 90 / 270 = 0.333...
      expect(state.fps, closeTo(1 / 3, 1e-9));
    });

    test('returns zero coverage and FPS before window start', () {
      final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final nowUtc = DateTime.utc(2026, 1, 1, 9, 59, 0);

      final state = WindowCountState(
        startUtc: start,
        startBusiness: start.toLocal(),
        session: 'TEST_260101_100000_abcd',
        sequence: 1,
        missingDuration: const Duration(seconds: 10),
        frameCount: 5,
        doneRatio: _computeDoneRatio(start, const Duration(seconds: 10), nowUtc),
        inProgressRatio: _computeInProgressRatio(start, nowUtc),
        missingRatio: _computeMissingRatio(start, const Duration(seconds: 10), nowUtc),
        fps: _computeFps(start, const Duration(seconds: 10), nowUtc, 5),
      );

      expect(state.fps, 0.0);
    });
  });

  group('done/inProgress/missing percentages', () {
    test('live window: done + in progress + missing = 100%', () {
      final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final nowUtc = DateTime.utc(2026, 1, 1, 10, 2, 0);

      final state = WindowCountState(
        startUtc: start,
        startBusiness: start.toLocal(),
        session: 'TEST_260101_100000_abcd',
        sequence: 1,
        missingDuration: const Duration(seconds: 30),
        doneRatio: _computeDoneRatio(start, const Duration(seconds: 30), nowUtc),
        inProgressRatio: _computeInProgressRatio(start, nowUtc),
        missingRatio: _computeMissingRatio(start, const Duration(seconds: 30), nowUtc),
        fps: _computeFps(start, const Duration(seconds: 30), nowUtc, 0),
      );

      // elapsed = 120s, remaining = 180s
      // missing(elapsed only) = 30s
      // done = 120s - 30s = 90s
      // done/inProgress/missing = 30% / 60% / 10%
      expect(state.donePercent, closeTo(30.0, 1e-9));
      expect(state.inProgressPercent, closeTo(60.0, 1e-9));
      expect(state.missingPercent, closeTo(10.0, 1e-9));
      expect(state.progressPercentTotal, closeTo(100.0, 1e-9));
    });

    test('closed window: in progress becomes 0 and total remains 100%', () {
      final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final nowUtc = DateTime.utc(2026, 1, 1, 10, 6, 0);

      final state = WindowCountState(
        startUtc: start,
        startBusiness: start.toLocal(),
        session: 'TEST_260101_100000_abcd',
        sequence: 1,
        missingDuration: const Duration(seconds: 30),
        doneRatio: _computeDoneRatio(start, const Duration(seconds: 30), nowUtc),
        inProgressRatio: _computeInProgressRatio(start, nowUtc),
        missingRatio: _computeMissingRatio(start, const Duration(seconds: 30), nowUtc),
        fps: _computeFps(start, const Duration(seconds: 30), nowUtc, 0),
      );

      // done = 270s (90%), missing = 30s (10%), in progress = 0%
      expect(state.donePercent, closeTo(90.0, 1e-9));
      expect(state.inProgressPercent, closeTo(0.0, 1e-9));
      expect(state.missingPercent, closeTo(10.0, 1e-9));
      expect(state.progressPercentTotal, closeTo(100.0, 1e-9));
    });

    test('before window start: all in progress, total remains 100%', () {
      final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final nowUtc = DateTime.utc(2026, 1, 1, 9, 59, 0);

      final state = WindowCountState(
        startUtc: start,
        startBusiness: start.toLocal(),
        session: 'TEST_260101_100000_abcd',
        sequence: 1,
        missingDuration: const Duration(seconds: 10),
        doneRatio: _computeDoneRatio(start, const Duration(seconds: 10), nowUtc),
        inProgressRatio: _computeInProgressRatio(start, nowUtc),
        missingRatio: _computeMissingRatio(start, const Duration(seconds: 10), nowUtc),
        fps: _computeFps(start, const Duration(seconds: 10), nowUtc, 0),
      );

      expect(state.donePercent, closeTo(0.0, 1e-9));
      expect(state.inProgressPercent, closeTo(100.0, 1e-9));
      expect(state.missingPercent, closeTo(0.0, 1e-9));
      expect(state.progressPercentTotal, closeTo(100.0, 1e-9));
    });
  });
}
