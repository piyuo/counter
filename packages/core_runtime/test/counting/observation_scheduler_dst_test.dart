import 'package:core_runtime/observation/frame_gap_tracker.dart';
import 'package:core_runtime/observation/observation_scheduler.dart';
import 'package:flutter_test/flutter_test.dart';

final _firstPass = DateTime.utc(2026, 11, 1, 8, 32);
final _secondPass = DateTime.utc(2026, 11, 1, 9, 32);
final _beforeGap = DateTime.utc(2026, 3, 8, 9, 58);
final _afterGap = DateTime.utc(2026, 3, 8, 10, 3);

final _tzHasFallBack =
    _firstPass.toLocal().hour == 1 &&
    _secondPass.toLocal().hour == 1 &&
    _firstPass.toLocal().timeZoneOffset != _secondPass.toLocal().timeZoneOffset;

const _needsTz = 'Run with TZ=America/Los_Angeles to exercise DST fall-back.';
const _needsSpringTz = 'Run with TZ=America/Los_Angeles to exercise DST spring-forward.';

ObservationScheduler _scheduler({
  required DateTime Function() now,
  required DateTime t0,
  required List<DateTime> starts,
  required List<Duration> startMissing,
  required void Function() onEnd,
}) {
  final scheduler = ObservationScheduler(
    nowProvider: now,
    monotonicNowProvider: () => now().difference(t0),
    onWindowStart: (start, missing) {
      starts.add(start);
      startMissing.add(missing);
    },
    onWindowEnd: (_) => onEnd(),
  );
  addTearDown(scheduler.dispose);
  return scheduler;
}

void main() {
  group('createStartLocal', () {
    test('returns the 5-minute window that contains now', () {
      final instants = [
        DateTime.utc(2026, 6, 1, 12, 3, 27),
        DateTime.utc(2026, 6, 1, 12, 5),
        DateTime.utc(2026, 6, 1, 12, 9, 59, 999),
        _firstPass,
        _secondPass,
      ];
      for (final now in instants) {
        final start = ObservationScheduler.createStartLocal(now);
        final into = now.difference(start);
        expect(into >= Duration.zero, isTrue, reason: 'start after now for $now');
        expect(into < const Duration(minutes: 5), isTrue, reason: 'now outside window for $now');
        expect(start.toLocal().minute % 5, 0);
        expect(start.toLocal().second, 0);
      }
    });

    test('the two passes of the repeated hour get different instants', () {
      final firstStart = ObservationScheduler.createStartLocal(_firstPass);
      final secondStart = ObservationScheduler.createStartLocal(_secondPass);
      expect(firstStart.isAtSameMomentAs(secondStart), isFalse);
    }, skip: _tzHasFallBack ? null : _needsTz);
  });

  group('DST fall-back', () {
    test('opens one window per pass and rolls once between passes', () {
      var clock = _firstPass;
      final starts = <DateTime>[];
      final missing = <Duration>[];
      var ends = 0;
      final scheduler = _scheduler(
        now: () => clock,
        t0: _firstPass,
        starts: starts,
        startMissing: missing,
        onEnd: () => ends++,
      );

      for (var index = 0; index < 5; index++) {
        clock = _firstPass.add(Duration(seconds: index * 10));
        scheduler.ensureWindowActive();
      }
      expect(starts.length, 1);

      for (var index = 0; index < 5; index++) {
        clock = _secondPass.add(Duration(seconds: index * 10));
        scheduler.ensureWindowActive();
      }
      expect(starts.length, 2, reason: 'a window storm means the start time is ambiguous');
      expect(ends, 1);
      expect(scheduler.windowStartUtc, DateTime.utc(2026, 11, 1, 9, 30));
    }, skip: _tzHasFallBack ? null : _needsTz);
  });

  group('DST spring-forward', () {
    final tzHasSpringForward = _beforeGap.toLocal().hour == 1 && _afterGap.toLocal().hour == 3;

    test('skipped hour opens no placeholder windows', () {
      var clock = _beforeGap;
      final starts = <DateTime>[];
      final missing = <Duration>[];
      var ends = 0;
      final scheduler = _scheduler(
        now: () => clock,
        t0: _beforeGap,
        starts: starts,
        startMissing: missing,
        onEnd: () => ends++,
      );

      scheduler.ensureWindowActive();
      clock = _afterGap;
      scheduler.ensureWindowActive();

      expect(starts.length, 2);
      expect(ends, 1);
      expect(scheduler.windowStartUtc, DateTime.utc(2026, 3, 8, 10));
    }, skip: tzHasSpringForward ? null : _needsSpringTz);
  });

  group('missing-at-start tolerance', () {
    test('start delay under the jitter threshold is not charged as missing', () {
      final clock = DateTime(2026, 6, 1, 12, 0, 2, 500);
      final starts = <DateTime>[];
      final missing = <Duration>[];
      final scheduler = _scheduler(now: () => clock, t0: clock, starts: starts, startMissing: missing, onEnd: () {});

      scheduler.ensureWindowActive();
      expect(missing.single, Duration.zero);
    });

    test('start delay at exactly the jitter threshold is charged as missing', () {
      final clock = DateTime(2026, 6, 1, 12, 0, 3);
      final starts = <DateTime>[];
      final missing = <Duration>[];
      final scheduler = _scheduler(now: () => clock, t0: clock, starts: starts, startMissing: missing, onEnd: () {});

      scheduler.ensureWindowActive();
      expect(missing.single, kFrameGapJitterThreshold);
    });
  });
}
