import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:shared_l10n/shared_l10n.dart';

String insightComparisonPeriodLabel(BuildContext context, core_domain.TrafficComparisonPeriod period) =>
    switch (period) {
      core_domain.TrafficComparisonPeriod.yesterday => context.l.insight_comparison_yesterday,
      core_domain.TrafficComparisonPeriod.sameDayLastWeek => context.l.insight_comparison_last_week,
      core_domain.TrafficComparisonPeriod.monthlyAverage => context.l.insight_comparison_monthly,
      core_domain.TrafficComparisonPeriod.yearlyAverage => context.l.insight_comparison_yearly,
    };
