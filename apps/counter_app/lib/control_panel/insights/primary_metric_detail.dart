import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/control_panel/insights/dashboard_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'observation_tile.dart';

class PrimaryMetricDetail extends ConsumerStatefulWidget {
  const PrimaryMetricDetail({required this.areaId, required this.metric, super.key});

  final int areaId;
  final core_domain.DashboardMetric metric;

  @override
  ConsumerState<PrimaryMetricDetail> createState() => _PrimaryMetricDetailState();
}

class _PrimaryMetricDetailState extends ConsumerState<PrimaryMetricDetail> {
  bool _isRecentHourExpanded = true;

  @override
  Widget build(BuildContext context) {
    ref.watch(core_domain.dashboardStateProvider);
    final appState = ref.watch(core_domain.appProvider).asData?.value;
    final detectionType = appState?.detectionType;
    final card = ref.read(core_domain.dashboardServiceProvider).findCard(widget.areaId, widget.metric);
    final primaryMeasure = card?.primary;
    if (primaryMeasure == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final recentHourObservations = card?.recentHourObservations;
    final metricHelp = formatMetricHelp(context, primaryMeasure.metric);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Text(metricHelp, style: theme.textTheme.bodySmall),
        ),
        if (recentHourObservations != null && recentHourObservations.isNotEmpty)
          ObservationTile(
            initiallyExpanded: true,
            isExpanded: _isRecentHourExpanded,
            onExpansionChanged: (expanded) => setState(() => _isRecentHourExpanded = expanded),
            observations: recentHourObservations.items,
            expectedSeconds: 3600, // observations only content recent hour
            areaId: widget.areaId,
            metric: widget.metric,
            measurement: primaryMeasure,
            timeFormat: DateFormat.Hm(Localizations.localeOf(context).toString()),
            detectionType: detectionType,
            minTileHeight: 32,
            titleBuilder: (_) => const SizedBox.shrink(),
            trailingBuilder: (timeText) => Text(
              timeText,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 32,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ),
      ],
    );
  }
}
