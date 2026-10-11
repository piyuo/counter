// TOC:
//  - MetricsAreaSections: renders global + per-area metric blocks
//  - maps vision metrics through shared area metrics panel layout builder

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/core_runtime.dart' as core_runtime;
import 'package:counter_app/control_panel/widgets/metrics_cards.dart';
import 'package:counter_app/control_panel/widgets/metrics_utils.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;

const _kWhiteBoardColor = Color(0xFFF5F5F5);

class MetricsDashboard extends ConsumerWidget {
  const MetricsDashboard({required this.areaState, super.key});

  final core_domain.InterestAreaState areaState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final observation = ref.watch(core_runtime.observationProvider);
    final windowStart = observation.dateTime;
    final windowEnd = windowStart.add(core_domain.kWindowDuration);

    final locale = Localizations.localeOf(context).toString();

    final panels = mapVisionMetricsToCardData(
      context,
      observation: observation,
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
                  '${DateFormat.jm(locale).format(windowStart)} - ${DateFormat.jm(locale).format(windowEnd)}',
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
            ],
          ),
        ),
        MetricCards(panels: panels, backgroundColor: _kWhiteBoardColor),
      ],
    );
  }
}
