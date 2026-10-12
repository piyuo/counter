import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_domain/model/observation.dart';
import 'package:core_runtime/observation/observation_aggregator.dart';
import 'package:flutter_test/flutter_test.dart';

String _testAreaNameResolver(int areaId) {
  if (areaId == kGlobalAreaId) return 'Global';
  return 'Area $areaId';
}

AreaMetrics _area(Observation observation, int areaId) =>
    observation.areas.singleWhere((metrics) => metrics.areaId == areaId);

void main() {
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

    accumulator.addStateSample(area.id, 2, 2, 3, 2);
    accumulator.addStateSample(kGlobalAreaId, 5, 1, 5, 5);

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
    expect(areaMetrics.occupancyAvg, 2);
    expect(areaMetrics.occupancyMax, 2);
    expect(areaMetrics.occupancyLast, 2);
    expect(areaMetrics.dwellSumSeconds, 3);
    expect(areaMetrics.dwellSampleCount, 2);
    expect(areaMetrics.dwellAvgSeconds, 1.5);
    expect(areaMetrics.dwellMaxSeconds, 2);

    final globalMetrics = _area(result, kGlobalAreaId);
    expect(globalMetrics.passBy, 1);
    expect(globalMetrics.entry, 0);
    expect(globalMetrics.exit, 0);
    expect(globalMetrics.appear, 1);
    expect(globalMetrics.disappear, 1);
    expect(globalMetrics.stagnant, 1);
    expect(globalMetrics.occupancyAvg, 5);
    expect(globalMetrics.occupancyMax, 5);
    expect(globalMetrics.occupancyLast, 5);
    expect(globalMetrics.dwellAvgSeconds, 1.0);
    expect(globalMetrics.dwellMaxSeconds, 1);
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
    expect(metrics.occupancyAvg, 0.0);
    expect(metrics.occupancyMax, 0);
    expect(metrics.dwellSumSeconds, 0);
    expect(metrics.dwellSampleCount, 0);
    expect(metrics.dwellAvgSeconds, 0.0);
    expect(metrics.dwellMaxSeconds, 0);
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

  test('state sample aggregation computes averages and max across samples', () {
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

    // occupancyAvg is computed as a simple average across occupancy samples:
    // (1 + 3) / 2 = 2
    // dwellAvgSeconds = (6 + 1) / 3 = 2.333...
    // dwellMaxSeconds = max(3, 7) = 7 sec
    accumulator.addStateSample(area.id, 1, 3, 6, 2);
    accumulator.addStateSample(area.id, 3, 7, 1, 1);

    final result = accumulator.snapshot();
    final areaMetrics = _area(result, area.id);

    expect(areaMetrics.occupancySampleCount, 2);
    expect(areaMetrics.occupancySampleSum, 4);
    expect(areaMetrics.occupancyAvg, 2.0);
    expect(areaMetrics.occupancyMax, 3);
    expect(areaMetrics.occupancyLast, 3);
    expect(areaMetrics.dwellSumSeconds, 7);
    expect(areaMetrics.dwellSampleCount, 3);
    expect(areaMetrics.dwellAvgSeconds, closeTo(2.333333333, 1e-9));
    expect(areaMetrics.dwellMaxSeconds, 7);
  });

  test('processed frame count and effective FPS are tracked', () {
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
