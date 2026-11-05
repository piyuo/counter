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
    final areaDatas = ref.watch(insightAreaDataProvider);
    void onComparisonChanged(core_domain.TrafficComparisonPeriod period) {
      final service = ref.read(core_domain.insightServiceProvider);
      service.setComparisonPeriod(period);
      unawaited(service.refresh());
    }

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
        for (final areaData in areaDatas)
          AreaInsightSection(
            key: ValueKey(areaData.areaId),
            areaData: areaData,
            comparisonPeriod: dashboard.comparisonPeriod,
            onComparisonChanged: onComparisonChanged,
            observationStatus: observationStatus,
          ),
      ],
    );
  }
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
