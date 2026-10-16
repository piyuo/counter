import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_domain/model/observation.dart';
import 'package:core_runtime/observation/observation_aggregator.dart';
import 'package:flutter_test/flutter_test.dart';

String _testAreaNameResolver(int areaId) {
  if (areaId == kGlobalAreaId) return 'Global';
  return 'Area $areaId';
}

core_domain.AreaMetrics _area(Observation observation, int areaId) =>
    observation.areas.singleWhere((metrics) => metrics.areaId == areaId);

void main() {
  test('StateMetrics computes occupancy variance from samples', () {
    final metrics = StateMetrics();

    expect(metrics.occupancyVariance, 0.0);

    metrics
      ..addOccupancySample(2)
      ..addOccupancySample(3)
      ..addOccupancySample(1);

    expect(metrics.occupancySampleSum, 6);
    expect(metrics.occupancySampleCount, 3);
    expect(metrics.occupancySampleSumSquares, 14);
    expect(metrics.occupancyVariance, closeTo(2 / 3, 1e-9));
  });

  test('StateMetrics never exposes negative occupancy variance', () {
    final metrics = StateMetrics()
      ..occupancySampleCount = 2
      ..occupancySampleSum = 4
      ..occupancySampleSumSquares = 7;

    expect(metrics.occupancyVariance, 0.0);
  });

  test('StateMetrics clamps negative dwell durations to zero', () {
    final metrics = StateMetrics()..addDwellSample(-5);

    expect(metrics.dwellSampleCount, 1);
    expect(metrics.dwellSumSeconds, 0);
    expect(metrics.dwellHistogram, [1, 0, 0, 0, 0]);
  });

  test('StateMetrics accumulates person-time and distinct tracks', () {
    final metrics = StateMetrics()
      ..addPresenceSample({1}, 30000)
      ..addPresenceSample({1}, 30000);

    expect(metrics.presenceTrackCount, 1);
    expect(metrics.presenceSumSeconds, 60);
    expect(metrics.presenceMeanSeconds, 60);

    final twoTracks = StateMetrics()..addPresenceSample({1, 2}, 60000);
    expect(twoTracks.presenceTrackCount, 2);
    expect(twoTracks.presenceSumSeconds, 120);
    expect(twoTracks.presenceMeanSeconds, 60);
  });

  test('StateMetrics rounds person-seconds once per observation', () {
    final metrics = StateMetrics()..addPresenceSample({1}, 500);

    expect(metrics.presenceSumSeconds, 1);
    expect(metrics.presenceMeanSeconds, 1);
  });

  test('StateMetrics ignores invalid samples and rounds total person-time once', () {
    final metrics = StateMetrics()
      ..addPresenceSample({1}, 0)
      ..addPresenceSample({1}, -1000)
      ..addPresenceSample({}, 60000);

    expect(metrics.presenceTrackCount, 0);
    expect(metrics.presenceSumSeconds, 0);
    expect(metrics.presenceMeanSeconds, 0);

    final rounded = StateMetrics()..addPresenceSample({1, 2}, 500);
    expect(rounded.presenceTrackCount, 2);
    expect(rounded.presenceSumSeconds, 1);
    expect(rounded.presenceMeanSeconds, 0.5);
  });

  test('snapshot includes presence for each area and global area', () {
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
    final accumulator = ObservationAggregator(
      areaNameResolver: _testAreaNameResolver,
      startBusiness: start.toLocal(),
      missingDuration: Duration.zero,
    );

    accumulator
      ..addPresenceSample(1, {11}, 60000)
      ..addPresenceSample(kGlobalAreaId, {11, 12}, 30000);

    final result = accumulator.snapshot();
    final local = _area(result, 1);
    final global = _area(result, kGlobalAreaId);

    expect(local.presenceTrackCount, 1);
    expect(local.presenceSumSeconds, 60);
    expect(local.presenceMeanSeconds, 60);
    expect(global.presenceTrackCount, 2);
    expect(global.presenceSumSeconds, 60);
    expect(global.presenceMeanSeconds, 30);
  });

  test('snapshot builds per-area and global metrics', () {
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
    final accumulator = ObservationAggregator(
      areaNameResolver: _testAreaNameResolver,
      startBusiness: start.toLocal(),
      missingDuration: Duration.zero,
    );

    final area = core_domain.InterestArea(
      id: 1,
      name: 'zone',
      points: const [
        core_domain.PointData(dx: 0, dy: 0),
        core_domain.PointData(dx: 10, dy: 0),
        core_domain.PointData(dx: 10, dy: 10),
        core_domain.PointData(dx: 0, dy: 10),
      ],
    );

    accumulator.incrementEvent(area.id, EventType.passBy);
    accumulator.incrementEvent(area.id, EventType.entry);
    accumulator.incrementEvent(area.id, EventType.exit);
    accumulator.incrementEvent(area.id, EventType.appear);
    accumulator.incrementEvent(area.id, EventType.disappear);
    accumulator.incrementEvent(area.id, EventType.stagnant);
    accumulator.incrementEvent(kGlobalAreaId, EventType.passBy);
    accumulator.incrementEvent(kGlobalAreaId, EventType.entry);
    accumulator.incrementEvent(kGlobalAreaId, EventType.exit);
    accumulator.incrementEvent(kGlobalAreaId, EventType.appear);
    accumulator.incrementEvent(kGlobalAreaId, EventType.disappear);
    accumulator.incrementEvent(kGlobalAreaId, EventType.stagnant);

    accumulator.addOccupancySample(area.id, 2);
    accumulator.addDwellSample(area.id, 2);
    accumulator.addDwellSample(area.id, 1);
    accumulator.addOccupancySample(kGlobalAreaId, 5);
    accumulator.addDwellSample(kGlobalAreaId, 1);

    final result = accumulator.snapshot();

    expect(result.frameCount, 0);
    expect(result.confidenceRatio, 0.0);
    expect(result.confidenceRatioSum, 0);
    expect(result.confidenceSampleCount, 0);

    final areaMetrics = _area(result, area.id);
    expect(areaMetrics.passBy, 1);
    expect(areaMetrics.entry, 1);
    expect(areaMetrics.exit, 1);
    expect(areaMetrics.appear, 1);
    expect(areaMetrics.disappear, 1);
    expect(areaMetrics.stagnant, 1);
    expect(areaMetrics.occupancySampleCount, 1);
    expect(areaMetrics.occupancySampleSum, 2);
    expect(areaMetrics.occupancySampleSumSquares, 4);
    expect(areaMetrics.occupancyMean, 2);
    expect(areaMetrics.occupancyMax, 2);
    expect(areaMetrics.occupancyLast, 2);
    expect(areaMetrics.dwellSumSeconds, 3);
    expect(areaMetrics.dwellSampleCount, 2);
    expect(areaMetrics.dwellMeanSeconds, 1.5);
    expect(areaMetrics.dwellMaxSeconds, 2);
    expect(areaMetrics.dwellHistogram, [2, 0, 0, 0, 0]);

    final globalMetrics = _area(result, kGlobalAreaId);
    expect(globalMetrics.passBy, 1);
    expect(globalMetrics.entry, 0);
    expect(globalMetrics.exit, 0);
    expect(globalMetrics.appear, 1);
    expect(globalMetrics.disappear, 1);
    expect(globalMetrics.stagnant, 1);
    expect(globalMetrics.occupancyMean, 5);
    expect(globalMetrics.occupancyMax, 5);
    expect(globalMetrics.occupancyLast, 5);
    expect(globalMetrics.dwellMeanSeconds, 1.0);
    expect(globalMetrics.dwellMaxSeconds, 1);
    expect(globalMetrics.dwellHistogram, [1, 0, 0, 0, 0]);
  });

  test('snapshot has empty areas when no events/state were recorded', () {
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
    final accumulator = ObservationAggregator(
      areaNameResolver: _testAreaNameResolver,
      startBusiness: start.toLocal(),
      missingDuration: Duration.zero,
    );

    final result = accumulator.snapshot();
    expect(result.areas, isEmpty);
  });

  test('ensureStateSample adds an empty area state row', () {
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
    final accumulator = ObservationAggregator(
      areaNameResolver: _testAreaNameResolver,
      startBusiness: start.toLocal(),
      missingDuration: Duration.zero,
    );

    accumulator.ensureStateSample(7);

    final result = accumulator.snapshot();
    final metrics = _area(result, 7);

    expect(metrics.passBy, 0);
    expect(metrics.entry, 0);
    expect(metrics.exit, 0);
    expect(metrics.appear, 0);
    expect(metrics.disappear, 0);
    expect(metrics.stagnant, 0);
    expect(metrics.occupancyLast, 0);
    expect(metrics.occupancySampleCount, 0);
    expect(metrics.occupancySampleSum, 0);
    expect(metrics.occupancySampleSumSquares, 0);
    expect(metrics.occupancyMean, 0.0);
    expect(metrics.occupancyMax, 0);
    expect(metrics.dwellSumSeconds, 0);
    expect(metrics.dwellSampleCount, 0);
    expect(metrics.dwellMeanSeconds, 0.0);
    expect(metrics.dwellMaxSeconds, 0);
    expect(metrics.dwellHistogram, [0, 0, 0, 0, 0]);
  });

  test('coverage ratio accumulates valid missing durations', () {
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
    final accumulator = ObservationAggregator(
      areaNameResolver: _testAreaNameResolver,
      startBusiness: start.toLocal(),
      missingDuration: Duration.zero,
    );

    accumulator.addMissingDuration(const Duration(seconds: 30));
    accumulator.addMissingDuration(const Duration(seconds: 45));

    final result = accumulator.snapshot();
    expect(result.coveredSeconds, 225);
    expect(result.expectedSeconds, 300);
    expect(result.coverageRatio, 0.75);
  });

  test('coverage clamps at the window length', () {
    ObservationAggregator make(Duration missing) => ObservationAggregator(
      areaNameResolver: _testAreaNameResolver,
      startBusiness: DateTime(2026, 1, 1, 10),
      missingDuration: missing,
    );

    expect(make(const Duration(seconds: 298)).snapshot().coveredSeconds, 2);
    expect(make(const Duration(seconds: 299)).snapshot().coveredSeconds, 0);
    expect(make(const Duration(seconds: 500)).snapshot().coveredSeconds, 0);
    expect(make(const Duration(seconds: -5)).snapshot().coveredSeconds, 300);
  });

  test('occupancy and dwell samples aggregate independently', () {
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
    final accumulator = ObservationAggregator(
      areaNameResolver: _testAreaNameResolver,
      startBusiness: start.toLocal(),
      missingDuration: Duration.zero,
    );

    final area = core_domain.InterestArea(
      id: 2,
      name: 'zone-2',
      points: const [
        core_domain.PointData(dx: 0, dy: 0),
        core_domain.PointData(dx: 2, dy: 0),
        core_domain.PointData(dx: 2, dy: 2),
      ],
    );

    accumulator.addOccupancySample(area.id, 1);
    accumulator.addOccupancySample(area.id, 3);
    accumulator.addDwellSample(area.id, 3);
    accumulator.addDwellSample(area.id, 7);
    accumulator.addDwellSample(area.id, 1);

    final result = accumulator.snapshot();
    final areaMetrics = _area(result, area.id);

    expect(areaMetrics.occupancySampleCount, 2);
    expect(areaMetrics.occupancySampleSum, 4);
    expect(areaMetrics.occupancySampleSumSquares, 10);
    expect(areaMetrics.occupancyMean, 2.0);
    expect(areaMetrics.occupancyMax, 3);
    expect(areaMetrics.occupancyLast, 3);
    expect(areaMetrics.dwellSumSeconds, 11);
    expect(areaMetrics.dwellSampleCount, 3);
    expect(areaMetrics.dwellMeanSeconds, closeTo(3.666666667, 1e-9));
    expect(areaMetrics.dwellMaxSeconds, 7);
    expect(areaMetrics.dwellHistogram, [2, 1, 0, 0, 0]);
  });

  test('dwell histogram uses inclusive lower bucket edges', () {
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
    final accumulator = ObservationAggregator(
      areaNameResolver: _testAreaNameResolver,
      startBusiness: start.toLocal(),
      missingDuration: Duration.zero,
    );

    for (final seconds in [4, 5, 14, 15, 59, 60, 299, 300]) {
      accumulator.addDwellSample(1, seconds);
    }

    final metrics = _area(accumulator.snapshot(), 1);
    expect(metrics.dwellHistogram, [1, 2, 2, 2, 1]);
    expect(metrics.dwellHistogram.reduce((sum, count) => sum + count), metrics.dwellSampleCount);
    expect(metrics.dwellSampleCount, 8);
    expect(metrics.dwellSumSeconds, 756);
    expect(metrics.dwellMeanSeconds, 94.5);
    expect(metrics.dwellMaxSeconds, 300);
  });

  test('dwell histogram snapshot is isolated from later samples', () {
    final accumulator = ObservationAggregator(
      areaNameResolver: _testAreaNameResolver,
      startBusiness: DateTime(2026, 1, 1, 10),
      missingDuration: Duration.zero,
    );
    accumulator.addDwellSample(1, 5);
    final histogram = _area(accumulator.snapshot(), 1).dwellHistogram;

    accumulator.addDwellSample(1, 300);
    expect(histogram, [0, 1, 0, 0, 0]);
  });

  test('processed frame count is tracked', () {
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
    final accumulator = ObservationAggregator(
      areaNameResolver: _testAreaNameResolver,
      startBusiness: start.toLocal(),
      missingDuration: Duration.zero,
    );

    accumulator.incrementProcessedFrameCount();
    accumulator.incrementProcessedFrameCount();
    accumulator.incrementProcessedFrameCount();

    final result = accumulator.snapshot();
    expect(result.frameCount, 3);
  });

  test('average confidence is aggregated across tracked-object samples', () {
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
    final accumulator = ObservationAggregator(
      areaNameResolver: _testAreaNameResolver,
      startBusiness: start.toLocal(),
      missingDuration: Duration.zero,
    );

    accumulator.addConfidenceAggregate(confidenceRatioSum: 1.8025, sampleCount: 2);
    accumulator.addConfidenceAggregate(confidenceRatioSum: 0.50125, sampleCount: 1);

    final result = accumulator.snapshot();
    expect(result.confidenceRatio, closeTo(0.767916666667, 1e-9));
    expect(result.confidenceRatioSum, 2.30375);
    expect(result.confidenceSampleCount, 3);
  });

  test('snapshot returns an observation with business-time components', () {
    final startBusiness = DateTime(2026, 1, 1, 10, 0, 0);
    final accumulator = ObservationAggregator(
      areaNameResolver: _testAreaNameResolver,
      startBusiness: startBusiness,
      missingDuration: Duration.zero,
    );

    final result = accumulator.snapshot();
    expect(result.year, 2026);
    expect(result.month, 1);
    expect(result.day, 1);
    expect(result.hour, 10);
    expect(result.minute, 0);
  });
}
