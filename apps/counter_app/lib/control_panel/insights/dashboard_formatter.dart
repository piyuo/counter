import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../utils/format_compact_duration.dart';

String formatDashboardMetricHourlyTotal(
  BuildContext context,
  core_domain.DashboardMetric metric,
  double amount,
  int coveredSeconds,
  core_domain.DetectionType? detectionType,
) {
  switch (metric) {
    case core_domain.DashboardMetric.passBy:
    case core_domain.DashboardMetric.stagnant:
    case core_domain.DashboardMetric.entry:
    case core_domain.DashboardMetric.exit:
    case core_domain.DashboardMetric.appear:
    case core_domain.DashboardMetric.disappear:
      final rate = core_domain.hourlyRate(amount, coveredSeconds);
      return formatDashboardMetricValueUnit(context, metric, rate, detectionType);
    case core_domain.DashboardMetric.occupancyMean:
    case core_domain.DashboardMetric.occupancyPeak:
      return formatDashboardMetricValueUnit(context, metric, amount, detectionType);
    case core_domain.DashboardMetric.dwellTimeMean:
    case core_domain.DashboardMetric.dwellTimeMax:
      return formatDashboardMetricValueUnit(context, metric, amount, detectionType);
  }
}

String formatDashboardMetricLabel(BuildContext context, core_domain.DashboardMetric metric) => switch (metric) {
  core_domain.DashboardMetric.passBy => context.l.insight_pass_by,
  core_domain.DashboardMetric.stagnant => context.l.insight_stagnant,
  core_domain.DashboardMetric.entry => context.l.insight_entry,
  core_domain.DashboardMetric.exit => context.l.insight_exit,
  core_domain.DashboardMetric.appear => context.l.insight_appear,
  core_domain.DashboardMetric.disappear => context.l.insight_disappear,
  core_domain.DashboardMetric.occupancyMean => context.l.average_occupancy,
  core_domain.DashboardMetric.occupancyPeak => context.l.maximum_occupancy,
  core_domain.DashboardMetric.dwellTimeMean => context.l.insight_average_completed_visit,
  core_domain.DashboardMetric.dwellTimeMax => context.l.insight_longest_completed_visit,
};

NumberFormat getNumberFormatForDashboardMetric(
  BuildContext context,
  core_domain.DashboardMetric metric,
  double? value,
) {
  final locale = Localizations.localeOf(context).toString();

  final pattern = switch (metric) {
    core_domain.DashboardMetric.occupancyMean => '#,##0.##',
    _ => '#,##0',
  };

  return NumberFormat(pattern, locale);
}

String formatDashboardMetricValueUnit(
  BuildContext context,
  core_domain.DashboardMetric metric,
  double? amount,
  core_domain.DetectionType? detectionType,
) {
  if (amount == null) return '-';

  final formattedValue = formatDashboardMetricValue(context, metric, amount);

  final unit = formatDashboardMetricUnit(context, metric, detectionType, amount);

  return unit.isEmpty ? formattedValue : '$formattedValue $unit';
}

String formatDashboardMetricValue(BuildContext context, core_domain.DashboardMetric metric, double? value) {
  if (value == null) {
    return '-';
  }
  if (metric == core_domain.DashboardMetric.dwellTimeMean || metric == core_domain.DashboardMetric.dwellTimeMax) {
    return formatCompactDuration(context.l, value.round());
  }

  final numberFormat = getNumberFormatForDashboardMetric(context, metric, value);
  final formatted = numberFormat.format(value);
  return formatted;
}

String formatDashboardMetricUnit(
  BuildContext context,
  core_domain.DashboardMetric metric,
  core_domain.DetectionType? detectionType,
  double value,
) {
  if (metric == core_domain.DashboardMetric.dwellTimeMean || metric == core_domain.DashboardMetric.dwellTimeMax) {
    return ''; // value already use formatCompactDuration to show time (like 3m 2s)
  }

  if (metric == core_domain.DashboardMetric.occupancyMean || metric == core_domain.DashboardMetric.occupancyPeak) {
    return formatDetectionType(context, detectionType, value);
  }

  return context.l.insight_per_hour;
}

String formatDetectionType(BuildContext context, core_domain.DetectionType? detectionType, double value) {
  if (detectionType == null) {
    return '';
  }

  return switch (detectionType) {
    core_domain.DetectionType.people => context.l.detection_type_people,
    core_domain.DetectionType.vehicle =>
      value > 1 ? context.l.detection_type_vehicles : context.l.detection_type_vehicle,
  };
}

String formatDashboardMeasurement(BuildContext context, core_domain.DashboardMeasurement? measurement) {
  if (measurement == null) {
    return '—';
  }
  return formatDashboardMetricValue(context, measurement.metric, measurement.amount);
}

String formatDashboardMeasurementUnit(
  BuildContext context,
  core_domain.DashboardMeasurement? measurement,
  core_domain.DetectionType? detectionType,
) {
  if (measurement == null) {
    return '';
  }
  return formatDashboardMetricUnit(context, measurement.metric, detectionType, measurement.amount);
}

Color formatObservationStatusColor(BuildContext context, core_domain.ObservationStatus status) => switch (status) {
  core_domain.ObservationStatus.started => Colors.green,
  core_domain.ObservationStatus.interrupted => Colors.amber.shade900,
  core_domain.ObservationStatus.stopped => Theme.of(context).colorScheme.error,
};

String formatObservationStatusLabel(BuildContext context, core_domain.ObservationStatus status) => switch (status) {
  core_domain.ObservationStatus.started => context.l.observation_status_live,
  core_domain.ObservationStatus.interrupted => context.l.observation_status_interrupted,
  core_domain.ObservationStatus.stopped => context.l.observation_status_stopped,
};

String formatObservationStatusTooltip(BuildContext context, core_domain.ObservationStatus status) => switch (status) {
  core_domain.ObservationStatus.started => context.l.observation_status_live_description,
  core_domain.ObservationStatus.interrupted => context.l.observation_status_interrupted_description,
  core_domain.ObservationStatus.stopped => context.l.observation_status_stopped_description,
};

String formatTrafficComparisonPeriodLabel(BuildContext context, core_domain.TrafficComparisonPeriod period) =>
    switch (period) {
      core_domain.TrafficComparisonPeriod.yesterday => context.l.insight_comparison_yesterday,
      core_domain.TrafficComparisonPeriod.sameDayLastWeek => context.l.insight_comparison_last_week,
      core_domain.TrafficComparisonPeriod.lastMonthAverage => context.l.insight_comparison_monthly,
      core_domain.TrafficComparisonPeriod.lastYearAverage => context.l.insight_comparison_yearly,
    };
