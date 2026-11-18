import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../utils/format_compact_duration.dart';

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

String formatDashboardValue(BuildContext context, double value) {
  final locale = Localizations.localeOf(context).toString();
  final wholeNumberFormat = NumberFormat.decimalPattern(locale)..maximumFractionDigits = 0;
  return wholeNumberFormat.format(value);
}

String formatSeconds(BuildContext context, int seconds) {
  final locale = Localizations.localeOf(context).toString();
  final wholeNumberFormat = NumberFormat.decimalPattern(locale)..maximumFractionDigits = 0;
  return wholeNumberFormat.format(seconds);
}

String formatCoverSeconds(BuildContext context, int seconds) {
  if (seconds < 60) {
    return context.l.insight_based_on_sec(seconds);
  }
  final baseOnMinutes = (seconds / 60).round();
  return context.l.insight_based_on_min(baseOnMinutes.toString());
}

String formatPercentString(BuildContext context, double value) {
  final locale = Localizations.localeOf(context).toString();
  return NumberFormat.percentPattern(locale).format(value);
}

String formatDashboardMetricSum(
  BuildContext context,
  core_domain.DashboardMetric metric,
  double amount,
  core_domain.DetectionType? detectionType,
) {
  switch (metric) {
    case core_domain.DashboardMetric.passBy:
    case core_domain.DashboardMetric.stagnant:
    case core_domain.DashboardMetric.entry:
    case core_domain.DashboardMetric.exit:
    case core_domain.DashboardMetric.appear:
    case core_domain.DashboardMetric.disappear:
      return formatDashboardMetricValue(context, metric, amount);
    case core_domain.DashboardMetric.occupancyMean:
    case core_domain.DashboardMetric.occupancyMax:
      return formatDashboardMetricValueUnit(context, metric, amount, detectionType);
    case core_domain.DashboardMetric.dwellTimeMean:
    case core_domain.DashboardMetric.dwellTimeMax:
      return formatDashboardMetricValueUnit(context, metric, amount, detectionType);
  }
}

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
    case core_domain.DashboardMetric.occupancyMax:
      return formatDashboardMetricValueUnit(context, metric, amount, detectionType);
    case core_domain.DashboardMetric.dwellTimeMean:
    case core_domain.DashboardMetric.dwellTimeMax:
      return formatDashboardMetricValueUnit(context, metric, amount, detectionType);
  }
}

String formatMetricLabel(BuildContext context, core_domain.DashboardMetric metric) => switch (metric) {
  core_domain.DashboardMetric.passBy => context.l.pass_by,
  core_domain.DashboardMetric.stagnant => context.l.stagnant,
  core_domain.DashboardMetric.entry => context.l.entry,
  core_domain.DashboardMetric.exit => context.l.exit,
  core_domain.DashboardMetric.appear => context.l.appear,
  core_domain.DashboardMetric.disappear => context.l.disappear,
  core_domain.DashboardMetric.occupancyMean => context.l.occupancy_mean,
  core_domain.DashboardMetric.occupancyMax => context.l.occupancy_max,
  core_domain.DashboardMetric.dwellTimeMean => context.l.dwell_time_mean,
  core_domain.DashboardMetric.dwellTimeMax => context.l.dwell_time_max,
};

String formatMetricHelp(BuildContext context, core_domain.DashboardMetric metric) {
  final help = switch (metric) {
    core_domain.DashboardMetric.passBy => context.l.pass_by_help,
    core_domain.DashboardMetric.stagnant => context.l.stagnant_help,
    core_domain.DashboardMetric.entry => context.l.entry_help,
    core_domain.DashboardMetric.exit => context.l.exit_help,
    core_domain.DashboardMetric.appear => context.l.appear_help,
    core_domain.DashboardMetric.disappear => context.l.disappear_help,
    core_domain.DashboardMetric.occupancyMean => context.l.occupancy_mean_help,
    core_domain.DashboardMetric.occupancyMax => context.l.occupancy_max_help,
    core_domain.DashboardMetric.dwellTimeMean => context.l.dwell_time_mean_help,
    core_domain.DashboardMetric.dwellTimeMax => context.l.dwell_time_max_help,
  };
  return help.replaceAll(r'\n', '\n');
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
    return formatCompactDuration(context, value.round());
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

  if (metric == core_domain.DashboardMetric.occupancyMean || metric == core_domain.DashboardMetric.occupancyMax) {
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

String formatTrafficPeriodLabel(BuildContext context, core_domain.TrafficPeriod period) => switch (period) {
  core_domain.TrafficPeriod.liveToday => context.l.traffic_period_live_today,
  core_domain.TrafficPeriod.today => context.l.traffic_period_today,
  core_domain.TrafficPeriod.yesterday => context.l.traffic_period_yesterday,
  core_domain.TrafficPeriod.sameDayLastWeek => context.l.traffic_period_last_week,
  core_domain.TrafficPeriod.lastMonthAverage => context.l.traffic_period_last_month,
  core_domain.TrafficPeriod.lastYearAverage => context.l.traffic_period_last_year,
  core_domain.TrafficPeriod.customDay => context.l.traffic_period_custom_day,
};
