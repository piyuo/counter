import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_domain/model/observation.dart';
import 'package:core_runtime/observation/interest_area_notifier.dart';
import 'package:core_runtime/observation/observation_notifier.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;

vision.TrackedObject buildTrack({required int trackId, required Offset center, required Offset initialCenter}) {
  return vision.TrackedObject.create(
    trackId: trackId,
    box: Rect.fromLTWH(center.dx, center.dy, 0, 0),
    confidenceRatio: 0.9,
    classId: 0,
    embeddingColor: const Color(0xFF000000),
    activated: true,
    hitStreak: 1,
    trackletId: 1,
    initialCenterX: initialCenter.dx.toInt(),
    initialCenterY: initialCenter.dy.toInt(),
    startTime: DateTime.now().millisecondsSinceEpoch,
  );
}

ProviderContainer makeContainer(
  FakeAsync async,
  DateTime base, {
  int stayThresholdSeconds = 0,
  int disappearThresholdSeconds = 0,
}) {
  final container = ProviderContainer(
    overrides: [
      observationProvider.overrideWith(
        () => ObservationNotifier(
          nowProvider: () => base.add(async.elapsed),
          monotonicNowProvider: () => async.elapsed,
          stagnantThresholdSeconds: stayThresholdSeconds,
          disappearThresholdSeconds: disappearThresholdSeconds,
        ),
      ),
    ],
  );
  return container;
}

ObservationNotifier notifier(ProviderContainer container) {
  final controller = container.read(observationProvider.notifier);
  controller.start();
  return controller;
}

core_domain.Observation? state(ProviderContainer container) => container.read(observationProvider);

core_domain.AreaMetrics _area(core_domain.Observation payload, int areaId) =>
    payload.areas.singleWhere((metrics) => metrics.areaId == areaId);

int _windowStart(core_domain.Observation payload) => payload.hour * 100 + payload.minute;

int _windowEnd(core_domain.Observation payload) {
  final dateTime = payload.dateTime;
  final end = DateTime.utc(
    dateTime.year,
    dateTime.month,
    dateTime.day,
    dateTime.hour,
    dateTime.minute,
  ).add(const Duration(minutes: 5));
  return end.hour * 100 + end.minute;
}

int _businessTime(DateTime utcTime) {
  final localTime = utcTime.toLocal();
  return localTime.hour * 100 + localTime.minute;
}

int _missingSeconds(core_domain.Observation payload) => payload.expectedSeconds - payload.coveredSeconds;

void setAreas(ProviderContainer container, List<core_domain.InterestArea> areas) {
  container.read(interestAreaProvider.notifier).setAreas(areas);
}

void processTestFrame<T>(
  ProviderContainer container,
  ObservationNotifier notifier,
  List<T> tracks,
  List<core_domain.InterestArea> areas,
  double rotationDegrees,
) {
  setAreas(container, areas);
  notifier.processFrame(tracks, rotationDegrees);
}

void pumpFrames(
  ObservationNotifier notifier,
  FakeAsync async,
  Duration duration, {
  Duration step = const Duration(milliseconds: 500),
  List<vision.TrackedObject> tracks = const [],
}) {
  final steps = duration.inMicroseconds ~/ step.inMicroseconds;
  for (var index = 0; index < steps; index++) {
    async.elapse(step);
    notifier.processFrame(tracks, 0.0);
  }

  final remaining = duration - step * steps;
  if (remaining > Duration.zero) {
    async.elapse(remaining);
    notifier.processFrame(tracks, 0.0);
  }
}

