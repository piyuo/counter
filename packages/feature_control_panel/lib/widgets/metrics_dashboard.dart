// TOC:
//  - MetricsAreaSections: renders global + per-area metric blocks
//  - maps vision metrics through shared area metrics panel layout builder

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/widgets/metrics_cards.dart';
import 'package:feature_control_panel/widgets/metrics_utils.dart';
import 'package:feature_control_panel/widgets/window_progress_display.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:intl/intl.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;

const _kWhiteBoardColor = Color(0xFFF5F5F5);

class MetricsDashboard extends ConsumerWidget {
  const MetricsDashboard({required this.areaState, super.key});

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

    final panels = mapVisionMetricsToCardData(
      context,
      windowCount: windowCount,
      areaState: areaState,
      countAvgOccLabel: context.l.average_occupancy,
      countMaxOccLabel: context.l.maximum_occupancy,
      countAvgDwellLabel: context.l.average_stay,
      countMaxDwellLabel: context.l.maximum_stay,
    );

    return Column(
      children: [
        Text(context.l.metrics_counting_window, style: TextStyle(fontSize: 12, color: Colors.grey.shade400)),
        feature_pip.PipPanel(
          backgroundColor: _kWhiteBoardColor,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.access_time, color: Colors.grey.shade800),
                contentPadding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                title: Text(
                  '${DateFormat.jm(locale).format(windowCount.startUtc.toLocal())} - ${DateFormat.jm(locale).format(windowCount.endUtc.toLocal())}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey.shade900),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(context.l.metrics_counting_all, style: TextStyle(fontSize: 14, color: Colors.grey.shade800)),
                    const SizedBox(width: 10),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey.shade800),
                  ],
                ),
                onTap: () {
                  ref.push(const core_domain.OpenPayloadsRecent());
                },
              ),
              WindowProgressDisplay(windowCount: windowCount),
            ],
          ),
        ),
        MetricCards(panels: panels, backgroundColor: _kWhiteBoardColor),
      ],
    );
  }
}
