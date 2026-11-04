import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/core_runtime.dart' as core_runtime;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_l10n/shared_l10n.dart';

import 'insight_widgets.dart';

final insightAreaDataProvider = Provider<List<core_domain.InsightAreaData>>((ref) {
  final dashboard = ref.watch(core_domain.insightDashboardProvider);
  final appState = ref.watch(core_domain.appProvider).asData?.value;
  final configuredAreas = ref.watch(core_runtime.interestAreaProvider.select((state) => state.areas));
  return const core_domain.InsightDashboardDataBuilder().build(
    dashboard: dashboard,
    customAreas: configuredAreas,
    businessPeriods: appState?.businessPeriods ?? core_domain.BusinessPeriod.defaultSchedule,
    now: DateTime.now(),
  );
});

class InsightDisplay extends ConsumerWidget {
  const InsightDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboard = ref.watch(core_domain.insightDashboardProvider);
    final appState = ref.watch(core_domain.appProvider);
    final observationStatus = ref.watch(core_domain.observationProvider).status;
    final areas = ref.watch(insightAreaDataProvider);

    if (appState.hasError) {
      return _DashboardMessage(icon: Icons.error_outline, message: context.l.insight_error);
    }
    if (dashboard.businessDate.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _DisplayToolbar(
          comparisonPeriod: dashboard.comparisonPeriod,
          onComparisonChanged: (period) {
            final service = ref.read(core_domain.insightServiceProvider);
            service.setComparisonPeriod(period);
            unawaited(service.refresh());
          },
        ),
        for (final area in areas)
          AreaInsightSection(
            key: ValueKey(area.areaId),
            area: area,
            comparisonPeriod: dashboard.comparisonPeriod,
            observationStatus: observationStatus,
          ),
      ],
    );
  }
}

class _DisplayToolbar extends StatelessWidget {
  const _DisplayToolbar({required this.comparisonPeriod, required this.onComparisonChanged});

  final core_domain.TrafficComparisonPeriod comparisonPeriod;
  final ValueChanged<core_domain.TrafficComparisonPeriod> onComparisonChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 8, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                context.l.insight_dashboard_title,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Row(
            children: [
              Text(context.l.insight_compare_with, style: theme.textTheme.labelLarge),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<core_domain.TrafficComparisonPeriod>(
                    value: comparisonPeriod,
                    isDense: true,
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(8),
                    style: theme.textTheme.labelLarge,
                    onChanged: (period) {
                      if (period != null) onComparisonChanged(period);
                    },
                    items: [
                      for (final period in core_domain.TrafficComparisonPeriod.values)
                        DropdownMenuItem(value: period, child: Text(_comparisonLabel(context, period))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _comparisonLabel(BuildContext context, core_domain.TrafficComparisonPeriod period) => switch (period) {
    core_domain.TrafficComparisonPeriod.yesterday => context.l.insight_comparison_yesterday,
    core_domain.TrafficComparisonPeriod.sameDayLastWeek => context.l.insight_comparison_last_week,
    core_domain.TrafficComparisonPeriod.monthlyAverage => context.l.insight_comparison_monthly,
    core_domain.TrafficComparisonPeriod.yearlyAverage => context.l.insight_comparison_yearly,
  };
}

class _DashboardMessage extends StatelessWidget {
  const _DashboardMessage({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Expanded(child: Text(message, style: Theme.of(context).textTheme.bodyMedium)),
      ],
    ),
  );
}