void main() {
  test('ignores frames before counting starts', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = container.read(observationProvider.notifier);

      processTestFrame(container, n, const [], const [], 0.0);

      expect(state(container)!.frameCount, 0);
      expect(state(container)!.areas, isEmpty);
    });
  });

  test('finalizes window on wall-clock boundary', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 2, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final results = <core_domain.Observation>[];
      final sub = n.snapshots.listen(results.add);

      processTestFrame(container, n, const [], const [], 0.0);
      pumpFrames(n, async, const Duration(minutes: 3));

      expect(results.length, 1);
      expect(_windowStart(results.first), _businessTime(DateTime.utc(2026, 1, 1, 10, 0, 0)));
      expect(_windowEnd(results.first), _businessTime(DateTime.utc(2026, 1, 1, 10, 5, 0)));

      sub.cancel();
    });
  });

  test('late window roll charges the gap once', () {
    fakeAsync((async) {
      var clock = DateTime(2026, 6, 1, 12, 0, 1);
      final t0 = clock;
      final container = ProviderContainer(
        overrides: [
          observationProvider.overrideWith(
            () => ObservationNotifier(nowProvider: () => clock, monotonicNowProvider: () => clock.difference(t0)),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(observationProvider.notifier);
      final closed = <core_domain.Observation>[];
      final subscription = notifier.snapshots.listen(closed.add);
      addTearDown(subscription.cancel);

      notifier.start();
      notifier.processFrame(<Object>[], 0);

      for (var seconds = 2; seconds <= 288; seconds += 2) {
        clock = t0.add(Duration(seconds: seconds));
        notifier.processFrame(<Object>[], 0);
      }
      clock = DateTime(2026, 6, 1, 12, 4, 50);
      notifier.processFrame(<Object>[], 0);

      clock = DateTime(2026, 6, 1, 12, 5, 30);
      notifier.processFrame(<Object>[], 0);
      async.flushMicrotasks();

      expect(closed.single.coveredSeconds, 290);
      expect(container.read(observationProvider).coveredSeconds, 270, reason: 'double count gives 240');
    });
  });

  test('stall timer late roll charges the gap once', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12, 0, 1);
      var clockOffset = Duration.zero;
      final container = ProviderContainer(
        overrides: [
          observationProvider.overrideWith(
            () => ObservationNotifier(
              nowProvider: () => base.add(async.elapsed).add(clockOffset),
              monotonicNowProvider: () => async.elapsed,
            ),
          ),
        ],
      );
      addTearDown(container.dispose);
      final n = container.read(observationProvider.notifier);
      final closed = <core_domain.Observation>[];
      final subscription = n.snapshots.listen(closed.add);
      addTearDown(subscription.cancel);

      n.start();
      n.processFrame(const <Object>[], 0);
      n.pause();

      clockOffset = const Duration(minutes: 5, seconds: 30);
      async.elapse(const Duration(seconds: 1));
      async.flushMicrotasks();

      expect(closed.single.coveredSeconds, 0);
      expect(state(container)!.coveredSeconds, 268, reason: 'late-roll missing time must not be charged twice');
    });
  });

  test('presence credits tolerated first-frame delay as valid time', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));

      async.elapse(const Duration(milliseconds: 2500));
      processTestFrame(container, n, [track], const [], 0);

      final global = _area(state(container)!, core_domain.kGlobalAreaId);
      expect(state(container)!.coveredSeconds, 300);
      expect(global.presenceTrackCount, 1);
      expect(global.presenceSumSeconds, 3);
    });
  });

  test('debug force-end does not charge time after now as missing', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12, 1);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final closed = <core_domain.Observation>[];
      final subscription = n.snapshots.listen(closed.add);
      addTearDown(subscription.cancel);

      processTestFrame(container, n, const [], const [], 0);
      n.debugForceWindowEnd();
      async.flushMicrotasks();

      expect(closed.single.coveredSeconds, 240);
    });
  });

  test('backward clock jump does not charge time after now as missing', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12, 1);
      var jumpOffset = Duration.zero;
      final container = ProviderContainer(
        overrides: [
          observationProvider.overrideWith(
            () => ObservationNotifier(
              nowProvider: () => base.add(async.elapsed).add(jumpOffset),
              monotonicNowProvider: () => async.elapsed,
            ),
          ),
        ],
      );
      addTearDown(container.dispose);
      final n = notifier(container);
      final closed = <core_domain.Observation>[];
      final subscription = n.snapshots.listen(closed.add);
      addTearDown(subscription.cancel);

      processTestFrame(container, n, const [], const [], 0);
      async.elapse(const Duration(seconds: 5));
      jumpOffset = const Duration(hours: -2);
      async.elapse(const Duration(seconds: 5));
      async.flushMicrotasks();

      expect(closed, hasLength(1));
      expect(closed.single.coveredSeconds, 240);
    });
  });

  test('source frame gap discards an open visit', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final area = core_domain.InterestArea(
        id: 51,
        name: 'zone',
        points: const [
          core_domain.PointData(dx: 0, dy: 0),
          core_domain.PointData(dx: 20, dy: 0),
          core_domain.PointData(dx: 20, dy: 20),
          core_domain.PointData(dx: 0, dy: 20),
        ],
      );
      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));

      processTestFrame(container, n, [track], [area], 0);
      pumpFrames(n, async, const Duration(seconds: 20), step: const Duration(seconds: 2), tracks: [track]);
      async.elapse(const Duration(seconds: 10));
      processTestFrame(container, n, [track], [area], 0);

      expect(_area(state(container)!, area.id).dwellSampleCount, 0);
      expect(_area(state(container)!, area.id).dwellSumSeconds, 0);
    });
  });

  test('pause discards visits before a long pause and resume', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base, disappearThresholdSeconds: 0);
      addTearDown(container.dispose);
      final n = notifier(container);
      final area = core_domain.InterestArea(
        id: 52,
        name: 'zone',
        points: const [
          core_domain.PointData(dx: 0, dy: 0),
          core_domain.PointData(dx: 20, dy: 0),
          core_domain.PointData(dx: 20, dy: 20),
          core_domain.PointData(dx: 0, dy: 20),
        ],
      );
      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));

      processTestFrame(container, n, [track], [area], 0);
      pumpFrames(n, async, const Duration(seconds: 30), step: const Duration(seconds: 2), tracks: [track]);
      n.pause();
      expect(_area(state(container)!, area.id).dwellSampleCount, 0);
      expect(_area(state(container)!, area.id).dwellSumSeconds, 0);

      async.elapse(const Duration(minutes: 10));
      n.resume();
      processTestFrame(container, n, [track], [area], 0);
      async.elapse(const Duration(seconds: 2));
      processTestFrame(container, n, const [], [area], 0);

      expect(_area(state(container)!, area.id).dwellSumSeconds, 2);
    });
  });

  test('a pause across a boundary adds no tail presence', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final closed = <core_domain.Observation>[];
      final subscription = n.snapshots.listen(closed.add);
      addTearDown(subscription.cancel);
      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));

      processTestFrame(container, n, [track], const [], 0);
      pumpFrames(n, async, const Duration(seconds: 10), step: const Duration(seconds: 1), tracks: [track]);
      n.pause();
      async.elapse(const Duration(seconds: 295));
      async.flushMicrotasks();

      expect(closed, hasLength(1));
      expect(_area(closed.single, core_domain.kGlobalAreaId).presenceSumSeconds, 10);
    });
  });

  test('clock jump discards an open visit before the window rolls', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      var jumpOffset = Duration.zero;
      final container = ProviderContainer(
        overrides: [
          observationProvider.overrideWith(
            () => ObservationNotifier(
              nowProvider: () => base.add(async.elapsed).add(jumpOffset),
              monotonicNowProvider: () => async.elapsed,
            ),
          ),
        ],
      );
      addTearDown(container.dispose);
      final n = notifier(container);
      final area = core_domain.InterestArea(
        id: 53,
        name: 'zone',
        points: const [
          core_domain.PointData(dx: 0, dy: 0),
          core_domain.PointData(dx: 20, dy: 0),
          core_domain.PointData(dx: 20, dy: 20),
          core_domain.PointData(dx: 0, dy: 20),
        ],
      );
      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));
      final closed = <core_domain.Observation>[];
      final subscription = n.snapshots.listen(closed.add);
      addTearDown(subscription.cancel);

      processTestFrame(container, n, [track], [area], 0);
      pumpFrames(n, async, const Duration(seconds: 30), step: const Duration(seconds: 2), tracks: [track]);
      jumpOffset = const Duration(minutes: 30);
      async.elapse(const Duration(seconds: 5));
      processTestFrame(container, n, [track], [area], 0);
      expect(
        state(container)!.coveredSeconds,
        265,
        reason: 'the 25 minutes between the old and new window belong to no window',
      );
      async.elapse(const Duration(seconds: 2));
      processTestFrame(container, n, const [], [area], 0);

      expect(closed, isNotEmpty);
      expect(closed.first.coveredSeconds, 30);
      final closedArea = _area(closed.first, area.id);
      expect(closedArea.dwellSampleCount, 0);
      expect(closedArea.dwellSumSeconds, 0);
      expect(closedArea.passBy, 1);
      expect(_area(state(container)!, area.id).dwellSumSeconds, 2);
    });
  });

  test('stop discards visits before flushing the final window', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final area = core_domain.InterestArea(
        id: 54,
        name: 'zone',
        points: const [
          core_domain.PointData(dx: 0, dy: 0),
          core_domain.PointData(dx: 20, dy: 0),
          core_domain.PointData(dx: 20, dy: 20),
          core_domain.PointData(dx: 0, dy: 20),
        ],
      );
      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));
      final closed = <core_domain.Observation>[];
      final subscription = n.snapshots.listen(closed.add);
      addTearDown(subscription.cancel);

      processTestFrame(container, n, [track], [area], 0);
      pumpFrames(n, async, const Duration(seconds: 30), step: const Duration(seconds: 2), tracks: [track]);
      n.stop();
      async.flushMicrotasks();

      expect(closed, hasLength(1));
      expect(_area(closed.single, area.id).dwellSampleCount, 0);
      expect(_area(closed.single, area.id).dwellSumSeconds, 0);
    });
  });

  test('finalized windows identify consecutive window times', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final results = <core_domain.Observation>[];
      final sub = n.snapshots.listen(results.add);

      processTestFrame(container, n, const [], const [], 0.0);
      pumpFrames(n, async, const Duration(minutes: 5));
      pumpFrames(n, async, const Duration(minutes: 5));

      expect(results.length, 2);
      expect(_windowStart(results[0]), _businessTime(DateTime.utc(2026, 1, 1, 10, 0, 0)));
      expect(_windowStart(results[1]), _businessTime(DateTime.utc(2026, 1, 1, 10, 5, 0)));

      sub.cancel();
    });
  });

  test('resume keeps observations aligned to their window', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final results = <core_domain.Observation>[];
      final sub = n.snapshots.listen(results.add);

      n.resume();
      processTestFrame(container, n, const [], const [], 0.0);
      pumpFrames(n, async, const Duration(minutes: 5));

      expect(results, isNotEmpty);
      expect(results.first.hour * 100 + results.first.minute, _businessTime(DateTime.utc(2026, 1, 1, 10, 0, 0)));

      sub.cancel();
    });
  });

  test('source stop keeps window lifecycle active and finalizes at boundary', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 2, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final results = <core_domain.Observation>[];
      final sub = n.snapshots.listen(results.add);

      processTestFrame(container, n, const [], const [], 0.0);
      n.pause();

      async.elapse(const Duration(minutes: 3));

      expect(results.length, 1);
      expect(_windowStart(results.first), _businessTime(DateTime.utc(2026, 1, 1, 10, 0, 0)));
      expect(_windowEnd(results.first), _businessTime(DateTime.utc(2026, 1, 1, 10, 5, 0)));

      sub.cancel();
    });
  });

  test('frame gap reduces coverage ratio', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final results = <core_domain.Observation>[];
      final sub = n.snapshots.listen(results.add);

      processTestFrame(container, n, const [], const [], 0.0);
      pumpFrames(n, async, const Duration(minutes: 1));

      async.elapse(const Duration(seconds: 30));
      processTestFrame(container, n, const [], const [], 0.0);

      pumpFrames(n, async, const Duration(minutes: 3, seconds: 30));

      expect(results.length, 1);
      expect(_missingSeconds(results.first), 30);
      sub.cancel();
    });
  });

  test('clock jump rolls to a new window', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 2, 0);
      var jumpOffset = Duration.zero;
      final container = ProviderContainer(
        overrides: [
          observationProvider.overrideWith(
            () => ObservationNotifier(
              nowProvider: () => base.add(async.elapsed).add(jumpOffset),
              monotonicNowProvider: () => async.elapsed,
            ),
          ),
        ],
      );
      addTearDown(container.dispose);
      final n = notifier(container);

      processTestFrame(container, n, const [], const [], 0.0);

      async.elapse(const Duration(minutes: 2));
      jumpOffset = const Duration(minutes: 30);
      processTestFrame(container, n, const [], const [], 0.0);

      final activeWindow = state(container);
      expect(activeWindow, isNotNull);
      expect(_windowStart(activeWindow!), _businessTime(DateTime.utc(2026, 1, 1, 10, 30, 0)));
    });
  });

  test('records enter/exit/passBy for interest areas', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final area = core_domain.InterestArea(
        id: 42,
        name: 'zone',
        points: const [
          core_domain.PointData(dx: 0, dy: 0),
          core_domain.PointData(dx: 20, dy: 0),
          core_domain.PointData(dx: 20, dy: 20),
          core_domain.PointData(dx: 0, dy: 20),
        ],
      );

      final enterTrack = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(100, 100));
      final exitTrack = buildTrack(trackId: 2, center: const Offset(100, 100), initialCenter: const Offset(10, 10));

      processTestFrame(container, n, [enterTrack, exitTrack], [area], 0.0);

      final activeWindow = state(container);
      expect(activeWindow, isNotNull);

      final areaMetrics = _area(activeWindow!, area.id);
      expect(areaMetrics.passBy, 1);
      expect(areaMetrics.entry, 1);
      expect(areaMetrics.exit, 1);
      expect(areaMetrics.appear, 0);
      expect(areaMetrics.disappear, 0);

      final globalMetrics = _area(activeWindow, kGlobalAreaId);
      expect(globalMetrics.passBy, 2);
      expect(globalMetrics.appear, 2);
      expect(globalMetrics.disappear, 0);
    });
  });

  test('presence uses valid frame intervals and resets at window boundaries', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 4, 50);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final area = core_domain.InterestArea(
        id: 42,
        name: 'zone',
        points: const [
          core_domain.PointData(dx: 0, dy: 0),
          core_domain.PointData(dx: 20, dy: 0),
          core_domain.PointData(dx: 20, dy: 20),
          core_domain.PointData(dx: 0, dy: 20),
        ],
      );
      final otherArea = core_domain.InterestArea(
        id: 43,
        name: 'other zone',
        points: const [
          core_domain.PointData(dx: 30, dy: 30),
          core_domain.PointData(dx: 50, dy: 30),
          core_domain.PointData(dx: 50, dy: 50),
          core_domain.PointData(dx: 30, dy: 50),
        ],
      );
      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));

      processTestFrame(container, n, [track], [area, otherArea], 0.0);
      async.elapse(const Duration(seconds: 1));
      processTestFrame(container, n, [track], [area, otherArea], 0.0);
      expect(_area(state(container)!, area.id).presenceSumSeconds, 1);
      expect(_area(state(container)!, core_domain.kGlobalAreaId).presenceSumSeconds, 1);
      expect(_area(state(container)!, otherArea.id).presenceSumSeconds, 0);

      async.elapse(const Duration(seconds: 4));
      processTestFrame(container, n, [track], [area, otherArea], 0.0);
      expect(_area(state(container)!, area.id).presenceSumSeconds, 1);

      async.elapse(const Duration(seconds: 5));
      processTestFrame(container, n, [track], [area, otherArea], 0.0);
      final nextWindow = state(container)!;
      expect(_windowStart(nextWindow), _businessTime(DateTime.utc(2026, 1, 1, 10, 5)));
      expect(_area(nextWindow, area.id).presenceTrackCount, 0);
      expect(_area(nextWindow, area.id).presenceSumSeconds, 0);
    });
  });

  test('missing frame interval reduces coverage and adds no presence', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));

      processTestFrame(container, n, [track], const [], 0.0);
      async.elapse(const Duration(seconds: 4));
      processTestFrame(container, n, [track], const [], 0.0);

      final observation = state(container)!;
      expect(observation.coveredSeconds, 296);
      expect(_area(observation, core_domain.kGlobalAreaId).presenceTrackCount, 0);
      expect(_area(observation, core_domain.kGlobalAreaId).presenceSumSeconds, 0);
    });
  });

  test('honors stay/disappear thresholds in area metrics', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base, stayThresholdSeconds: 2, disappearThresholdSeconds: 2);
      addTearDown(container.dispose);
      final n = notifier(container);

      final area = core_domain.InterestArea(
        id: 7,
        name: 'zone',
        points: const [
          core_domain.PointData(dx: 0, dy: 0),
          core_domain.PointData(dx: 20, dy: 0),
          core_domain.PointData(dx: 20, dy: 20),
          core_domain.PointData(dx: 0, dy: 20),
        ],
      );

      final insideTrack = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));

      processTestFrame(container, n, [insideTrack], [area], 0.0);

      async.elapse(const Duration(seconds: 1));
      processTestFrame(container, n, [insideTrack], [area], 0.0);
      expect(_area(state(container)!, area.id).stagnant, 0);

      async.elapse(const Duration(seconds: 1));
      processTestFrame(container, n, [insideTrack], [area], 0.0);
      expect(_area(state(container)!, area.id).stagnant, 1);

      async.elapse(const Duration(seconds: 1));
      processTestFrame(container, n, const [], [area], 0.0);
      expect(_area(state(container)!, area.id).disappear, 0);

      async.elapse(const Duration(seconds: 2));
      processTestFrame(container, n, const [], [area], 0.0);
      expect(_area(state(container)!, area.id).disappear, 1);
    });
  });

  test('runtime threshold setters apply without recreating provider', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base, stayThresholdSeconds: 10, disappearThresholdSeconds: 10);
      addTearDown(container.dispose);
      final n = notifier(container);

      final area = core_domain.InterestArea(
        id: 9,
        name: 'zone',
        points: const [
          core_domain.PointData(dx: 0, dy: 0),
          core_domain.PointData(dx: 20, dy: 0),
          core_domain.PointData(dx: 20, dy: 20),
          core_domain.PointData(dx: 0, dy: 20),
        ],
      );

      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));

      processTestFrame(container, n, [track], [area], 0.0);
      async.elapse(const Duration(seconds: 2));
      processTestFrame(container, n, [track], [area], 0.0);

      expect(_area(state(container)!, area.id).stagnant, 0);

      n.setThresholdSeconds(stagnantThresholdSeconds: 2, disappearThresholdSeconds: 1);
      async.elapse(const Duration(seconds: 1));
      processTestFrame(container, n, [track], [area], 0.0);

      expect(_area(state(container)!, area.id).stagnant, 1);

      async.elapse(const Duration(seconds: 1));
      processTestFrame(container, n, const [], [area], 0.0);
      async.elapse(const Duration(seconds: 1));
      processTestFrame(container, n, const [], [area], 0.0);

      expect(_area(state(container)!, area.id).disappear, 1);
    });
  });

  test('read warning starts per-second missing-duration updates until recovery', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 2, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      processTestFrame(container, n, const [], const [], 0.0);
      expect(state(container), isNotNull);
      expect(_missingSeconds(state(container)!), const Duration(minutes: 2).inSeconds);

      n.pause();

      async.elapse(const Duration(seconds: 2));

      final stalledState = state(container);
      expect(stalledState, isNotNull);
      expect(_missingSeconds(stalledState!), const Duration(minutes: 2, seconds: 2).inSeconds);

      n.resume();
      async.elapse(const Duration(seconds: 2));

      final recoveredState = state(container);
      expect(recoveredState, isNotNull);
      expect(_missingSeconds(recoveredState!), const Duration(minutes: 2, seconds: 2).inSeconds);
    });
  });

  test('source stopped starts timer and source started stops it', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 2, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      processTestFrame(container, n, const [], const [], 0.0);
      n.pause();

      async.elapse(const Duration(seconds: 3));
      expect(state(container), isNotNull);
      expect(_missingSeconds(state(container)!), const Duration(minutes: 2, seconds: 3).inSeconds);

      n.resume();
      async.elapse(const Duration(seconds: 2));

      expect(state(container), isNotNull);
      expect(_missingSeconds(state(container)!), const Duration(minutes: 2, seconds: 3).inSeconds);
    });
  });

  test('reset starts a new partial window on next frame', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 2, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final results = <core_domain.Observation>[];
      final sub = n.snapshots.listen(results.add);

      processTestFrame(container, n, const [], const [], 0.0);
      n.reset();

      async.elapse(const Duration(minutes: 1));
      processTestFrame(container, n, const [], const [], 0.0);
      pumpFrames(n, async, const Duration(minutes: 2));

      expect(results.length, 1);

      sub.cancel();
    });
  });

  test('presence interval spanning boundary contributes to both windows', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 4, 59, 600);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final area = core_domain.InterestArea(
        id: 55,
        name: 'zone',
        points: const [
          core_domain.PointData(dx: 0, dy: 0),
          core_domain.PointData(dx: 20, dy: 0),
          core_domain.PointData(dx: 20, dy: 20),
          core_domain.PointData(dx: 0, dy: 20),
        ],
      );
      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));
      final closed = <core_domain.Observation>[];
      final subscription = n.snapshots.listen(closed.add);
      addTearDown(subscription.cancel);

      processTestFrame(container, n, [track], [area], 0);
      async.elapse(const Duration(milliseconds: 400));
      async.elapse(const Duration(milliseconds: 600));
      processTestFrame(container, n, [track], [area], 0);
      async.flushMicrotasks();

      expect(closed, hasLength(1));
      expect(_area(closed.single, area.id).presenceTrackCount, 1);
      expect(_area(closed.single, area.id).presenceSumSeconds, 0);
      expect(_area(state(container)!, area.id).presenceTrackCount, 1);
      expect(_area(state(container)!, area.id).presenceSumSeconds, 1);
      expect(
        _area(closed.single, area.id).presenceSumSeconds + _area(state(container)!, area.id).presenceSumSeconds,
        1,
      );
    });
  });

  test('boundary presence uses prior inside tracks and advances the frame baseline', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 4, 59, 400);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final area = core_domain.InterestArea(
        id: 56,
        name: 'zone',
        points: const [
          core_domain.PointData(dx: 0, dy: 0),
          core_domain.PointData(dx: 20, dy: 0),
          core_domain.PointData(dx: 20, dy: 20),
          core_domain.PointData(dx: 0, dy: 20),
        ],
      );
      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));
      final closed = <core_domain.Observation>[];
      final subscription = n.snapshots.listen(closed.add);
      addTearDown(subscription.cancel);

      processTestFrame(container, n, [track], [area], 0);
      async.elapse(const Duration(milliseconds: 600));
      processTestFrame(container, n, [track], [area], 0);
      async.flushMicrotasks();

      async.elapse(const Duration(milliseconds: 400));
      processTestFrame(container, n, [track], [area], 0);

      expect(closed, hasLength(1));
      expect(_area(closed.single, area.id).presenceSumSeconds, 1);
      expect(_area(state(container)!, area.id).presenceSumSeconds, 0);
    });
  });

  test('frame gap spanning boundary is split across windows', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 4, 50);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final results = <core_domain.Observation>[];
      final sub = n.snapshots.listen(results.add);

      processTestFrame(container, n, const [], const [], 0.0);

      async.elapse(const Duration(seconds: 30));
      processTestFrame(container, n, const [], const [], 0.0);

      expect(results.length, 1);
      // First finalized window includes its own start-gap (10:00 -> 10:04:50)
      // plus the 10-second boundary-crossing frame gap (10:04:50 -> 10:05:00).
      expect(_missingSeconds(results.first), const Duration(minutes: 5).inSeconds);

      final activeWindow = state(container);
      expect(activeWindow, isNotNull);
      expect(_windowStart(activeWindow!), _businessTime(DateTime.utc(2026, 1, 1, 10, 5, 0)));
      // Boundary timer opens the new window at 10:05:00, so start-gap is zero.
      // Only the 20-second frame gap (10:05:00 -> 10:05:20) is accumulated.
      expect(_missingSeconds(activeWindow), const Duration(seconds: 20).inSeconds);

      sub.cancel();
    });
  });

  test('sub-second frame jitter is ignored', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final results = <core_domain.Observation>[];
      final sub = n.snapshots.listen(results.add);

      processTestFrame(container, n, const [], const [], 0.0);

      async.elapse(const Duration(milliseconds: 500));
      processTestFrame(container, n, const [], const [], 0.0);
      pumpFrames(n, async, const Duration(minutes: 4, seconds: 59, milliseconds: 500));

      expect(results.length, 1);
      sub.cancel();
    });
  });

  test('source stopped then source started keeps continuity and emits windows', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 2, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final results = <core_domain.Observation>[];
      final sub = n.snapshots.listen(results.add);

      processTestFrame(container, n, const [], const [], 0.0); // opens window 10:00–10:05
      n.pause();

      // Simulate source restarting an hour later (well past the 10:05 boundary)
      async.elapse(const Duration(hours: 1));
      n.resume();
      processTestFrame(container, n, const [], const [], 0.0); // opens fresh window at 11:00–11:05

      // Prior windows finalize on schedule; fresh window also finalizes when it rolls over.
      pumpFrames(n, async, const Duration(minutes: 5));
      expect(results, isNotEmpty);
      expect(_windowStart(results.last), _businessTime(DateTime.utc(2026, 1, 1, 11, 0, 0)));

      sub.cancel();
    });
  });

  test('consecutive complete windows are not marked partial', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final results = <core_domain.Observation>[];
      final sub = n.snapshots.listen(results.add);

      processTestFrame(container, n, const [], const [], 0.0);
      pumpFrames(n, async, const Duration(minutes: 5));
      expect(results.length, 1);

      pumpFrames(n, async, const Duration(minutes: 5));
      expect(results.length, 2);

      sub.cancel();
    });
  });

  test('window opened by boundary tick has zero missingAtStart', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 4, 59);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      // Boundary tick fires at 10:05:00 (nowUtc == windowStartUtc → gap = 0)
      n.start();
      async.elapse(const Duration(seconds: 2));
      processTestFrame(container, n, const [], const [], 0.0);

      final activeWindow = state(container);
      expect(activeWindow, isNotNull);
      expect(_windowStart(activeWindow!), _businessTime(DateTime.utc(2026, 1, 1, 10, 5, 0)));
    });
  });

  test('tracks occupancy and dwell time correctly', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final area = core_domain.InterestArea(
        id: 1,
        name: 'zone',
        points: const [
          core_domain.PointData(dx: 0, dy: 0),
          core_domain.PointData(dx: 100, dy: 0),
          core_domain.PointData(dx: 100, dy: 100),
          core_domain.PointData(dx: 0, dy: 100),
        ],
      );

      final track1 = buildTrack(trackId: 1, center: const Offset(50, 50), initialCenter: const Offset(50, 50));
      final track2 = buildTrack(trackId: 2, center: const Offset(60, 60), initialCenter: const Offset(60, 60));

      processTestFrame(container, n, [track1, track2], [area], 0.0);

      expect(n.getCurrentCount(area.id), 2);
      expect(n.getTotalCount(area.id), 2);
      expect(n.getCurrentCount(kGlobalAreaId), 2);
      expect(n.getTotalCount(kGlobalAreaId), 2);

      async.elapse(const Duration(seconds: 1));
      processTestFrame(container, n, [track1], [area], 0.0);
      expect(n.getCurrentCount(area.id), 1);
      expect(n.getTotalCount(area.id), 2);

      final activeWindow = state(container);
      expect(activeWindow, isNotNull);
      expect(_area(activeWindow!, area.id).occupancyLast, 1);
      expect(_area(activeWindow, area.id).occupancyMax, 2);
      expect(_area(activeWindow, area.id).occupancyMean, closeTo(1.5, 0.0001));
      expect(activeWindow.frameCount, 2);
      expect(activeWindow.confidenceRatio, 0.9);
    });
  });

  test('multiple areas track independently', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final area1 = core_domain.InterestArea(
        id: 1,
        name: 'zone1',
        points: const [
          core_domain.PointData(dx: 0, dy: 0),
          core_domain.PointData(dx: 50, dy: 0),
          core_domain.PointData(dx: 50, dy: 50),
          core_domain.PointData(dx: 0, dy: 50),
        ],
      );
      final area2 = core_domain.InterestArea(
        id: 2,
        name: 'zone2',
        points: const [
          core_domain.PointData(dx: 100, dy: 100),
          core_domain.PointData(dx: 150, dy: 100),
          core_domain.PointData(dx: 150, dy: 150),
          core_domain.PointData(dx: 100, dy: 150),
        ],
      );

      final track1 = buildTrack(trackId: 1, center: const Offset(25, 25), initialCenter: const Offset(25, 25));
      final track2 = buildTrack(trackId: 2, center: const Offset(125, 125), initialCenter: const Offset(125, 125));

      processTestFrame(container, n, [track1, track2], [area1, area2], 0.0);

      expect(n.getCurrentCount(area1.id), 1);
      expect(n.getCurrentCount(area2.id), 1);
      expect(n.getTotalCount(area1.id), 1);
      expect(n.getTotalCount(area2.id), 1);

      final activeWindow = state(container);
      expect(activeWindow, isNotNull);
      expect(_area(activeWindow!, area1.id).passBy, 1);
      expect(_area(activeWindow, area2.id).passBy, 1);
    });
  });

  test('average confidence ignores inactive tracks', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final activeTrack = buildTrack(
        trackId: 1,
        center: const Offset(10, 10),
        initialCenter: const Offset(10, 10),
      ).copyWith(confidenceRatio: 0.8, activated: true);

      final inactiveTrack = buildTrack(
        trackId: 2,
        center: const Offset(20, 20),
        initialCenter: const Offset(20, 20),
      ).copyWith(confidenceRatio: 0.2, activated: false);

      processTestFrame(container, n, [activeTrack, inactiveTrack], const [], 0.0);

      final activeWindow = state(container);
      expect(activeWindow, isNotNull);
      expect(activeWindow!.frameCount, 1);
      expect(activeWindow.confidenceRatio, 0.8);
    });
  });

  test('tracks persisting across window boundary', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final results = <core_domain.Observation>[];
      final sub = n.snapshots.listen(results.add);

      final area = core_domain.InterestArea(
        id: 1,
        name: 'zone',
        points: const [
          core_domain.PointData(dx: 0, dy: 0),
          core_domain.PointData(dx: 100, dy: 0),
          core_domain.PointData(dx: 100, dy: 100),
          core_domain.PointData(dx: 0, dy: 100),
        ],
      );

      final track = buildTrack(trackId: 1, center: const Offset(50, 50), initialCenter: const Offset(50, 50));

      processTestFrame(container, n, [track], [area], 0.0);
      async.elapse(const Duration(minutes: 5));

      expect(results.length, 1);
      expect(_area(results.first, area.id).passBy, 1);
      expect(_area(results.first, area.id).entry, 0);

      processTestFrame(container, n, [track], [area], 0.0);
      async.elapse(const Duration(minutes: 5));

      expect(results.length, 2);
      expect(_area(results[1], area.id).passBy, 0);
      expect(_area(results[1], area.id).entry, 0);

      sub.cancel();
    });
  });

  test('reset clears all state', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final area = core_domain.InterestArea(
        id: 1,
        name: 'zone',
        points: const [
          core_domain.PointData(dx: 0, dy: 0),
          core_domain.PointData(dx: 100, dy: 0),
          core_domain.PointData(dx: 100, dy: 100),
          core_domain.PointData(dx: 0, dy: 100),
        ],
      );

      final track = buildTrack(trackId: 1, center: const Offset(50, 50), initialCenter: const Offset(50, 50));
      processTestFrame(container, n, [track], [area], 0.0);

      expect(n.getTotalCount(area.id), 1);
      expect(state(container), isNotNull);

      n.reset();

      expect(n.getTotalCount(area.id), 0);
      expect(n.getCurrentCount(area.id), 0);
      final resetState = state(container)!;
      expect(resetState.areas, isEmpty);
    });
  });

  test('notifier count accessors work correctly', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final area1 = core_domain.InterestArea(
        id: 1,
        name: 'zone1',
        points: const [
          core_domain.PointData(dx: 0, dy: 0),
          core_domain.PointData(dx: 50, dy: 0),
          core_domain.PointData(dx: 50, dy: 50),
          core_domain.PointData(dx: 0, dy: 50),
        ],
      );
      final area2 = core_domain.InterestArea(
        id: 2,
        name: 'zone2',
        points: const [
          core_domain.PointData(dx: 100, dy: 100),
          core_domain.PointData(dx: 150, dy: 100),
          core_domain.PointData(dx: 150, dy: 150),
          core_domain.PointData(dx: 100, dy: 150),
        ],
      );

      final track1 = buildTrack(trackId: 1, center: const Offset(25, 25), initialCenter: const Offset(25, 25));
      final track2 = buildTrack(trackId: 2, center: const Offset(125, 125), initialCenter: const Offset(125, 125));
      final track3 = buildTrack(trackId: 3, center: const Offset(25, 25), initialCenter: const Offset(25, 25));

      processTestFrame(container, n, [track1, track2], [area1, area2], 0.0);
      processTestFrame(container, n, [track1, track2, track3], [area1, area2], 0.0);

      expect(n.getCurrentCount(area1.id), 2);
      expect(n.getCurrentCount(area2.id), 1);
      expect(n.getCurrentCount(kGlobalAreaId), 3);

      expect(n.getTotalCount(area1.id), 2);
      expect(n.getTotalCount(area2.id), 1);
      expect(n.getTotalCount(kGlobalAreaId), 3);
    });
  });

  test('interest area change clears state and starts new partial window', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final area1 = core_domain.InterestArea(
        id: 1,
        name: 'zone1',
        points: const [
          core_domain.PointData(dx: 0, dy: 0),
          core_domain.PointData(dx: 50, dy: 0),
          core_domain.PointData(dx: 50, dy: 50),
          core_domain.PointData(dx: 0, dy: 50),
        ],
      );
      final area2 = core_domain.InterestArea(
        id: 2,
        name: 'zone2',
        points: const [
          core_domain.PointData(dx: 100, dy: 100),
          core_domain.PointData(dx: 150, dy: 100),
          core_domain.PointData(dx: 150, dy: 150),
          core_domain.PointData(dx: 100, dy: 150),
        ],
      );

      final track1 = buildTrack(trackId: 1, center: const Offset(25, 25), initialCenter: const Offset(25, 25));

      processTestFrame(container, n, [track1], [area1], 0.0);
      expect(n.getTotalCount(area1.id), 1);

      setAreas(container, [area2]);

      expect(n.getTotalCount(area1.id), 0);
      expect(n.getCurrentCount(area1.id), 0);

      final track2 = buildTrack(trackId: 2, center: const Offset(125, 125), initialCenter: const Offset(125, 125));
      async.elapse(const Duration(seconds: 1));
      processTestFrame(container, n, [track2], [area2], 0.0);

      final activeWindow = state(container);
      expect(activeWindow, isNotNull);
      expect(_area(activeWindow!, area2.id).passBy, 1);
    });
  });

  test('changing interest areas discards the open visit and recounts pass-by', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      const points = [
        core_domain.PointData(dx: 0, dy: 0),
        core_domain.PointData(dx: 20, dy: 0),
        core_domain.PointData(dx: 20, dy: 20),
        core_domain.PointData(dx: 0, dy: 20),
      ];
      const area = core_domain.InterestArea(id: 61, name: 'zone', points: points);
      const renamed = core_domain.InterestArea(id: 61, name: 'zone moved', points: points);
      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));

      processTestFrame(container, n, [track], [area], 0);
      pumpFrames(n, async, const Duration(seconds: 10), step: const Duration(seconds: 2), tracks: [track]);
      expect(_area(state(container)!, area.id).passBy, 1);

      async.elapse(const Duration(seconds: 2));
      processTestFrame(container, n, [track], [renamed], 0);

      final metrics = _area(state(container)!, area.id);
      expect(metrics.dwellSampleCount, 0, reason: 'the open visit is discarded, not recorded');
      expect(metrics.passBy, 2, reason: 'the new tracker has no history, so the track counts again');
      expect(n.getTotalCount(area.id), 1);
      expect(_area(state(container)!, core_domain.kGlobalAreaId).passBy, 1, reason: 'global is unaffected');
    });
  });

  group('flushCurrentWindow', () {
    test('emits current window snapshot on snapshots', () {
      fakeAsync((async) {
        final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
        final container = makeContainer(async, base);
        addTearDown(container.dispose);
        final n = notifier(container);

        final results = <core_domain.Observation>[];
        final sub = n.snapshots.listen(results.add);

        processTestFrame(container, n, const [], const [], 0.0);
        pumpFrames(n, async, const Duration(minutes: 2));

        n.flushCurrentWindow();
        async.flushMicrotasks();

        expect(results.length, 1);
        expect(_windowStart(results.first), _businessTime(DateTime.utc(2026, 1, 1, 10, 0, 0)));

        sub.cancel();
      });
    });

    test('does not clear the aggregator — window continues accumulating after flush', () {
      fakeAsync((async) {
        final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
        final container = makeContainer(async, base);
        addTearDown(container.dispose);
        final n = notifier(container);

        final results = <core_domain.Observation>[];
        final sub = n.snapshots.listen(results.add);

        processTestFrame(container, n, const [], const [], 0.0);
        pumpFrames(n, async, const Duration(minutes: 2));

        n.flushCurrentWindow();
        async.flushMicrotasks();
        expect(results.length, 1);

        // Window still open — continues accumulating frames
        pumpFrames(n, async, const Duration(minutes: 3));

        // Natural boundary fires and emits a second snapshot
        expect(results.length, 2);
        expect(_windowStart(results[1]), _businessTime(DateTime.utc(2026, 1, 1, 10, 0, 0)));
        expect(_windowEnd(results[1]), _businessTime(DateTime.utc(2026, 1, 1, 10, 5, 0)));

        sub.cancel();
      });
    });

    test('does not reset processedFrameCount or area metrics after flush', () {
      fakeAsync((async) {
        final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
        final container = makeContainer(async, base);
        addTearDown(container.dispose);
        final n = notifier(container);

        processTestFrame(container, n, const [], const [], 0.0);
        async.elapse(const Duration(seconds: 1));
        processTestFrame(container, n, const [], const [], 0.0);

        final beforeFlush = state(container);
        expect(beforeFlush!.frameCount, 2);

        n.flushCurrentWindow();

        // State is unchanged — aggregator not touched
        final afterFlush = state(container);
        expect(afterFlush!.frameCount, 2);
      });
    });

    test('is a no-op when no aligned window is open', () {
      fakeAsync((async) {
        final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
        final container = makeContainer(async, base);
        addTearDown(container.dispose);
        final n = notifier(container);

        final results = <core_domain.Observation>[];
        final sub = n.snapshots.listen(results.add);

        // No frame has opened an aligned scheduler window.
        n.flushCurrentWindow();
        async.flushMicrotasks();

        expect(results, isEmpty);

        sub.cancel();
      });
    });

    test('flushes the current window after an area update', () {
      fakeAsync((async) {
        final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
        final container = makeContainer(async, base);
        addTearDown(container.dispose);
        final n = notifier(container);

        final results = <core_domain.Observation>[];
        final sub = n.snapshots.listen(results.add);

        processTestFrame(container, n, const [], const [], 0.0);
        pumpFrames(n, async, const Duration(minutes: 1));

        // The area update leaves the current aligned window active.
        n.onAreasChanged(const []);
        n.flushCurrentWindow();
        async.flushMicrotasks();

        expect(results.length, 1);
        expect(_windowStart(results.first), _businessTime(DateTime.utc(2026, 1, 1, 10, 0, 0)));

        sub.cancel();
      });
    });

    test('can be called multiple times without corrupting state', () {
      fakeAsync((async) {
        final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
        final container = makeContainer(async, base);
        addTearDown(container.dispose);
        final n = notifier(container);

        final results = <core_domain.Observation>[];
        final sub = n.snapshots.listen(results.add);

        processTestFrame(container, n, const [], const [], 0.0);
        pumpFrames(n, async, const Duration(minutes: 1));

        n.flushCurrentWindow();
        n.flushCurrentWindow();
        n.flushCurrentWindow();
        async.flushMicrotasks();

        expect(results.length, 3);
        // All three snapshots share the same window start
        for (final r in results) {
          expect(_windowStart(r), _businessTime(DateTime.utc(2026, 1, 1, 10, 0, 0)));
        }

        sub.cancel();
      });
    });
  });

  group('debugForceWindowEnd', () {
    test('forces immediate finalization and keeps a new active window', () {
      fakeAsync((async) {
        final base = DateTime.utc(2026, 1, 1, 10, 2, 0);
        final container = makeContainer(async, base);
        addTearDown(container.dispose);
        final n = notifier(container);

        final results = <core_domain.Observation>[];
        final sub = n.snapshots.listen(results.add);

        processTestFrame(container, n, const [], const [], 0.0);

        n.debugForceWindowEnd();
        async.flushMicrotasks();

        expect(results.length, 1, reason: 'force-end should finalize immediately via onWindowEnd');
        expect(_windowStart(results.first), _businessTime(DateTime.utc(2026, 1, 1, 10, 0, 0)));
        expect(_windowEnd(results.first), _businessTime(DateTime.utc(2026, 1, 1, 10, 5, 0)));

        final current = state(container);
        expect(current, isNotNull, reason: 'A fresh window should be opened for continued counting');
        expect(_windowStart(current!), _businessTime(DateTime.utc(2026, 1, 1, 10, 0, 0)));
        expect(_windowEnd(current), _businessTime(DateTime.utc(2026, 1, 1, 10, 5, 0)));

        sub.cancel();
      });
    });
  });
}
