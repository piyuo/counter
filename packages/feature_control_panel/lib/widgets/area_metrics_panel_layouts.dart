// TOC:
//  - buildVisionAreaMetricPanels: maps live vision area metrics to shared AreaMetricsPanels models
//  - buildPayloadAreaMetricPanels: maps telemetry payload area metrics to shared AreaMetricsPanels models

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/widgets/area_metrics_panels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;

String _stripColon(String s) {
  final trimmed = s.trimRight();
  return trimmed.endsWith(':') ? trimmed.substring(0, trimmed.length - 1).trimRight() : trimmed;
}

String _formatSeconds(int totalSeconds) {
  if (totalSeconds < 60) return '${totalSeconds}s';
  final minutes = totalSeconds ~/ 60;
  final seconds = totalSeconds % 60;
  return '$minutes:${seconds.toString().padLeft(2, '0')}';
}

List<AreaMetricsPanelModel> buildVisionAreaMetricPanels({
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

  final panels = <AreaMetricsPanelModel>[];

  for (final area in orderedAreas) {
    final metrics = windowCount.areas[area.id];
    if (metrics == null) continue;

    final valueColor = area.id == vision.kGlobalAreaId ? Colors.lightBlue : (areaColors[area.id] ?? Colors.lightBlue);

    panels.add(
      AreaMetricsPanelModel(
        title: area.id == vision.kGlobalAreaId ? null : area.name,
        valueColor: valueColor,
        grids: [
          AreaMetricGridModel(
            crossAxisCount: 3,
            mainAxisExtent: 82,
            cells: [
              AreaMetricCell(value: '${metrics.currentOccupancy}', label: 'Occupancy', valueColor: Colors.white),
              AreaMetricCell(value: '${metrics.passBy}', label: 'Passed By'),
              AreaMetricCell(value: '${metrics.stay}', label: _stripColon('Stayed')),
            ],
          ),
          AreaMetricGridModel(
            crossAxisCount: 4,
            mainAxisExtent: 70,
            cells: [
              AreaMetricCell(value: '${metrics.entry}', label: 'Entered', compact: true),
              AreaMetricCell(value: '${metrics.exit}', label: 'Exited', compact: true),
              AreaMetricCell(value: '${metrics.appear}', label: 'Appeared', compact: true),
              AreaMetricCell(value: '${metrics.disappear}', label: 'Disappeared', compact: true),
            ],
          ),
          AreaMetricGridModel(
            crossAxisCount: 2,
            mainAxisExtent: 78,
            showTopDivider: true,
            cells: [
              AreaMetricCell(value: metrics.occupancyAvg.toStringAsFixed(1), label: _stripColon(countAvgOccLabel)),
              AreaMetricCell(value: '${metrics.occupancyPeak}', label: countMaxOccLabel),
            ],
          ),
          AreaMetricGridModel(
            crossAxisCount: 2,
            mainAxisExtent: 78,
            cells: [
              AreaMetricCell(
                value: metrics.dwellAvgSec.toStringAsFixed(1),
                valueSuffix: 's',
                label: countAvgDwellLabel,
              ),
              AreaMetricCell(value: _formatSeconds(metrics.dwellPeakSec), label: countMaxDwellLabel),
            ],
          ),
        ],
      ),
    );
  }

  return panels;
}

List<AreaMetricsPanelModel> buildPayloadAreaMetricPanels({required List<core_domain.AreaPayload> areas}) {
  final orderedAreas = [...areas]
    ..sort((a, b) {
      return a.id.compareTo(b.id);
    });

  return [
    for (final area in orderedAreas)
      AreaMetricsPanelModel(
        title: area.id == -1 ? null : 'Area ${area.id}',
        valueColor: Colors.white,
        grids: [
          AreaMetricGridModel(
            crossAxisCount: 2,
            mainAxisExtent: 82,
            cells: [
              AreaMetricCell(value: '${area.passBy}', label: 'Passed By'),
              AreaMetricCell(value: '${area.stay}', label: _stripColon('Stayed')),
            ],
          ),
          AreaMetricGridModel(
            crossAxisCount: 4,
            mainAxisExtent: 70,
            cells: [
              AreaMetricCell(value: '${area.entry}', label: 'Entered'),
              AreaMetricCell(value: '${area.exit}', label: 'Exited'),
              AreaMetricCell(value: '${area.appear}', label: 'Appeared', compact: true),
              AreaMetricCell(value: '${area.disappear}', label: 'Disappeared', compact: true),
            ],
          ),
          AreaMetricGridModel(
            crossAxisCount: 2,
            mainAxisExtent: 78,
            cells: [
              AreaMetricCell(value: area.occupancyAvg.toStringAsFixed(1), label: 'Avg Occ'),
              AreaMetricCell(value: '${area.occupancyPeak}', label: 'Max Occ'),
            ],
          ),
          AreaMetricGridModel(
            crossAxisCount: 2,
            mainAxisExtent: 78,
            cells: [
              AreaMetricCell(value: area.dwellAvgSec.toStringAsFixed(1), valueSuffix: 's', label: 'Avg Dwell'),
              AreaMetricCell(value: core_domain.formatSeconds(area.dwellPeakSec), label: 'Max Dwell'),
            ],
          ),
        ],
      ),
  ];
}
