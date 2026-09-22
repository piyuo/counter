import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_counting/src/count_window_aggregator.dart';
import 'package:feature_counting/src/window_count_state.dart';
import 'package:flutter_test/flutter_test.dart';

String _testAreaNameResolver(int areaId) {
  if (areaId == kGlobalAreaId) return 'Global';
  return 'Area $areaId';
}

void main() {
  test('snapshot builds per-area and global metrics', () {
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
    final accumulator = CountWindowAggregator(
      areaNameResolver: _testAreaNameResolver,
      startUtc: start,
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
    accumulator.incrementEvent(area.id, EventType.stay);
    accumulator.incrementEvent(kGlobalAreaId, EventType.passBy);
    accumulator.incrementEvent(kGlobalAreaId, EventType.entry);
    accumulator.incrementEvent(kGlobalAreaId, EventType.exit);
    accumulator.incrementEvent(kGlobalAreaId, EventType.appear);
    accumulator.incrementEvent(kGlobalAreaId, EventType.disappear);
    accumulator.incrementEvent(kGlobalAreaId, EventType.stay);

    accumulator.addStateSample(area.id, 2, 2000, 3000, 2);
    accumulator.addStateSample(kGlobalAreaId, 5, 1000, 5000, 5);

    final result = accumulator.snapshot();

    expect(result.missingDuration, Duration.zero);
    expect(result.frameCount, 0);
    expect(result.fps, 0.0);
    expect(result.confidence, 0.0);

    final areaMetrics = result.areas[area.id]!;
    expect(areaMetrics.passBy, 1);
    expect(areaMetrics.entry, 1);
    expect(areaMetrics.exit, 1);
    expect(areaMetrics.appear, 1);
    expect(areaMetrics.disappear, 1);
    expect(areaMetrics.stay, 1);
    expect(areaMetrics.currentOccupancy, 2);
    expect(areaMetrics.avgOccupancy, 2);
    expect(areaMetrics.maxOccupancy, 2);
    expect(areaMetrics.avgDwellSec, 1.5);
    expect(areaMetrics.maxDwellSec, 2);

    final globalMetrics = result.areas[kGlobalAreaId]!;
    expect(globalMetrics.passBy, 1);
    expect(globalMetrics.entry, 0);
    expect(globalMetrics.exit, 0);
    expect(globalMetrics.appear, 1);
    expect(globalMetrics.disappear, 1);
    expect(globalMetrics.stay, 1);
    expect(globalMetrics.currentOccupancy, 5);
    expect(globalMetrics.avgOccupancy, 5);
    expect(globalMetrics.maxOccupancy, 5);
    expect(globalMetrics.avgDwellSec, 1.0);
    expect(globalMetrics.maxDwellSec, 1);
  });

  test('snapshot has empty areas when no events/state were recorded', () {
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
    final accumulator = CountWindowAggregator(
      areaNameResolver: _testAreaNameResolver,
      startUtc: start,
      startBusiness: start.toLocal(),
      missingDuration: Duration.zero,
    );

    final result = accumulator.snapshot();
    expect(result.areas, isEmpty);
  });

  test('ensureStateSample adds an empty area state row', () {
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
    final accumulator = CountWindowAggregator(
      areaNameResolver: _testAreaNameResolver,
      startUtc: start,
      startBusiness: start.toLocal(),
      missingDuration: Duration.zero,
    );

    accumulator.ensureStateSample(7);

    final result = accumulator.snapshot();
    final metrics = result.areas[7]!;

    expect(metrics.passBy, 0);
    expect(metrics.entry, 0);
    expect(metrics.exit, 0);
    expect(metrics.appear, 0);
    expect(metrics.disappear, 0);
    expect(metrics.stay, 0);
    expect(metrics.currentOccupancy, 0);
    expect(metrics.avgOccupancy, 0.0);
    expect(metrics.maxOccupancy, 0);
    expect(metrics.avgDwellSec, 0.0);
    expect(metrics.maxDwellSec, 0);
  });

  test('coverage ratio accumulates valid missing durations', () {
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
    final accumulator = CountWindowAggregator(
      areaNameResolver: _testAreaNameResolver,
      startUtc: start,
      startBusiness: start.toLocal(),
      missingDuration: Duration.zero,
    );

    accumulator.addMissingDuration(const Duration(seconds: 30));
    accumulator.addMissingDuration(const Duration(seconds: 45));

    final result = accumulator.snapshot();
    expect(result.missingDuration, const Duration(seconds: 75));
  });

  test('state sample aggregation computes averages and max across samples', () {
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
    final accumulator = CountWindowAggregator(
      areaNameResolver: _testAreaNameResolver,
      startUtc: start,
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

    // avgOccupancy is computed as a simple average across occupancy samples:
    // (1 + 3) / 2 = 2
    // avgDwellSec = (2000 + 4000 + 1000) / 3 / 1000 = 2.333...
    // maxDwellSec = max(3000, 7000) ms -> 7 sec
    accumulator.addStateSample(area.id, 1, 3000, 6000, 2);
    accumulator.addStateSample(area.id, 3, 7000, 1000, 1);

    final result = accumulator.snapshot();
    final areaMetrics = result.areas[area.id]!;

    expect(areaMetrics.currentOccupancy, 3);
    expect(areaMetrics.avgOccupancy, 2.0);
    expect(areaMetrics.maxOccupancy, 3);
    expect(areaMetrics.avgDwellSec, closeTo(2.333333333, 1e-9));
    expect(areaMetrics.maxDwellSec, 7);
  });

  test('processed frame count and effective FPS are tracked', () {
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
    final accumulator = CountWindowAggregator(
      areaNameResolver: _testAreaNameResolver,
      startUtc: start,
      startBusiness: start.toLocal(),
      missingDuration: Duration.zero,
    );

    accumulator.incrementProcessedFrameCount();
    accumulator.incrementProcessedFrameCount();
    accumulator.incrementProcessedFrameCount();

    final result = accumulator.snapshot();
    expect(result.frameCount, 3);
    expect(result.fps, closeTo(0.01, 1e-9));
  });

  test('average confidence is aggregated across tracked-object samples', () {
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
    final accumulator = CountWindowAggregator(
      areaNameResolver: _testAreaNameResolver,
      startUtc: start,
      startBusiness: start.toLocal(),
      missingDuration: Duration.zero,
    );

    accumulator.addConfidenceAggregate(confidenceSum: 180, sampleCount: 2);
    accumulator.addConfidenceAggregate(confidenceSum: 50, sampleCount: 1);

    final result = accumulator.snapshot();
    expect(result.confidence, closeTo(76.6666666667, 1e-9));
  });

  test('snapshot carries session metadata', () {
    final start = DateTime.utc(2026, 1, 1, 10, 0, 0);
    final accumulator = CountWindowAggregator(
      areaNameResolver: _testAreaNameResolver,
      startUtc: start,
      startBusiness: start.toLocal(),
      session: 'CAMERA_260101_100000_abcd',
      sequence: 3,
      missingDuration: Duration.zero,
    );

    final result = accumulator.snapshot();
    expect(result.session, 'CAMERA_260101_100000_abcd');
    expect(result.sequence, 3);
  });
}
