import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../utils/format_compact_duration.dart';

String formatMetricHourlyRate(
  BuildContext context,
  core_domain.DashboardMetric metric,
  double count,
  int coveredSeconds,
  core_domain.DetectionType detectionType,
) {
  switch (metric) {
    case core_domain.DashboardMetric.passBy:
    case core_domain.DashboardMetric.stagnant:
    case core_domain.DashboardMetric.entry:
    case core_domain.DashboardMetric.exit:
    case core_domain.DashboardMetric.appear:
    case core_domain.DashboardMetric.disappear:
      final rate = core_domain.hourlyRate(count, coveredSeconds);
      return formatDashboardMetricValueUnit(context, metric, rate, detectionType);
    case core_domain.DashboardMetric.occupancyMean:
    case core_domain.DashboardMetric.occupancyPeak:
      return formatDashboardMetricValueUnit(context, metric, count, detectionType);
    case core_domain.DashboardMetric.dwellTimeMean:
    case core_domain.DashboardMetric.dwellTimeMax:
      return formatDashboardMetricValueUnit(context, metric, count, detectionType);
  }
}

String formatMetricLabel(BuildContext context, core_domain.DashboardMetric metric) => switch (metric) {
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

NumberFormat getNumberFormatForMetric(BuildContext context, core_domain.DashboardMetric metric, double? value) {
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
  double? value,
  core_domain.DetectionType detectionType,
) {
  if (value == null) return '-';

  final formattedValue = formatDashboardMetricValue(context, metric, value);

  final unit = formatDashboardMetricUnit(context, metric, detectionType);

  return unit.isEmpty ? formattedValue : '$formattedValue $unit';
}

String formatDashboardMetricValue(BuildContext context, core_domain.DashboardMetric metric, double? value) {
  if (value == null) {
    return '-';
  }
  if (metric == core_domain.DashboardMetric.dwellTimeMean || metric == core_domain.DashboardMetric.dwellTimeMax) {
    return formatCompactDuration(context.l, value.round());
  }

  final numberFormat = getNumberFormatForMetric(context, metric, value);
  final formatted = numberFormat.format(value);
  return formatted;
}

String formatDashboardMetricUnit(
  BuildContext context,
  core_domain.DashboardMetric metric,
  core_domain.DetectionType detectionType,
) {
  if (metric == core_domain.DashboardMetric.dwellTimeMean || metric == core_domain.DashboardMetric.dwellTimeMax) {
    return ''; // value already use formatCompactDuration to show time (like 3m 2s)
  }

  if (metric == core_domain.DashboardMetric.occupancyMean || metric == core_domain.DashboardMetric.occupancyPeak) {
    return formatDetectionType(context, detectionType);
  }

  return context.l.insight_tracks_per_hour;
}

String formatDetectionType(BuildContext context, core_domain.DetectionType detectionType) {
  return switch (detectionType) {
    core_domain.DetectionType.people => context.l.detection_type_people,
    core_domain.DetectionType.vehicle => context.l.detection_type_vehicle,
  };
}

String formatDashboardMeasurement(BuildContext context, core_domain.DashboardMeasurement? measurement) {
  if (measurement == null) {
    return '—';
  }

  final locale = Localizations.localeOf(context).toString();
  final value = measurement.amount;
  if (measurement.unit == core_domain.DashboardMeasurementUnit.seconds) {
    return formatCompactDuration(context.l, value.round());
  } else if (measurement.unit == core_domain.DashboardMeasurementUnit.minutes) {
    return formatCompactDuration(context.l, (value * 60).round());
  } else if (measurement.unit == core_domain.DashboardMeasurementUnit.objects) {
    return NumberFormat('0.##', locale).format(value);
  } // count per hour
  return NumberFormat(value >= 10 ? '#,##0' : '0.##', locale).format(value);
}

String formatDashboardMeasurementUnit(BuildContext context, core_domain.DashboardMeasurement? measurement) {
  if (measurement == null) {
    return '';
  }
  return switch (measurement.unit) {
    core_domain.DashboardMeasurementUnit.objects => context.l.insight_objects_unit,
    core_domain.DashboardMeasurementUnit.countPerHour => context.l.insight_tracks_per_hour,
    core_domain.DashboardMeasurementUnit.count ||
    core_domain.DashboardMeasurementUnit.seconds ||
    core_domain.DashboardMeasurementUnit.minutes => '',
  };
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
