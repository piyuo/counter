import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/widgets/metric_activity.dart';
import 'package:feature_control_panel/widgets/metric_hero.dart';
import 'package:feature_control_panel/widgets/metric_statistics.dart';
import 'package:feature_control_panel/widgets/metrics_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:shared_l10n/shared_l10n.dart';

List<MetricCardData> mapVisionMetricsToCardData(
  BuildContext context, {
  required vision.WindowCountState windowCount,
  required vision.InterestAreaState areaState,
  required String countAvgOccLabel,
  required String countMaxOccLabel,
  required String countAvgDwellLabel,
  required String countMaxDwellLabel,
}) {
  final orderedAreas = [
    (id: vision.kGlobalAreaId, name: ''),
    for (final area in areaState.activeAreas) (id: area.id, name: area.name),
  ];

  final areaColors = {for (final area in areaState.activeAreas) area.id: area.color};

  final panels = <MetricCardData>[];

  for (final area in orderedAreas) {
    final metrics = windowCount.areas[area.id];

    if (metrics == null) {
      continue;
    }

    final valueColor = area.id == vision.kGlobalAreaId ? Colors.lightBlue : (areaColors[area.id] ?? Colors.lightBlue);

    panels.add(
      MetricCardData(
        title: area.id == vision.kGlobalAreaId ? null : area.name,
        valueColor: valueColor,

        hero: HeroMetricData(
          value: '${metrics.currentOccupancy}',
          label: context.l.current_occupancy,
          valueColor: Colors.grey.shade900,
        ),

        activity: ActivityMetricData(
          passBy: '${metrics.passBy}',
          stayed: '${metrics.stay}',
          entered: '${metrics.entry}',
          exited: '${metrics.exit}',
        ),

        details: DetailMetricData(appeared: '${metrics.appear}', disappeared: '${metrics.disappear}'),

        summary: SummaryMetricData(
          avgOccupancy: metrics.avgOccupancy.toStringAsFixed(1),
          maxOccupancy: '${metrics.maxOccupancy}',
          avgDwell: metrics.avgDwellSec,
          maxDwell: metrics.maxDwellSec,
        ),
      ),
    );
  }

  return panels;
}

List<MetricCardData> mapPayloadMetricsToCardData({required List<core_domain.AreaPayload> areas}) {
  final orderedAreas = [...areas]..sort((a, b) => a.areaId.compareTo(b.areaId));

  return [
    for (final area in orderedAreas)
      MetricCardData(
        title: area.areaId == -1 ? null : 'Area ${area.areaId}',
        valueColor: Colors.white,

        hero: HeroMetricData(value: '-', label: 'Occupancy', valueColor: Colors.grey.shade900),

        activity: ActivityMetricData(
          passBy: '${area.passBy}',
          stayed: '${area.stay}',
          entered: '${area.entry}',
          exited: '${area.exit}',
        ),

        details: DetailMetricData(appeared: '${area.appear}', disappeared: '${area.disappear}'),

        summary: SummaryMetricData(
          avgOccupancy: area.avgOccupancy.toStringAsFixed(1),
          maxOccupancy: '${area.maxOccupancy}',
          avgDwell: area.avgDwellSec,
          maxDwell: area.maxDwellSec,
        ),
      ),
  ];
}
