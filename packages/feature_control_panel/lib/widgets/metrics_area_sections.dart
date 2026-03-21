// TOC:
//  - MetricsAreaSections: renders global + per-area metric blocks
//  - maps vision metrics through shared area metrics panel layout builder

import 'package:feature_control_panel/widgets/area_metrics_panel_layouts.dart';
import 'package:feature_control_panel/widgets/area_metrics_panels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;

class MetricsAreaSections extends StatelessWidget {
  const MetricsAreaSections({required this.windowCount, required this.areaState, super.key});

  final vision.WindowCountState windowCount;
  final vision.InterestAreaState areaState;

  @override
  Widget build(BuildContext context) {
    final panels = buildVisionAreaMetricPanels(
      windowCount: windowCount,
      areaState: areaState,
      countAvgOccLabel: context.l.count_avg_occ,
      countMaxOccLabel: context.l.count_max_occ,
      countAvgDwellLabel: context.l.count_avg_dwell,
      countMaxDwellLabel: context.l.count_max_dwell,
    );

    return AreaMetricsPanels(panels: panels);
  }
}
