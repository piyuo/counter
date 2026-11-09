import 'package:core_domain/aggregation/insight_dashboard_snapshot.dart';
import 'package:core_domain/aggregation/insight_data_type.dart';
import 'package:core_domain/model/insight_dashboard.dart';
import 'package:core_domain/model/observation_payload.dart';
import 'package:core_domain/state/models/interest_area.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('builds enabled custom areas in order and global area last', () {
    const areas = [
      InterestArea(id: 42, name: 'Checkout'),
      InterestArea(id: 7, name: 'Entrance'),
      InterestArea(id: 8, name: 'Disabled', enabled: false),
      InterestArea(id: kGlobalAreaId, name: 'Custom global'),
    ];
    final snapshot = buildInsightDashboardSnapshot(
      dashboard: const InsightDashboard(businessDate: '2026-10-29'),
      customAreas: areas,
      businessPeriods: const [],
      now: DateTime(2026, 10, 29, 12),
    );

    expect(snapshot.areas.map((area) => area.areaId), [42, 7, kGlobalAreaId]);
    expect(snapshot.areas.map((area) => area.name), ['Checkout', 'Entrance', null]);
    expect(
      snapshot.areas.first.cards.map((card) => card.metric),
      containsAll([InsightMetric.entry, InsightMetric.exit]),
    );
    final globalArea = snapshot.areas.last;
    expect(globalArea.isGlobal, isTrue);
    expect(globalArea.cards.map((card) => card.metric), isNot(contains(InsightMetric.entry)));
    expect(globalArea.cards.map((card) => card.metric), isNot(contains(InsightMetric.exit)));
  });

  test('reuses cached chart points only for matching area and metric', () {
    const dashboard = InsightDashboard(businessDate: '2026-10-29');
    const areas = [InterestArea(id: 42, name: 'Checkout')];
    final now = DateTime(2026, 10, 29, 12);
    final snapshot = buildInsightDashboardSnapshot(
      dashboard: dashboard,
      customAreas: areas,
      businessPeriods: const [],
      now: now,
    );
    final cachedPoints = snapshot.areas.first.cards
        .firstWhere((card) => card.metric == InsightMetric.passBy)
        .chartPoints;
    final cachedSnapshot = buildInsightDashboardSnapshot(
      dashboard: dashboard,
      customAreas: areas,
      businessPeriods: const [],
      now: now,
      cachedChartPoints: {(42, InsightMetric.passBy): cachedPoints},
    );
    final cards = cachedSnapshot.areas.first.cards;
    final passByCard = cards.firstWhere((card) => card.metric == InsightMetric.passBy);
    final stagnantCard = cards.firstWhere((card) => card.metric == InsightMetric.stagnant);

    expect(identical(passByCard.chartPoints, cachedPoints), isTrue);
    expect(identical(stagnantCard.chartPoints, cachedPoints), isFalse);
  });
}
