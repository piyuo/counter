import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/control_panel/widgets/metric_activity.dart';
import 'package:counter_app/control_panel/widgets/metric_hero.dart';
import 'package:counter_app/control_panel/widgets/metric_statistics.dart';
import 'package:counter_app/control_panel/widgets/metrics_cards.dart';
import 'package:flutter/material.dart';
import 'package:shared_l10n/shared_l10n.dart';

List<MetricCardData> mapVisionMetricsToCardData(
  BuildContext context, {
  required core_domain.Observation observation,
  required core_domain.InterestAreaState areaState,
  required String countAvgOccLabel,
  required String countMaxOccLabel,
  required String countAvgDwellLabel,
  required String countMaxDwellLabel,
}) {
  final orderedAreas = [
    (id: core_domain.kGlobalAreaId, name: ''),
    for (final area in areaState.areas) (id: area.id, name: area.name),
  ];

  final areaColors = {for (final area in areaState.areas) area.id: area.color};
  final panels = <MetricCardData>[];

  for (final area in orderedAreas) {
    final metrics = observation.areas.where((e) => e.areaId == area.id).firstOrNull;
    if (metrics == null) {
      continue;
    }

    final valueColor = area.id == core_domain.kGlobalAreaId
        ? Colors.lightBlue
        : (areaColors[area.id] ?? Colors.lightBlue);

    panels.add(
      MetricCardData(
        title: area.id == core_domain.kGlobalAreaId ? null : area.name,
        valueColor: valueColor,

        hero: HeroMetricData(
          value: '${metrics.occupancyLast}',
          label: context.l.current_occupancy,
          valueColor: Colors.grey.shade900,
        ),

        activity: ActivityMetricData(
          passBy: '${metrics.passBy}',
          stayed: '${metrics.stagnant}',
          entered: '${metrics.entry}',
          exited: '${metrics.exit}',
        ),

        details: DetailMetricData(appeared: '${metrics.appear}', disappeared: '${metrics.disappear}'),

        summary: SummaryMetricData(
          avgOccupancy: metrics.occupancyMean.toStringAsFixed(1),
          maxOccupancy: '${metrics.occupancyMax}',
          avgDwellSeconds: metrics.dwellMeanSeconds,
          maxDwellSeconds: metrics.dwellMaxSeconds,
        ),
      ),
    );
  }

  return panels;
}

List<MetricCardData> mapPayloadMetricsToCardData({required List<core_domain.AreaMetrics> areas}) {
  final orderedAreas = [...areas]..sort((a, b) => a.areaId.compareTo(b.areaId));

  return [
    for (final area in orderedAreas)
      MetricCardData(
        title: area.areaId == core_domain.kGlobalAreaId ? null : 'Area ${area.areaId}',
        valueColor: Colors.white,

        hero: HeroMetricData(value: '-', label: 'Occupancy', valueColor: Colors.grey.shade900),

        activity: ActivityMetricData(
          passBy: '${area.passBy}',
          stayed: '${area.stagnant}',
          entered: '${area.entry}',
          exited: '${area.exit}',
        ),

        details: DetailMetricData(appeared: '${area.appear}', disappeared: '${area.disappear}'),

        summary: SummaryMetricData(
          avgOccupancy: area.occupancyMean.toStringAsFixed(1),
          maxOccupancy: '${area.occupancyMax}',
          avgDwellSeconds: area.dwellMeanSeconds,
          maxDwellSeconds: area.dwellMaxSeconds,
        ),
      ),
  ];
}
