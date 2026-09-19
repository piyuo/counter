import 'dart:ui';

import 'package:feature_counting/src/area_tracker.dart';
import 'package:feature_counting/src/count_window_aggregator.dart';
import 'package:feature_counting/src/window_count_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;

void main() {
  group('AreaTracker', () {
    late AreaTracker globalTracker;
    late AreaTracker localTracker;

    setUp(() {
      globalTracker = AreaTracker.global();
      localTracker = AreaTracker.local(1);
    });

    test('global tracker processes objects without enter/exit events', () {
      final now = DateTime.now();
      final aggregator = CountWindowAggregator(
        areaNameResolver: _testAreaNameResolver,
        startUtc: now,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      final tracks = [_createTrack(1, const Offset(10, 10), const Duration(seconds: 1), const Offset(10, 10))];

      globalTracker.processFrame(tracks, aggregator, checkContains: (t) => true, checkInitialContains: (t) => true);

      expect(globalTracker.currentOccupancy, 1);
      expect(globalTracker.totalCount, 1);

      final result = aggregator.snapshot();
      expect(result.areas[kGlobalAreaId]?.entry, 0);
      expect(result.areas[kGlobalAreaId]?.exit, 0);
      expect(result.areas[kGlobalAreaId]?.passBy, 1);
      expect(result.areas[kGlobalAreaId]?.appear, 1);
      expect(result.areas[kGlobalAreaId]?.disappear, 0);
      expect(result.areas[kGlobalAreaId]?.stay, 1);
    });

    test('local tracker processes enter, exit, and passby events correctly', () {
      final now = DateTime.now();
      final aggregator = CountWindowAggregator(
        areaNameResolver: _testAreaNameResolver,
        startUtc: now,
        startBusiness: now,
        missingDuration: Duration.zero,
      );

      // 1. Enter and pass_by (initial outside, current inside)
      final track1 = _createTrack(
        1,
        const Offset(10, 10),
        const Duration(seconds: 1),
        const Offset(100, 100),
      ); // checkContains: true, checkInitialContains: false
      // 2. Exit (initial inside, current outside)
      final track2 = _createTrack(
        2,
        const Offset(100, 100),
        const Duration(seconds: 1),
        const Offset(10, 10),
      ); // checkContains: false, checkInitialContains: true

      localTracker.processFrame(
        [track1, track2],
        aggregator,
        checkContains: (t) => t.center == const Offset(10, 10), // Only point (10, 10) is inside
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );

      expect(localTracker.currentOccupancy, 1); // Only track1 is inside

      final result = aggregator.snapshot();

      final metrics = result.areas[1]!;
      expect(metrics.entry, 1);
      expect(metrics.exit, 1);
      expect(metrics.passBy, 1);
      expect(metrics.appear, 0);
      expect(metrics.disappear, 0);
      expect(metrics.stay, 1);
    });

    test('reset clears internal state', () {
      final now = DateTime.now();
      final aggregator = CountWindowAggregator(
        areaNameResolver: _testAreaNameResolver,
        startUtc: now,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      final track1 = _createTrack(1, const Offset(10, 10), const Duration(seconds: 1), const Offset(10, 10));

      localTracker.processFrame([track1], aggregator, checkContains: (t) => true, checkInitialContains: (t) => true);

      expect(localTracker.currentOccupancy, 1);
      expect(localTracker.totalCount, 1);

      localTracker.reset();

      expect(localTracker.currentOccupancy, 0);
      expect(localTracker.totalCount, 0);
    });

    test('local tracker does not double count passby and enter across frames', () {
      final now = DateTime.now();
      final aggregator = CountWindowAggregator(
        areaNameResolver: _testAreaNameResolver,
        startUtc: now,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      final track = _createTrack(1, const Offset(10, 10), const Duration(seconds: 1), const Offset(100, 100));

      // Same track appears inside in consecutive frames.
      localTracker.processFrame(
        [track],
        aggregator,
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );
      localTracker.processFrame(
        [track],
        aggregator,
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );

      final result = aggregator.snapshot();
      final events = result.areas[1]!;

      expect(events.passBy, 1);
      expect(events.entry, 1);
      expect(events.exit, 0);
      expect(events.appear, 0);
      expect(events.disappear, 0);
      expect(events.stay, 1);
      expect(localTracker.currentOccupancy, 1);
      expect(localTracker.totalCount, 1);
    });

    test('local tracker does not double count exit across frames', () {
      final now = DateTime.now();
      final aggregator = CountWindowAggregator(
        areaNameResolver: _testAreaNameResolver,
        startUtc: now,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      final track = _createTrack(2, const Offset(100, 100), const Duration(seconds: 1), const Offset(10, 10));

      // Same track appears outside in consecutive frames, started inside.
      localTracker.processFrame(
        [track],
        aggregator,
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );
      localTracker.processFrame(
        [track],
        aggregator,
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );

      final result = aggregator.snapshot();
      final events = result.areas[1]!;

      expect(events.exit, 1);
      expect(events.entry, 0);
      expect(events.passBy, 0);
      expect(events.appear, 0);
      expect(events.disappear, 0);
      expect(events.stay, 0);
      expect(localTracker.currentOccupancy, 0);
    });

    test('tracks appear and disappear once per track', () {
      final now = DateTime.now();
      final aggregator = CountWindowAggregator(
        areaNameResolver: _testAreaNameResolver,
        startUtc: now,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      final insideTrack = _createTrack(1, const Offset(10, 10), const Duration(seconds: 1), const Offset(10, 10));

      localTracker.processFrame(
        [insideTrack],
        aggregator,
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );

      // Track disappears (not present in current frame).
      localTracker.processFrame(
        const [],
        aggregator,
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );

      // Repeating the empty frame should not double count disappear.
      localTracker.processFrame(
        const [],
        aggregator,
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );

      final result = aggregator.snapshot();
      final events = result.areas[1]!;

      expect(events.appear, 1);
      expect(events.disappear, 1);
      expect(events.stay, 1);
      expect(events.passBy, 1);
    });

    test('stayCount honors StayThreshold in seconds', () {
      final thresholdTracker = AreaTracker.local(1, stayThreshold: const Duration(seconds: 2));
      final now = DateTime.now();
      final aggregator = CountWindowAggregator(
        areaNameResolver: _testAreaNameResolver,
        startUtc: now,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final insideTrack = _createTrack(1, const Offset(10, 10), const Duration(seconds: 1), const Offset(10, 10));

      thresholdTracker.processFrame(
        [insideTrack],
        aggregator,
        frameTimestampUtc: start,
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );

      thresholdTracker.processFrame(
        [insideTrack],
        aggregator,
        frameTimestampUtc: start.add(const Duration(seconds: 1)),
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );

      thresholdTracker.processFrame(
        [insideTrack],
        aggregator,
        frameTimestampUtc: start.add(const Duration(seconds: 2)),
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );

      final metrics = aggregator.snapshot().areas[1]!;
      expect(metrics.stay, 1);
    });

    test('disappearCount honors DisappearThreshold in seconds', () {
      final thresholdTracker = AreaTracker.local(1, disappearThreshold: const Duration(seconds: 2));
      final now = DateTime.now();
      final aggregator = CountWindowAggregator(
        areaNameResolver: _testAreaNameResolver,
        startUtc: now,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final insideTrack = _createTrack(1, const Offset(10, 10), const Duration(seconds: 1), const Offset(10, 10));

      thresholdTracker.processFrame(
        [insideTrack],
        aggregator,
        frameTimestampUtc: start,
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );

      thresholdTracker.processFrame(
        const [],
        aggregator,
        frameTimestampUtc: start.add(const Duration(seconds: 1)),
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );

      expect(aggregator.snapshot().areas[1]!.disappear, 0);

      thresholdTracker.processFrame(
        const [],
        aggregator,
        frameTimestampUtc: start.add(const Duration(seconds: 3)),
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );

      expect(aggregator.snapshot().areas[1]!.disappear, 1);
    });

    test('occupancy and totalCount update correctly across frames', () {
      final now = DateTime.now();
      final aggregator = CountWindowAggregator(
        areaNameResolver: _testAreaNameResolver,
        startUtc: now,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      final insideTrack = _createTrack(1, const Offset(10, 10), const Duration(seconds: 1), const Offset(10, 10));
      final outsideTrack = _createTrack(2, const Offset(100, 100), const Duration(seconds: 1), const Offset(100, 100));

      localTracker.processFrame(
        [insideTrack],
        aggregator,
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );
      expect(localTracker.currentOccupancy, 1);
      expect(localTracker.totalCount, 1);

      localTracker.processFrame(
        [outsideTrack],
        aggregator,
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );
      expect(localTracker.currentOccupancy, 0);
      expect(localTracker.totalCount, 1);
    });

    test('adds occupancy and dwell-time samples to aggregator state', () {
      final now = DateTime.now();
      final aggregator = CountWindowAggregator(
        areaNameResolver: _testAreaNameResolver,
        startUtc: now,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      final trackA = _createTrack(1, const Offset(10, 10), const Duration(seconds: 1), const Offset(10, 10));
      final trackB = _createTrack(2, const Offset(10, 10), const Duration(seconds: 2), const Offset(10, 10));
      final trackC = _createTrack(3, const Offset(10, 10), const Duration(seconds: 4), const Offset(10, 10));

      localTracker.processFrame(
        [trackA],
        aggregator,
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );

      localTracker.processFrame(
        [trackB, trackC],
        aggregator,
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );

      final result = aggregator.snapshot();
      final metrics = result.areas[1]!;

      expect(metrics.avgOccupancy, 1.5);
      expect(metrics.maxOccupancy, 2);
      expect(metrics.avgDwellSec, closeTo(2.3333333, 0.01));
      expect(metrics.maxDwellSec, 4);
    });

    test('passby refresh keeps recently seen track when history trims', () {
      for (var id = 1; id <= kMaxTrackHistory; id++) {
        _processInsideGlobal(globalTracker, id);
      }

      // Refresh track 1 so it moves to the end of insertion order.
      _processInsideGlobal(globalTracker, 1);

      // Add one more unique track to trigger trim.
      _processInsideGlobal(globalTracker, kMaxTrackHistory + 1);

      expect(globalTracker.totalCount, kMaxTrackHistory);

      final now = DateTime.now();
      final track2Aggregator = CountWindowAggregator(
        areaNameResolver: _testAreaNameResolver,
        startUtc: now,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      _processInsideGlobal(globalTracker, 2, track2Aggregator);
      final track2Result = track2Aggregator.snapshot();

      // Track 2 should be evicted (oldest after refreshing track 1), so passBy emits again.
      expect(track2Result.areas[kGlobalAreaId]!.passBy, 1);

      final now2 = DateTime.now();
      final track1Aggregator = CountWindowAggregator(
        areaNameResolver: _testAreaNameResolver,
        startUtc: now2,
        startBusiness: now2,
        missingDuration: Duration.zero,
      );
      _processInsideGlobal(globalTracker, 1, track1Aggregator);
      final track1Result = track1Aggregator.snapshot();

      // Track 1 was refreshed, so it should still be in history and not emit passBy again.
      expect(track1Result.areas[kGlobalAreaId]!.passBy, 0);
    });

    test('trimHistory caps passby history and evicts oldest inserted track', () {
      for (var id = 1; id <= kMaxTrackHistory + 1; id++) {
        _processInsideGlobal(globalTracker, id);
      }

      expect(globalTracker.totalCount, kMaxTrackHistory);

      final now = DateTime.now();
      final oldestTrackAggregator = CountWindowAggregator(
        areaNameResolver: _testAreaNameResolver,
        startUtc: now,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      _processInsideGlobal(globalTracker, 1, oldestTrackAggregator);
      final oldestTrackResult = oldestTrackAggregator.snapshot();

      // Track 1 should be evicted as the oldest inserted item after overflow.
      expect(oldestTrackResult.areas[kGlobalAreaId]!.passBy, 1);

      final now2 = DateTime.now();
      final newestTrackAggregator = CountWindowAggregator(
        areaNameResolver: _testAreaNameResolver,
        startUtc: now2,
        startBusiness: now2,
        missingDuration: Duration.zero,
      );
      _processInsideGlobal(globalTracker, kMaxTrackHistory + 1, newestTrackAggregator);
      final newestTrackResult = newestTrackAggregator.snapshot();

      // Most recently inserted track should still be present.
      expect(newestTrackResult.areas[kGlobalAreaId]!.passBy, 0);
    });
  });
}

String _testAreaNameResolver(int areaId) {
  if (areaId == kGlobalAreaId) return 'Global';
  return 'Area $areaId';
}

CountWindowAggregator _dummyAggregator() {
  final now = DateTime.now();
  return CountWindowAggregator(
    areaNameResolver: _testAreaNameResolver,
    startUtc: now,
    startBusiness: now,
    missingDuration: Duration.zero,
  );
}

void _processInsideGlobal(AreaTracker tracker, int trackId, [CountWindowAggregator? aggregator]) {
  tracker.processFrame(
    [_createTrack(trackId, const Offset(10, 10), const Duration(seconds: 1), const Offset(10, 10))],
    aggregator ?? _dummyAggregator(),
    checkContains: (t) => true,
    checkInitialContains: (t) => true,
  );
}

vision.TrackedObject _createTrack(int id, Offset position, Duration duration, Offset initialPosition) {
  return vision.TrackedObject.create(
    trackId: id,
    box: Rect.fromLTWH(position.dx, position.dy, 0, 0),
    confidence: 90,
    classId: 0,
    embeddingColor: const Color(0xFF000000),
    activated: true,
    hitStreak: 1,
    trackletId: 1,
    initialCenterX: initialPosition.dx.toInt(),
    initialCenterY: initialPosition.dy.toInt(),
    startTime: DateTime.now().subtract(duration).millisecondsSinceEpoch,
  );
}
