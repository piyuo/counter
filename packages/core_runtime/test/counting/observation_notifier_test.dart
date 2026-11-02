import 'dart:ffi' as ffi;

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/observation/interest_area_notifier.dart';
import 'package:core_runtime/observation/observation_notifier.dart';
import 'package:core_runtime/services/vision_observation_event_handler.dart';
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

core_domain.Activity _area(core_domain.Observation payload, int areaId) =>
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

vision.VisionHandle _testVisionHandle() {
  final nullPointer = ffi.Pointer<ffi.Uint8>.fromAddress(0);
  return vision.VisionHandle(
    width: 1,
    height: 1,
    fps: 1,
    outputSize: 0,
    outputPtr: nullPointer,
    ySize: 0,
    uSize: 0,
    vSize: 0,
    yPtr: nullPointer,
    uPtr: nullPointer,
    vPtr: nullPointer,
    cameraImageFormat: null,
  );
}

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

  test('ignores frames after counting stops', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final emitted = <core_domain.Observation>[];
      final subscription = n.fiveMinuteObservations.listen(emitted.add);
      addTearDown(subscription.cancel);

      n.processFrame(const <Object>[], 0.0);
      n.stop();
      async.elapse(Duration.zero);
      async.flushMicrotasks();
      emitted.clear();
      final stateAfterStop = state(container);

      n.processFrame(const <Object>[], 0.0);
      async.flushMicrotasks();

      expect(state(container), stateAfterStop);
      expect(emitted, isEmpty);
    });
  });

  test('pause before start creates no timers or state changes', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = container.read(observationProvider.notifier);
      final initialState = state(container);

      n.pause();
      async.elapse(const Duration(seconds: 3));
      async.flushMicrotasks();

      expect(state(container), initialState);
      expect(async.periodicTimerCount, 0);
      expect(async.nonPeriodicTimerCount, 0);
    });
  });

  test('resume while stopped does not open or flush a window', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      n.stop();
      final stateAfterStop = state(container);
      final emitted = <core_domain.Observation>[];
      final subscription = n.fiveMinuteObservations.listen(emitted.add);
      addTearDown(subscription.cancel);

      n.resume();
      async.flushMicrotasks();

      expect(state(container), stateAfterStop);
      expect(emitted, isEmpty);
    });
  });

  test('stop discards the open window and restart opens a fresh one', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final emitted = <core_domain.Observation>[];
      final subscription = n.fiveMinuteObservations.listen(emitted.add);
      addTearDown(subscription.cancel);

      n.processFrame(const <Object>[], 0.0);
      n.stop();
      async.flushMicrotasks();
      expect(emitted, isEmpty);

      n.stop();
      async.flushMicrotasks();
      expect(emitted, isEmpty);

      n.start();
      expect(state(container)!.frameCount, 0);
      n.processFrame(const <Object>[], 0.0);
      expect(state(container)!.frameCount, 1);
      n.stop();
      async.flushMicrotasks();

      expect(emitted, isEmpty);
    });
  });

  test('restart after a long stop does not carry missing time into the new window', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));

      processTestFrame(container, n, [track], const [], 0.0);
      n.stop();
      async.elapse(const Duration(minutes: 10));
      n.start();

      async.elapse(const Duration(seconds: 1));
      processTestFrame(container, n, [track], const [], 0.0);

      final activeWindow = state(container)!;
      expect(_windowStart(activeWindow), _businessTime(DateTime.utc(2026, 1, 1, 10, 10)));
      expect(activeWindow.coveredSeconds, 1);
    });
  });

  test('disposing while paused cancels all timers', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      final n = notifier(container);

      n.pause();
      expect(async.periodicTimerCount, greaterThan(0));
      expect(async.nonPeriodicTimerCount, greaterThan(0));

      container.dispose();

      expect(async.periodicTimerCount, 0);
      expect(async.nonPeriodicTimerCount, 0);
    });
  });

  test('stop after pause cancels all timers', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = container.read(observationProvider.notifier);
      final periodicTimersBeforeStart = async.periodicTimerCount;
      final nonPeriodicTimersBeforeStart = async.nonPeriodicTimerCount;
      n.start();

      n.pause();
      expect(async.periodicTimerCount, greaterThan(0));
      expect(async.nonPeriodicTimerCount, greaterThan(0));

      n.stop();
      async.flushMicrotasks();
      n.stop();
      async.flushMicrotasks();

      expect(async.periodicTimerCount, periodicTimersBeforeStart);
      expect(async.nonPeriodicTimerCount, nonPeriodicTimersBeforeStart);
    });
  });

  test('finalizes window on wall-clock boundary', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 2, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final results = <core_domain.Observation>[];
      final sub = n.fiveMinuteObservations.listen(results.add);

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
      final subscription = notifier.fiveMinuteObservations.listen(closed.add);
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
      expect(container.read(observationProvider).coveredSeconds, 0);
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
      final subscription = n.fiveMinuteObservations.listen(closed.add);
      addTearDown(subscription.cancel);

      n.start();
      n.processFrame(const <Object>[], 0);
      n.pause();

      clockOffset = const Duration(minutes: 5, seconds: 30);
      async.elapse(const Duration(seconds: 1));
      async.flushMicrotasks();

      expect(closed.single.coveredSeconds, 0);
      expect(state(container)!.coveredSeconds, 0, reason: 'the active window contains only missing time');
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
      expect(state(container)!.coveredSeconds, 2);
      expect(global.presenceSampleCount, 1);
      expect(global.presenceSumSeconds, 3);
    });
  });

  test('late first frame after a scheduler-opened window is missing time', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final closed = <core_domain.Observation>[];
      final subscription = n.fiveMinuteObservations.listen(closed.add);
      addTearDown(subscription.cancel);

      async.elapse(const Duration(minutes: 5));
      async.elapse(const Duration(seconds: 5));
      n.processFrame(const <Object>[], 0);

      expect(state(container)!.coveredSeconds, 0);

      async.elapse(const Duration(seconds: 1));
      n.processFrame(const <Object>[], 0);

      expect(state(container)!.coveredSeconds, 1);

      n.debugForceWindowEnd();
      async.flushMicrotasks();

      expect(closed, hasLength(1));
      expect(closed.single.coveredSeconds, 295);
      expect(_missingSeconds(closed.single), 5);
    });
  });

  test('debug force-end does not charge time after now as missing', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12, 1);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final closed = <core_domain.Observation>[];
      final subscription = n.fiveMinuteObservations.listen(closed.add);
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
      final subscription = n.fiveMinuteObservations.listen(closed.add);
      addTearDown(subscription.cancel);

      processTestFrame(container, n, const [], const [], 0);
      async.elapse(const Duration(seconds: 5));
      jumpOffset = const Duration(hours: -2);
      async.elapse(const Duration(seconds: 5));
      async.flushMicrotasks();

      expect(closed, hasLength(1));
      expect(closed.single.coveredSeconds, 240);

      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));
      processTestFrame(container, n, [track], const [], 0);
      expect(n.getCurrentCount(core_domain.kGlobalAreaId), 1);
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
      async.elapse(const Duration(seconds: 5, milliseconds: 1));
      processTestFrame(container, n, [track], [area], 0);
      async.elapse(const Duration(seconds: 2));
      processTestFrame(container, n, const [], [area], 0);

      final metrics = _area(state(container)!, area.id);
      expect(metrics.dwellSampleCount, 1);
      expect(metrics.dwellSumSeconds, 2);
      expect(metrics.passBy, 1);
    });
  });

  test('duplicate frames process but backward frames do not regress continuity', () {
    fakeAsync((async) {
      var clock = DateTime.utc(2026, 6, 1, 12, 0, 10);
      final container = ProviderContainer(
        overrides: [
          observationProvider.overrideWith(
            () => ObservationNotifier(nowProvider: () => clock, monotonicNowProvider: () => async.elapsed),
          ),
        ],
      );
      addTearDown(container.dispose);
      final n = notifier(container);
      const area = core_domain.InterestArea(
        id: 59,
        name: 'zone',
        points: [
          core_domain.PointData(dx: 0, dy: 0),
          core_domain.PointData(dx: 20, dy: 0),
          core_domain.PointData(dx: 20, dy: 20),
          core_domain.PointData(dx: 0, dy: 20),
        ],
      );
      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));
      final secondTrack = buildTrack(trackId: 2, center: const Offset(12, 12), initialCenter: const Offset(12, 12));

      processTestFrame(container, n, [track], [area], 0);
      n.processFrame([track, secondTrack], 0);
      expect(n.getCurrentCount(area.id), 2, reason: 'duplicate-time frames remain processable');
      expect(n.getTotalCount(area.id), 2);

      clock = clock.subtract(const Duration(seconds: 2));
      n.processFrame(const [], 0);
      expect(n.getCurrentCount(area.id), 2, reason: 'backward-time frames are rejected');

      clock = clock.add(const Duration(seconds: 7));
      processTestFrame(container, n, [track, secondTrack], [area], 0);
      clock = clock.add(const Duration(seconds: 1));
      processTestFrame(container, n, const [], [area], 0);

      final metrics = _area(state(container)!, area.id);
      expect(metrics.dwellSumSeconds, 12, reason: 'the exact five-second gap preserves both visits');
      expect(metrics.passBy, 2);
    });
  });

  test('short frame gap reduces coverage without discarding visit continuity', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final area = core_domain.InterestArea(
        id: 57,
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
      async.elapse(const Duration(seconds: 4));
      processTestFrame(container, n, [track], [area], 0);
      async.elapse(const Duration(seconds: 1));
      processTestFrame(container, n, const [], [area], 0);

      final observation = state(container)!;
      final metrics = _area(observation, area.id);
      expect(observation.coveredSeconds, 1);
      expect(metrics.dwellSampleCount, 1);
      expect(metrics.dwellSumSeconds, 5);
    });
  });

  test('short frame gap at a boundary preserves visit continuity', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12, 4, 56);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final area = core_domain.InterestArea(
        id: 58,
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
      async.elapse(const Duration(seconds: 4));
      async.elapse(const Duration(seconds: 1));
      processTestFrame(container, n, [track], [area], 0);
      async.elapse(const Duration(seconds: 1));
      processTestFrame(container, n, const [], [area], 0);

      expect(_area(state(container)!, area.id).dwellSumSeconds, 6);
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

  test('short source stall preserves visit continuity while reducing coverage', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));

      processTestFrame(container, n, [track], const [], 0);
      n.pause();
      async.elapse(const Duration(seconds: 3));
      n.resume();
      processTestFrame(container, n, [track], const [], 0);
      async.elapse(const Duration(seconds: 2));
      processTestFrame(container, n, const [], const [], 0);

      final observation = state(container)!;
      final global = _area(observation, core_domain.kGlobalAreaId);
      expect(observation.coveredSeconds, 2);
      expect(global.dwellSampleCount, 1);
      expect(global.dwellSumSeconds, 5);
    });
  });

  test('long source pause is missing until a recovered frame arrives', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final handler = VisionObservationEventHandler(n);

      handler.handleFrame(const [], 0);
      handler.handleEvent(const vision.VisionIssue(code: 1, message: 'source interrupted'));
      async.elapse(const Duration(seconds: 20));

      handler.handleFrame(const [], 0);
      handler.handleEvent(const vision.VisionRecovered());
      expect(state(container)!.coveredSeconds, 0);
      async.elapse(const Duration(seconds: 1));
      handler.handleFrame(const [], 0);

      final observation = state(container)!;
      expect(observation.coveredSeconds, 1);
    });
  });

  test('short paused interval preserves continuity without presence credit', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base, disappearThresholdSeconds: 0);
      addTearDown(container.dispose);
      final n = notifier(container);
      final handler = VisionObservationEventHandler(n);
      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));

      handler.handleFrame([track], 0);
      handler.handleEvent(const vision.VisionIssue(code: 1, message: 'source interrupted'));
      async.elapse(const Duration(seconds: 4));
      handler.handleFrame([track], 0);
      handler.handleEvent(const vision.VisionRecovered());
      expect(state(container)!.coveredSeconds, 0);
      async.elapse(const Duration(seconds: 1));
      handler.handleFrame([track], 0);
      async.elapse(const Duration(seconds: 1));
      handler.handleFrame(const [], 0);

      final observation = state(container)!;
      final global = _area(observation, core_domain.kGlobalAreaId);
      expect(observation.coveredSeconds, 2);
      expect(global.presenceSumSeconds, 1);
      expect(global.dwellSumSeconds, 6);
    });
  });

  test('recovered frame processes a new track without recording the old dwell', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base, disappearThresholdSeconds: 0);
      addTearDown(container.dispose);
      final n = notifier(container);
      final handler = VisionObservationEventHandler(n);
      final firstTrack = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));
      final recoveredTrack = buildTrack(trackId: 2, center: const Offset(20, 20), initialCenter: const Offset(20, 20));
      expect(firstTrack.trackId, 1);
      expect(recoveredTrack.trackId, 2);

      handler.handleFrame([firstTrack], 0);
      handler.handleEvent(const vision.VisionIssue(code: 1, message: 'source interrupted'));
      async.elapse(const Duration(seconds: 20));
      handler.handleFrame([recoveredTrack], 0);
      handler.handleEvent(const vision.VisionRecovered());

      expect(n.getTotalCount(core_domain.kGlobalAreaId), 2);
      final recoveredObservation = state(container)!;
      expect(recoveredObservation.coveredSeconds, 0);
      expect(n.getCurrentCount(core_domain.kGlobalAreaId), 1);

      async.elapse(const Duration(seconds: 1));
      handler.handleFrame([recoveredTrack], 0);

      final nextObservation = state(container)!;
      final nextGlobal = _area(nextObservation, core_domain.kGlobalAreaId);
      expect(nextObservation.coveredSeconds, 1);
      expect(nextObservation.frameCount, 3);
      expect(nextGlobal.passBy, 2);
      expect(nextGlobal.dwellSampleCount, 0);
      expect(nextGlobal.dwellSumSeconds, 0);
    });
  });

  test('first successful frame resumes without VisionRecovered event', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final handler = VisionObservationEventHandler(n);

      handler.handleFrame(const [], 0);
      handler.handleEvent(const vision.VisionIssue(code: 1, message: 'source interrupted'));
      async.elapse(const Duration(seconds: 20));

      handler.handleFrame(const [], 0);

      expect(state(container)!.coveredSeconds, 0);
      expect(state(container)!.frameCount, 2);

      async.elapse(const Duration(seconds: 1));
      handler.handleFrame(const [], 0);

      expect(state(container)!.coveredSeconds, 1);
      expect(state(container)!.frameCount, 3);
    });
  });

  test('VisionRecovered without a frame does not resume coverage', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final handler = VisionObservationEventHandler(n);

      handler.handleFrame(const [], 0);
      handler.handleEvent(const vision.VisionIssue(code: 1, message: 'source interrupted'));
      async.elapse(const Duration(seconds: 20));

      handler.handleEvent(const vision.VisionRecovered());
      expect(state(container)!.coveredSeconds, 0);
      expect(state(container)!.frameCount, 1);

      async.elapse(const Duration(seconds: 2));
      handler.handleFrame(const [], 0);

      expect(state(container)!.coveredSeconds, 0);
      expect(state(container)!.frameCount, 2);
    });
  });

  test('started and alert events do not resume observation while paused', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final handler = VisionObservationEventHandler(n);

      handler.handleFrame(const [], 0);
      handler.handleEvent(const vision.VisionIssue(code: 1, message: 'source interrupted'));
      async.elapse(const Duration(seconds: 1));
      handler.handleEvent(vision.VisionStarted(_testVisionHandle()));
      handler.handleEvent(const vision.VisionAlert(message: 'parameter update failed'));
      expect(state(container)!.coveredSeconds, 0);
      expect(state(container)!.frameCount, 1);
      async.elapse(const Duration(seconds: 1));
      handler.handleFrame(const [], 0);

      expect(state(container)!.coveredSeconds, 0);
      expect(state(container)!.frameCount, 2);
    });
  });

  test('resume accounts for the interval since the last stall tick', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));

      n.processFrame([track], 0);
      n.pause();
      async.elapse(const Duration(seconds: 3));
      async.elapse(const Duration(milliseconds: 500));
      n.resume();

      async.elapse(const Duration(milliseconds: 500));
      n.processFrame([track], 0);
      async.elapse(const Duration(milliseconds: 500));
      n.processFrame([track], 0);

      expect(_area(state(container)!, core_domain.kGlobalAreaId).presenceSumSeconds, 1);
    });
  });

  test('frames arriving while paused are ignored', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final firstTrack = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));
      final queuedTrack = buildTrack(trackId: 2, center: const Offset(20, 20), initialCenter: const Offset(20, 20));

      n.processFrame([firstTrack], 0);
      final frameCountBeforePause = state(container)!.frameCount;
      n.pause();
      async.elapse(const Duration(seconds: 1));
      n.processFrame([queuedTrack], 0);

      expect(state(container)!.frameCount, frameCountBeforePause);
      expect(n.getCurrentCount(core_domain.kGlobalAreaId), 1);
      expect(n.getTotalCount(core_domain.kGlobalAreaId), 1);
    });
  });

  test('resume applies disappear threshold to new post-pause absences', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base, disappearThresholdSeconds: 2);
      addTearDown(container.dispose);
      final n = notifier(container);
      const area = core_domain.InterestArea(
        id: 60,
        name: 'zone',
        points: [
          core_domain.PointData(dx: 0, dy: 0),
          core_domain.PointData(dx: 20, dy: 0),
          core_domain.PointData(dx: 20, dy: 20),
          core_domain.PointData(dx: 0, dy: 20),
        ],
      );
      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));

      processTestFrame(container, n, [track], [area], 0);
      n.pause();
      async.elapse(const Duration(seconds: 10));
      n.resume();
      processTestFrame(container, n, [track], [area], 0);
      async.elapse(const Duration(seconds: 1));
      processTestFrame(container, n, const [], [area], 0);
      expect(_area(state(container)!, area.id).disappear, 0);

      async.elapse(const Duration(seconds: 2));
      processTestFrame(container, n, const [], [area], 0);

      final metrics = _area(state(container)!, area.id);
      expect(metrics.disappear, 1);
      expect(metrics.dwellSumSeconds, 1);
      expect(metrics.passBy, 1);
    });
  });

  test('a pause across a boundary adds no tail presence', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final closed = <core_domain.Observation>[];
      final subscription = n.fiveMinuteObservations.listen(closed.add);
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

  test('stale paused visit does not receive boundary tail presence', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 6, 1, 12);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);
      final track = buildTrack(trackId: 1, center: const Offset(10, 10), initialCenter: const Offset(10, 10));
      final closed = <core_domain.Observation>[];
      final subscription = n.fiveMinuteObservations.listen(closed.add);
      addTearDown(subscription.cancel);

      n.processFrame([track], 0);
      n.pause();
      async.elapse(const Duration(minutes: 4, seconds: 58));
      async.elapse(const Duration(milliseconds: 500));
      n.resume();
      async.elapse(const Duration(milliseconds: 1500));
      async.flushMicrotasks();

      expect(closed, hasLength(1));
      expect(closed.single.coveredSeconds, 2);
      expect(_area(closed.single, core_domain.kGlobalAreaId).presenceSumSeconds, 0);
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
      final subscription = n.fiveMinuteObservations.listen(closed.add);
      addTearDown(subscription.cancel);

      processTestFrame(container, n, [track], [area], 0);
      pumpFrames(n, async, const Duration(seconds: 30), step: const Duration(seconds: 2), tracks: [track]);
      jumpOffset = const Duration(minutes: 30);
      async.elapse(const Duration(seconds: 5));
      processTestFrame(container, n, [track], [area], 0);
      expect(state(container)!.coveredSeconds, 0, reason: 'the newly opened window has no elapsed covered time yet');
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

  test('stop discards an open window without emitting it', () {
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
      final subscription = n.fiveMinuteObservations.listen(closed.add);
      addTearDown(subscription.cancel);

      processTestFrame(container, n, [track], [area], 0);
      pumpFrames(n, async, const Duration(seconds: 30), step: const Duration(seconds: 2), tracks: [track]);
      n.stop();
      async.flushMicrotasks();

      expect(closed, isEmpty);
    });
  });

  test('finalized windows identify consecutive window times', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final results = <core_domain.Observation>[];
      final sub = n.fiveMinuteObservations.listen(results.add);

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
      final sub = n.fiveMinuteObservations.listen(results.add);

      n.resume();
      processTestFrame(container, n, const [], const [], 0.0);
      pumpFrames(n, async, const Duration(minutes: 5));

      expect(results, isNotEmpty);
      expect(results.first.hour * 100 + results.first.minute, _businessTime(DateTime.utc(2026, 1, 1, 10, 0, 0)));

      sub.cancel();
    });
  });

  test('pause keeps window lifecycle active and finalizes at boundary', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 2, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final results = <core_domain.Observation>[];
      final sub = n.fiveMinuteObservations.listen(results.add);

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
      final sub = n.fiveMinuteObservations.listen(results.add);

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

  test('live coverage subtracts a source stall from elapsed window time', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      processTestFrame(container, n, const [], const [], 0.0);
      pumpFrames(n, async, const Duration(seconds: 90));
      n.pause();
      async.elapse(const Duration(seconds: 30));

      expect(state(container)!.coveredSeconds, 90);
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

      final globalMetrics = _area(activeWindow, core_domain.kGlobalAreaId);
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
      expect(_area(nextWindow, area.id).presenceSampleCount, 0);
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
      expect(observation.coveredSeconds, 0);
      expect(_area(observation, core_domain.kGlobalAreaId).presenceSampleCount, 0);
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

  test('pause advances missing duration each second until resume', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 2, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      processTestFrame(container, n, const [], const [], 0.0);
      expect(state(container), isNotNull);
      expect(_missingSeconds(state(container)!), const Duration(minutes: 5).inSeconds);

      n.pause();

      async.elapse(const Duration(seconds: 2));

      final stalledState = state(container);
      expect(stalledState, isNotNull);
      expect(_missingSeconds(stalledState!), const Duration(minutes: 5).inSeconds);

      n.resume();
      async.elapse(const Duration(seconds: 2));

      final recoveredState = state(container);
      expect(recoveredState, isNotNull);
      expect(_missingSeconds(recoveredState!), const Duration(minutes: 5).inSeconds);
    });
  });

  test('pause starts issue timer and resume stops it', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 2, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      processTestFrame(container, n, const [], const [], 0.0);
      final periodicTimersBeforePause = async.periodicTimerCount;
      n.pause();
      expect(async.periodicTimerCount, periodicTimersBeforePause + 1);
      n.pause();
      expect(async.periodicTimerCount, periodicTimersBeforePause + 1);

      async.elapse(const Duration(seconds: 3));
      expect(state(container), isNotNull);

      n.resume();
      expect(async.periodicTimerCount, periodicTimersBeforePause);
      n.resume();
      expect(async.periodicTimerCount, periodicTimersBeforePause);
      async.elapse(const Duration(seconds: 2));

      expect(state(container), isNotNull);
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
      final subscription = n.fiveMinuteObservations.listen(closed.add);
      addTearDown(subscription.cancel);

      processTestFrame(container, n, [track], [area], 0);
      async.elapse(const Duration(milliseconds: 400));
      async.elapse(const Duration(milliseconds: 600));
      processTestFrame(container, n, [track], [area], 0);
      async.flushMicrotasks();

      expect(closed, hasLength(1));
      expect(_area(closed.single, area.id).presenceSampleCount, 1);
      expect(_area(closed.single, area.id).presenceSumSeconds, 0);
      expect(_area(state(container)!, area.id).presenceSampleCount, 1);
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
      final subscription = n.fiveMinuteObservations.listen(closed.add);
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
      final sub = n.fiveMinuteObservations.listen(results.add);

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
      expect(_missingSeconds(activeWindow), const Duration(minutes: 5).inSeconds);

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
      final sub = n.fiveMinuteObservations.listen(results.add);

      processTestFrame(container, n, const [], const [], 0.0);

      async.elapse(const Duration(milliseconds: 500));
      processTestFrame(container, n, const [], const [], 0.0);
      pumpFrames(n, async, const Duration(minutes: 4, seconds: 59, milliseconds: 500));

      expect(results.length, 1);
      sub.cancel();
    });
  });

  test('pause then resume keeps continuity and emits windows', () {
    fakeAsync((async) {
      final base = DateTime.utc(2026, 1, 1, 10, 2, 0);
      final container = makeContainer(async, base);
      addTearDown(container.dispose);
      final n = notifier(container);

      final results = <core_domain.Observation>[];
      final sub = n.fiveMinuteObservations.listen(results.add);

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
      final sub = n.fiveMinuteObservations.listen(results.add);

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
      expect(n.getCurrentCount(core_domain.kGlobalAreaId), 2);
      expect(n.getTotalCount(core_domain.kGlobalAreaId), 2);

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
      final sub = n.fiveMinuteObservations.listen(results.add);

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

  test('stop and start clear all session state', () {
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

      n.stop();
      n.start();

      expect(n.getTotalCount(area.id), 0);
      expect(n.getCurrentCount(area.id), 0);
      expect(state(container)!.areas, isEmpty);
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
      expect(n.getCurrentCount(core_domain.kGlobalAreaId), 3);

      expect(n.getTotalCount(area1.id), 2);
      expect(n.getTotalCount(area2.id), 1);
      expect(n.getTotalCount(core_domain.kGlobalAreaId), 3);
    });
  });

  test('interest area change recreates trackers', () {
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

  group('debugForceWindowEnd', () {
    test('does not update state or emit after stop', () {
      fakeAsync((async) {
        final base = DateTime.utc(2026, 1, 1, 10, 0, 0);
        final container = makeContainer(async, base);
        addTearDown(container.dispose);
        final n = notifier(container);
        n.stop();
        final stateAfterStop = state(container);
        final results = <core_domain.Observation>[];
        final subscription = n.fiveMinuteObservations.listen(results.add);
        addTearDown(subscription.cancel);

        async.elapse(const Duration(seconds: 1));
        n.debugForceWindowEnd();
        async.flushMicrotasks();

        expect(state(container), stateAfterStop);
        expect(results, isEmpty);
      });
    });

    test('forces immediate finalization and keeps a new active window', () {
      fakeAsync((async) {
        final base = DateTime.utc(2026, 1, 1, 10, 2, 0);
        final container = makeContainer(async, base);
        addTearDown(container.dispose);
        final n = notifier(container);

        final results = <core_domain.Observation>[];
        final sub = n.fiveMinuteObservations.listen(results.add);

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
