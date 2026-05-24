// TOC:
//  - MetricsAreaSections: renders global + per-area metric blocks
//  - maps vision metrics through shared area metrics panel layout builder

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/widgets/area_metrics_panel_layouts.dart';
import 'package:feature_control_panel/widgets/area_metrics_panels.dart';
import 'package:feature_control_panel/widgets/window_progress_display.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:intl/intl.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;

const _kBackgroundColor = Color(0xFFF5F5F5);

class MetricsAreaSections extends ConsumerWidget {
  const MetricsAreaSections({required this.areaState, super.key});

  final vision.InterestAreaState areaState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windowCount = ref.watch(vision.windowCountProvider);
    if (windowCount.isSessionReady == false) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Center(child: GlassProgressIndicator.circular(size: 36)),
      );
    }

    final locale = Localizations.localeOf(context).toString();

    final panels = buildVisionAreaMetricPanels(
      windowCount: windowCount,
      areaState: areaState,
      countAvgOccLabel: context.l.count_avg_occ,
      countMaxOccLabel: context.l.count_max_occ,
      countAvgDwellLabel: context.l.count_avg_dwell,
      countMaxDwellLabel: context.l.count_max_dwell,
    );

    return Column(
      children: [
        feature_pip.PipPanel(
          backgroundColor: _kBackgroundColor,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                title: Text(
                  '${DateFormat.jm(locale).format(windowCount.startUtc.toLocal())} - ${DateFormat.jm(locale).format(windowCount.endUtc.toLocal())}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey.shade900),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey.shade800),
                onTap: () {
                  ref.push(const core_domain.OpenPayloadsRecent());
                },
              ),
              WindowProgressDisplay(windowCount: windowCount),
            ],
          ),
        ),

        const SizedBox(height: 8),
        AreaMetricsPanels(panels: panels, backgroundColor: _kBackgroundColor),
      ],
    );
  }
}
