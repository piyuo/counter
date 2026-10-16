import 'dart:ui';

import 'package:core_domain/model/area_metrics.dart';
import 'package:core_domain/model/observation.dart';
import 'package:core_runtime/observation/area_tracker.dart';
import 'package:core_runtime/observation/observation_aggregator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;

AreaMetrics _area(Observation observation, int areaId) =>
    observation.areas.singleWhere((metrics) => metrics.areaId == areaId);

void main() {
  group('AreaTracker', () {
    late AreaTracker globalTracker;
    late AreaTracker localTracker;

    setUp(() {
      globalTracker = AreaTracker.global();
      localTracker = AreaTracker.local(1);
    });

    test('global tracker processes objects without enter/exit events', () {
      expect(globalTracker.areaId, kGlobalAreaId);
      final now = DateTime.now();
      final aggregator = ObservationAggregator(
        areaNameResolver: _testAreaNameResolver,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      final tracks = [_createTrack(1, const Offset(10, 10), const Offset(10, 10))];

      globalTracker.processFrame(tracks, aggregator, checkContains: (t) => true, checkInitialContains: (t) => true);

      expect(globalTracker.lastFrameOccupancy, 1);
      expect(globalTracker.passByTotalCount, 1);

      final result = aggregator.snapshot();
      expect(_area(result, kGlobalAreaId).entry, 0);
      expect(_area(result, kGlobalAreaId).exit, 0);
      expect(_area(result, kGlobalAreaId).passBy, 1);
      expect(_area(result, kGlobalAreaId).appear, 1);
      expect(_area(result, kGlobalAreaId).disappear, 0);
      expect(_area(result, kGlobalAreaId).stagnant, 1);
    });

    test('ignores non-tracked objects and continues processing tracked objects', () {
      final aggregator = _dummyAggregator();
      final trackedObject = _createTrack(1, const Offset(10, 10), const Offset(10, 10));

      globalTracker.processFrame<Object>(
        ['not a tracked object', trackedObject],
        aggregator,
        checkContains: (_) => true,
        checkInitialContains: (_) => true,
      );

      expect(globalTracker.lastFrameOccupancy, 1);
      expect(globalTracker.passByTotalCount, 1);
      final metrics = _area(aggregator.snapshot(), kGlobalAreaId);
      expect(metrics.appear, 1);
      expect(metrics.occupancySampleCount, 1);
    });

    test('ignores unactivated tracks for area metrics', () {
      final aggregator = _dummyAggregator();
      final inactiveTrack = _createTrack(1, const Offset(10, 10), const Offset(10, 10)).copyWith(activated: false);

      globalTracker.processFrame(
        [inactiveTrack],
        aggregator,
        elapsedSinceLastFrameMs: 1000,
        checkContains: (_) => true,
        checkInitialContains: (_) => true,
      );

      final metrics = _area(aggregator.snapshot(), kGlobalAreaId);
      expect(metrics.occupancySampleSum, 0);
      expect(metrics.presenceTrackCount, 0);
      expect(metrics.presenceSumSeconds, 0);
      expect(metrics.passBy, 0);
      expect(metrics.appear, 0);
      expect(globalTracker.passByTotalCount, 0);
    });

    test('addPresenceForLastFrame credits only the last frame\'s tracks', () {
      final aggregator = _dummyAggregator();
      final tracker = AreaTracker.global();
      final track = _createTrack(1, const Offset(10, 10), const Offset(10, 10));

      tracker.processFrame(
        [track],
        aggregator,
        frameTimestampUtc: DateTime.utc(2026, 1, 1, 10),
        checkContains: (_) => true,
        checkInitialContains: (_) => true,
      );
      tracker.addPresenceForLastFrame(aggregator, 1000);
      expect(_area(aggregator.snapshot(), kGlobalAreaId).presenceSumSeconds, 1);

      tracker.discardOpenVisits();
      tracker.addPresenceForLastFrame(aggregator, 1000);
      expect(
        _area(aggregator.snapshot(), kGlobalAreaId).presenceSumSeconds,
        1,
        reason: 'closed visits no longer receive presence',
      );
    });

    test('evaluates initial containment once per activated track', () {
      var initialContainmentChecks = 0;
      final track = _createTrack(1, const Offset(10, 10), const Offset(100, 100));

      localTracker.processFrame(
        [track],
        _dummyAggregator(),
        checkContains: (_) => true,
        checkInitialContains: (_) {
          initialContainmentChecks++;
          return false;
        },
      );

      expect(initialContainmentChecks, 1);
    });

    test('local tracker processes enter, exit, and pass-by events correctly', () {
      final now = DateTime.now();
      final aggregator = ObservationAggregator(
        areaNameResolver: _testAreaNameResolver,
        startBusiness: now,
        missingDuration: Duration.zero,
      );

      // 1. Enter and pass_by (initial outside, current inside)
      final track1 = _createTrack(
        1,
        const Offset(10, 10),
        const Offset(100, 100),
      ); // checkContains: true, checkInitialContains: false
      // 2. Exit (initial inside, current outside)
      final track2 = _createTrack(
        2,
        const Offset(100, 100),
        const Offset(10, 10),
      ); // checkContains: false, checkInitialContains: true

      localTracker.processFrame(
        [track1, track2],
        aggregator,
        checkContains: (t) => t.center == const Offset(10, 10), // Only point (10, 10) is inside
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );

      expect(localTracker.lastFrameOccupancy, 1); // Only track1 is inside

      final result = aggregator.snapshot();

      final metrics = _area(result, 1);
      expect(metrics.entry, 1);
      expect(metrics.exit, 1);
      expect(metrics.passBy, 1);
      expect(metrics.appear, 0);
      expect(metrics.disappear, 0);
      expect(metrics.stagnant, 1);
    });

    test('reset clears internal state', () {
      final now = DateTime.now();
      final aggregator = ObservationAggregator(
        areaNameResolver: _testAreaNameResolver,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      final track1 = _createTrack(1, const Offset(10, 10), const Offset(10, 10));

      localTracker.processFrame([track1], aggregator, checkContains: (t) => true, checkInitialContains: (t) => true);

      expect(localTracker.lastFrameOccupancy, 1);
      expect(localTracker.passByTotalCount, 1);

      localTracker.reset();

      expect(localTracker.lastFrameOccupancy, 0);
      expect(localTracker.passByTotalCount, 0);
    });

    test('local tracker does not double count pass-by and enter across frames', () {
      final now = DateTime.now();
      final aggregator = ObservationAggregator(
        areaNameResolver: _testAreaNameResolver,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      final track = _createTrack(1, const Offset(10, 10), const Offset(100, 100));

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
      final events = _area(result, 1);

      expect(events.passBy, 1);
      expect(events.entry, 1);
      expect(events.exit, 0);
      expect(events.appear, 0);
      expect(events.disappear, 0);
      expect(events.stagnant, 1);
      expect(localTracker.lastFrameOccupancy, 1);
      expect(localTracker.passByTotalCount, 1);
    });

    test('local tracker does not double count exit across frames', () {
      final now = DateTime.now();
      final aggregator = ObservationAggregator(
        areaNameResolver: _testAreaNameResolver,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      final track = _createTrack(2, const Offset(100, 100), const Offset(10, 10));

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
      final events = _area(result, 1);

      expect(events.exit, 1);
      expect(events.entry, 0);
      expect(events.passBy, 0);
      expect(events.appear, 0);
      expect(events.disappear, 0);
      expect(events.stagnant, 0);
      expect(localTracker.lastFrameOccupancy, 0);
    });

    test('tracks appear and disappear once per track', () {
      final now = DateTime.now();
      final aggregator = ObservationAggregator(
        areaNameResolver: _testAreaNameResolver,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      final insideTrack = _createTrack(1, const Offset(10, 10), const Offset(10, 10));

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
      final events = _area(result, 1);

      expect(events.appear, 1);
      expect(events.disappear, 1);
      expect(events.stagnant, 1);
      expect(events.passBy, 1);
    });

    test('stayCount honors StayThreshold in seconds', () {
      final thresholdTracker = AreaTracker.local(1, stagnantThreshold: const Duration(seconds: 2));
      final now = DateTime.now();
      final aggregator = ObservationAggregator(
        areaNameResolver: _testAreaNameResolver,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final insideTrack = _createTrack(1, const Offset(10, 10), const Offset(10, 10));

      thresholdTracker.processFrame(
        [insideTrack],
        aggregator,
        frameTimestampUtc: start,
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );
      expect(_area(aggregator.snapshot(), 1).stagnant, 0);

      thresholdTracker.processFrame(
        [insideTrack],
        aggregator,
        frameTimestampUtc: start.add(const Duration(seconds: 1)),
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );
      expect(_area(aggregator.snapshot(), 1).stagnant, 0);

      thresholdTracker.processFrame(
        [insideTrack],
        aggregator,
        frameTimestampUtc: start.add(const Duration(seconds: 2)),
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );

      final metrics = _area(aggregator.snapshot(), 1);
      expect(metrics.stagnant, 1);
    });

    test('disappearCount honors DisappearThreshold in seconds', () {
      final thresholdTracker = AreaTracker.local(1, disappearThreshold: const Duration(seconds: 2));
      final now = DateTime.now();
      final aggregator = ObservationAggregator(
        areaNameResolver: _testAreaNameResolver,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final insideTrack = _createTrack(1, const Offset(10, 10), const Offset(10, 10));

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

      expect(_area(aggregator.snapshot(), 1).disappear, 0);

      thresholdTracker.processFrame(
        const [],
        aggregator,
        frameTimestampUtc: start.add(const Duration(seconds: 3)),
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );

      expect(_area(aggregator.snapshot(), 1).disappear, 1);
    });

    test('reappearing track restarts disappear threshold', () {
      final thresholdTracker = AreaTracker.local(1, disappearThreshold: const Duration(seconds: 2));
      final aggregator = _dummyAggregator();
      final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
      final insideTrack = _createTrack(1, const Offset(10, 10), const Offset(10, 10));

      void processAt(DateTime timestamp, List<vision.TrackedObject> tracks) {
        thresholdTracker.processFrame(
          tracks,
          aggregator,
          frameTimestampUtc: timestamp,
          checkContains: (t) => t.center == const Offset(10, 10),
          checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
        );
      }

      processAt(start, [insideTrack]);
      processAt(start.add(const Duration(seconds: 1)), const []);
      processAt(start.add(const Duration(seconds: 2)), [insideTrack]);
      processAt(start.add(const Duration(seconds: 3)), const []);
      processAt(start.add(const Duration(seconds: 4)), const []);
      expect(_area(aggregator.snapshot(), 1).disappear, 0);

      processAt(start.add(const Duration(seconds: 5)), const []);
      expect(_area(aggregator.snapshot(), 1).disappear, 1);
    });

    test('occupancy and totalCount update correctly across frames', () {
      final now = DateTime.now();
      final aggregator = ObservationAggregator(
        areaNameResolver: _testAreaNameResolver,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      final insideTrack = _createTrack(1, const Offset(10, 10), const Offset(10, 10));
      final outsideTrack = _createTrack(2, const Offset(100, 100), const Offset(100, 100));

      localTracker.processFrame(
        [insideTrack],
        aggregator,
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );
      expect(localTracker.lastFrameOccupancy, 1);
      expect(localTracker.passByTotalCount, 1);

      localTracker.processFrame(
        [outsideTrack],
        aggregator,
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );
      expect(localTracker.lastFrameOccupancy, 0);
      expect(localTracker.passByTotalCount, 1);
    });

    test('records one rounded dwell sample after disappearance is confirmed', () {
      final aggregator = ObservationAggregator(
        areaNameResolver: _testAreaNameResolver,
        startBusiness: DateTime.utc(2026, 1, 1, 10),
        missingDuration: Duration.zero,
      );
      final tracker = AreaTracker.local(1, disappearThreshold: const Duration(seconds: 2));
      final track = _createTrack(1, const Offset(10, 10), const Offset(10, 10));
      final start = DateTime.utc(2026, 1, 1, 10);

      void processAt(DateTime timestamp, List<vision.TrackedObject> tracks) {
        tracker.processFrame(
          tracks,
          aggregator,
          frameTimestampUtc: timestamp,
          checkContains: (t) => t.center == const Offset(10, 10),
          checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
        );
      }

      processAt(start, [track]);
      processAt(start.add(const Duration(milliseconds: 2600)), [track]);

      var metrics = _area(aggregator.snapshot(), 1);
      expect(metrics.occupancySampleCount, 2);
      expect(metrics.dwellSampleCount, 0);
      expect(metrics.dwellSumSeconds, 0);
      expect(metrics.dwellMaxSeconds, 0);
      expect(metrics.dwellHistogram, [0, 0, 0, 0, 0]);

      processAt(start.add(const Duration(milliseconds: 3600)), const []);
      expect(_area(aggregator.snapshot(), 1).dwellSampleCount, 0);

      processAt(start.add(const Duration(milliseconds: 5600)), const []);

      metrics = _area(aggregator.snapshot(), 1);
      expect(metrics.disappear, 1);
      expect(metrics.dwellSampleCount, 1);
      expect(metrics.dwellSumSeconds, 4);
      expect(metrics.dwellMeanSeconds, 4);
      expect(metrics.dwellMaxSeconds, 4);
      expect(metrics.dwellHistogram, [1, 0, 0, 0, 0]);
    });

    test('source gap discards dwell and cleanup is idempotent', () {
      final aggregator = ObservationAggregator(
        areaNameResolver: (_) => '',
        startBusiness: DateTime(2026, 6, 1, 12),
        missingDuration: Duration.zero,
      );
      final tracker = AreaTracker.global();
      final start = DateTime.utc(2026, 6, 1, 19);
      final track = _createTrack(1, const Offset(10, 10), const Offset(10, 10));

      void processAt(DateTime timestamp) {
        tracker.processFrame(
          [track],
          aggregator,
          frameTimestampUtc: timestamp,
          elapsedSinceLastFrameMs: 1000,
          checkContains: (_) => true,
          checkInitialContains: (_) => true,
        );
      }

      for (var second = 0; second <= 30; second++) {
        processAt(start.add(Duration(seconds: second)));
      }

      tracker.discardOpenVisits();
      tracker.discardOpenVisits();
      processAt(start.add(const Duration(minutes: 10, seconds: 30)));

      final metrics = aggregator.snapshot().areas.single;
      expect(metrics.dwellSampleCount, 0);
      expect(metrics.dwellSumSeconds, 0);
      expect(metrics.passBy, 1);
    });

    test('cleanup discards a visit with a pending disappearance', () {
      final aggregator = _dummyAggregator();
      final tracker = AreaTracker.global(disappearThreshold: const Duration(seconds: 10));
      final start = DateTime.utc(2026, 1, 1, 10);
      final track = _createTrack(1, const Offset(10, 10), const Offset(10, 10));

      void processAt(DateTime at, List<vision.TrackedObject> tracks) {
        tracker.processFrame(
          tracks,
          aggregator,
          frameTimestampUtc: at,
          checkContains: (_) => true,
          checkInitialContains: (_) => true,
        );
      }

      processAt(start, [track]);
      processAt(start.add(const Duration(seconds: 30)), [track]);
      processAt(start.add(const Duration(seconds: 32)), const []);
      tracker.discardOpenVisits();

      final metrics = _area(aggregator.snapshot(), kGlobalAreaId);
      expect(metrics.dwellSampleCount, 0);
      expect(metrics.dwellSumSeconds, 0);
      expect(metrics.disappear, 0);
    });

    test('a returning track adds dwell without a second disappear', () {
      final aggregator = _dummyAggregator();
      final tracker = AreaTracker.global();
      final start = DateTime.utc(2026, 1, 1, 10);
      final track = _createTrack(1, const Offset(10, 10), const Offset(10, 10));

      void processAt(int seconds, List<vision.TrackedObject> tracks) {
        tracker.processFrame(
          tracks,
          aggregator,
          frameTimestampUtc: start.add(Duration(seconds: seconds)),
          checkContains: (_) => true,
          checkInitialContains: (_) => true,
        );
      }

      processAt(0, [track]);
      processAt(10, const []);
      processAt(20, [track]);
      processAt(30, const []);

      final metrics = _area(aggregator.snapshot(), kGlobalAreaId);
      expect(metrics.dwellSampleCount, 2);
      expect(metrics.dwellSumSeconds, 20);
      expect(metrics.disappear, 1);
      expect(metrics.passBy, 1);
    });

    test('adds occupancy samples independently from finished dwell samples', () {
      final now = DateTime.now();
      final aggregator = ObservationAggregator(
        areaNameResolver: _testAreaNameResolver,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      final tracker = AreaTracker.local(1, disappearThreshold: const Duration(hours: 1));
      final trackA = _createTrack(1, const Offset(10, 10), const Offset(10, 10));
      final trackB = _createTrack(2, const Offset(10, 10), const Offset(10, 10));
      final trackC = _createTrack(3, const Offset(10, 10), const Offset(10, 10));

      tracker.processFrame(
        [trackA],
        aggregator,
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );

      tracker.processFrame(
        [trackB, trackC],
        aggregator,
        checkContains: (t) => t.center == const Offset(10, 10),
        checkInitialContains: (t) => t.initialCenter == const Offset(10, 10),
      );

      final result = aggregator.snapshot();
      final metrics = _area(result, 1);

      expect(metrics.occupancyMean, 1.5);
      expect(metrics.occupancyMax, 2);
      expect(metrics.dwellSampleCount, 0);
      expect(metrics.dwellSumSeconds, 0);
      expect(metrics.dwellMaxSeconds, 0);
      expect(metrics.dwellHistogram, [0, 0, 0, 0, 0]);
    });

    test('pass-by refresh keeps recently seen track when history trims', () {
      for (var id = 1; id <= kMaxTrackHistory; id++) {
        _processInsideGlobal(globalTracker, id);
      }

      // Refresh track 1 so it moves to the end of insertion order.
      _processInsideGlobal(globalTracker, 1);

      // Add one more unique track to trigger trim.
      _processInsideGlobal(globalTracker, kMaxTrackHistory + 1);

      expect(globalTracker.passByTotalCount, kMaxTrackHistory + 1);

      final now = DateTime.now();
      final track2Aggregator = ObservationAggregator(
        areaNameResolver: _testAreaNameResolver,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      _processInsideGlobal(globalTracker, 2, track2Aggregator);
      final track2Result = track2Aggregator.snapshot();

      // Track 2 should be evicted (oldest after refreshing track 1), so passBy emits again.
      expect(_area(track2Result, kGlobalAreaId).passBy, 1);
      expect(globalTracker.passByTotalCount, kMaxTrackHistory + 2);

      final now2 = DateTime.now();
      final track1Aggregator = ObservationAggregator(
        areaNameResolver: _testAreaNameResolver,
        startBusiness: now2,
        missingDuration: Duration.zero,
      );
      _processInsideGlobal(globalTracker, 1, track1Aggregator);
      final track1Result = track1Aggregator.snapshot();

      // Track 1 was refreshed, so it should still be in history and not emit passBy again.
      expect(_area(track1Result, kGlobalAreaId).passBy, 0);
    });

    test('trimHistory caps pass-by history and evicts oldest inserted track', () {
      for (var id = 1; id <= kMaxTrackHistory + 1; id++) {
        _processInsideGlobal(globalTracker, id);
      }

      expect(globalTracker.passByTotalCount, kMaxTrackHistory + 1);

      final now = DateTime.now();
      final oldestTrackAggregator = ObservationAggregator(
        areaNameResolver: _testAreaNameResolver,
        startBusiness: now,
        missingDuration: Duration.zero,
      );
      _processInsideGlobal(globalTracker, 1, oldestTrackAggregator);
      final oldestTrackResult = oldestTrackAggregator.snapshot();

      // Track 1 should be evicted as the oldest inserted item after overflow.
      expect(_area(oldestTrackResult, kGlobalAreaId).passBy, 1);

      final now2 = DateTime.now();
      final newestTrackAggregator = ObservationAggregator(
        areaNameResolver: _testAreaNameResolver,
        startBusiness: now2,
        missingDuration: Duration.zero,
      );
      _processInsideGlobal(globalTracker, kMaxTrackHistory + 1, newestTrackAggregator);
      final newestTrackResult = newestTrackAggregator.snapshot();

      // Most recently inserted track should still be present.
      expect(_area(newestTrackResult, kGlobalAreaId).passBy, 0);
    });

    test('stagnant history refresh keeps a long stayer from being recounted', () {
      // Default zero stagnant threshold makes the first observed frame eligible.
      final tracker = AreaTracker.global();
      final aggregator = _dummyAggregator();

      _processInsideGlobal(tracker, 1, aggregator);
      for (var trackId = 2; trackId <= kMaxTrackHistory + 1; trackId++) {
        _processInsideGlobal(tracker, 1, aggregator);
        _processInsideGlobal(tracker, trackId, aggregator);
      }

      final verificationAggregator = _dummyAggregator();
      _processInsideGlobal(tracker, 1, verificationAggregator);
      expect(_area(verificationAggregator.snapshot(), kGlobalAreaId).stagnant, 0);
    });

    test('entry history refresh keeps a long stayer from being recounted', () {
      // Default zero stagnant threshold also emits stagnant on the first frame.
      final tracker = AreaTracker.local(1);
      final aggregator = _dummyAggregator();
      final stayer = _createTrack(1, const Offset(10, 10), const Offset(100, 100));

      for (var trackId = 2; trackId <= kMaxTrackHistory + 1; trackId++) {
        final entrant = _createTrack(trackId, const Offset(10, 10), const Offset(100, 100));
        tracker.processFrame(
          [stayer, entrant],
          aggregator,
          checkContains: (_) => true,
          checkInitialContains: (_) => false,
        );
      }

      final entryCount = aggregator.snapshot().areas.singleWhere((area) => area.areaId == 1).entry;
      expect(entryCount, kMaxTrackHistory + 1, reason: 'stayer once + each other track once');
    });
  });
}

String _testAreaNameResolver(int areaId) {
  if (areaId == kGlobalAreaId) return 'Global';
  return 'Area $areaId';
}

ObservationAggregator _dummyAggregator() {
  final now = DateTime.now();
  return ObservationAggregator(
    areaNameResolver: _testAreaNameResolver,
    startBusiness: now,
    missingDuration: Duration.zero,
  );
}

void _processInsideGlobal(AreaTracker tracker, int trackId, [ObservationAggregator? aggregator]) {
  tracker.processFrame(
    [_createTrack(trackId, const Offset(10, 10), const Offset(10, 10))],
    aggregator ?? _dummyAggregator(),
    checkContains: (t) => true,
    checkInitialContains: (t) => true,
  );
}

vision.TrackedObject _createTrack(int id, Offset position, Offset initialPosition) {
  return vision.TrackedObject.create(
    trackId: id,
    box: Rect.fromLTWH(position.dx, position.dy, 0, 0),
    confidenceRatio: 0.9,
    classId: 0,
    embeddingColor: const Color(0xFF000000),
    activated: true,
    hitStreak: 1,
    trackletId: 1,
    initialCenterX: initialPosition.dx.toInt(),
    initialCenterY: initialPosition.dy.toInt(),
    startTime: DateTime.now().millisecondsSinceEpoch,
  );
}
