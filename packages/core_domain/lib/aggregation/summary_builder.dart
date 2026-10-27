// TOC
// 1. SummaryBuilder — Build day, month, and year summaries

import 'package:core_domain/model/observation_granularity.dart';

import '../model/day_summary.dart';
import '../model/month_summary.dart';
import '../model/observation.dart';
import '../model/observation_series.dart';
import '../model/year_summary.dart';
import 'observation_rollup.dart';

/// Creates period summaries from their source observations or child summaries.
class SummaryBuilder {
  const SummaryBuilder() : _observationRollup = const ObservationRollup();

  final ObservationRollup _observationRollup;

  /// Creates a day summary from its first five-minute observation.
  DaySummary createDaySummary(Observation observation) {
    _assertFiveMinute(observation);
    return _buildDaySummary(observation.year, observation.month, observation.day, [observation]);
  }

  /// Adds a five-minute observation, retaining the first value for a duplicate slot.
  DaySummary addObservationToDay(DaySummary summary, Observation observation) {
    _assertFiveMinute(observation);
    if (observation.year != summary.year || observation.month != summary.month || observation.day != summary.day) {
      throw ArgumentError.value(observation, 'observation', 'must belong to the summary business date');
    }
    if (summary.fiveMinuteObservations.any((existing) => existing.timeKey == observation.timeKey)) {
      return summary;
    }

    return _buildDaySummary(summary.year, summary.month, summary.day, [...summary.fiveMinuteObservations, observation]);
  }

  /// Creates a month summary from available daily summaries.
  ///
  /// Matching five-minute time slots are averaged across source days. Missing
  /// slots are omitted rather than treated as zero.
  MonthSummary createMonthSummary(List<DaySummary> sourceDays) {
    if (sourceDays.isEmpty) {
      throw ArgumentError.value(sourceDays, 'sourceDays', 'must not be empty');
    }

    final days = List<DaySummary>.of(sourceDays)
      ..sort((left, right) => left.businessDate.compareTo(right.businessDate));
    final first = days.first;
    final seenDates = <String>{};
    for (final day in days) {
      if (day.year != first.year || day.month != first.month) {
        throw ArgumentError.value(day, 'sourceDays', 'must belong to the same business month');
      }
      if (!seenDates.add(day.businessDate)) {
        throw ArgumentError.value(day.businessDate, 'sourceDays', 'must not contain duplicate days');
      }
      _validateDaySources(day);
    }

    final dailyTotals = [for (final day in days) day.dailyTotal];
    final hourlyTotals = [for (final day in days) ...day.hourlyTotals]..sort(_compareBusinessDateTime);
    return MonthSummary(
      year: first.year,
      month: first.month,
      weekdayFiveMinuteObservation: ObservationSeries.fromObservations(
        _observationRollup
            .averageFiveMinuteProfiles([
              for (final day in days)
                [
                  for (final observation in day.fiveMinuteObservations)
                    if (!observation.isWeekend) observation,
                ],
            ])
            .map((observation) => observation.copyWith(year: first.year, month: first.month, day: 1)),
      ),
      weekendFiveMinuteObservation: ObservationSeries.fromObservations(
        _observationRollup
            .averageFiveMinuteProfiles([
              for (final day in days)
                [
                  for (final observation in day.fiveMinuteObservations)
                    if (observation.isWeekend) observation,
                ],
            ])
            .map((observation) => observation.copyWith(year: first.year, month: first.month, day: 1)),
      ),
      hourlyTotals: hourlyTotals,
      dailyTotals: dailyTotals,
      monthlyTotal: _observationRollup.aggregate(dailyTotals, granularity: ObservationGranularity.month),
    );
  }

  /// Creates a year summary from available month summaries.
  ///
  /// Matching five-minute time slots are averaged equally across available
  /// month profiles. Missing slots are omitted rather than treated as zero.
  YearSummary createYearSummary(List<MonthSummary> sourceMonths) {
    if (sourceMonths.isEmpty) {
      throw ArgumentError.value(sourceMonths, 'sourceMonths', 'must not be empty');
    }

    final months = List<MonthSummary>.of(sourceMonths)..sort((left, right) => left.month.compareTo(right.month));
    final year = months.first.year;
    final seenMonths = <int>{};
    for (final month in months) {
      if (month.year != year) {
        throw ArgumentError.value(month, 'sourceMonths', 'must belong to the same business year');
      }
      if (!seenMonths.add(month.month)) {
        throw ArgumentError.value(month.month, 'sourceMonths', 'must not contain duplicate months');
      }
      _validateMonthSources(month);
    }

    final dailyObservations = [for (final month in months) ...month.dailyTotals]..sort(_compareBusinessDateTime);
    final monthlyObservations = [for (final month in months) month.monthlyTotal];
    final monthlyWeekdayProfiles = [for (final month in months) month.weekdayFiveMinuteObservation];
    final monthlyWeekendProfiles = [for (final month in months) month.weekendFiveMinuteObservation];
    return YearSummary(
      year: year,
      weekdayFiveMinuteObservation: ObservationSeries.fromObservations(
        _observationRollup
            .averageFiveMinuteProfiles(monthlyWeekdayProfiles)
            .map((observation) => observation.copyWith(year: year, month: 1, day: 1)),
      ),
      weekendFiveMinuteObservation: ObservationSeries.fromObservations(
        _observationRollup
            .averageFiveMinuteProfiles(monthlyWeekendProfiles)
            .map((observation) => observation.copyWith(year: year, month: 1, day: 1)),
      ),
      dailyTotals: dailyObservations,
      monthlyTotals: monthlyObservations,
      yearlyTotal: _observationRollup.aggregate(monthlyObservations, granularity: ObservationGranularity.year),
    );
  }

  DaySummary _buildDaySummary(int year, int month, int day, List<Observation> sources) {
    final observations = List<Observation>.of(sources)..sort((left, right) => left.timeKey.compareTo(right.timeKey));
    final observationsByHour = <int, List<Observation>>{};
    for (final observation in observations) {
      _assertFiveMinute(observation);
      if (observation.year != year || observation.month != month || observation.day != day) {
        throw ArgumentError.value(observation, 'observations', 'must belong to the summary business date');
      }
      observationsByHour.putIfAbsent(observation.hour, () => []).add(observation);
    }

    final hourlyObservations = observationsByHour.values
        .map(
          (hourObservations) =>
              _observationRollup.aggregate(hourObservations, granularity: ObservationGranularity.hour),
        )
        .toList();
    return DaySummary(
      year: year,
      month: month,
      day: day,
      fiveMinuteObservations: ObservationSeries.fromObservations(observations),
      hourlyTotals: hourlyObservations,
      dailyTotal: _observationRollup.aggregate(observations, granularity: ObservationGranularity.day),
    );
  }

  void _validateDaySources(DaySummary summary) {
    final dailyTotal = summary.dailyTotal;
    if (dailyTotal.granularity != ObservationGranularity.day ||
        dailyTotal.year != summary.year ||
        dailyTotal.month != summary.month ||
        dailyTotal.day != summary.day) {
      throw ArgumentError.value(summary, 'sourceDays', 'daily observation must match its day summary');
    }
    for (final observation in summary.hourlyTotals) {
      if (observation.granularity != ObservationGranularity.hour ||
          observation.year != summary.year ||
          observation.month != summary.month ||
          observation.day != summary.day) {
        throw ArgumentError.value(summary, 'sourceDays', 'hourly observations must match their day summary');
      }
    }
    for (final observation in summary.fiveMinuteObservations) {
      _assertFiveMinute(observation);
      if (observation.year != summary.year || observation.month != summary.month || observation.day != summary.day) {
        throw ArgumentError.value(summary, 'sourceDays', 'five-minute observations must match their day summary');
      }
    }
  }

  void _validateMonthSources(MonthSummary summary) {
    if (summary.monthlyTotal.granularity != ObservationGranularity.month ||
        summary.monthlyTotal.year != summary.year ||
        summary.monthlyTotal.month != summary.month) {
      throw ArgumentError.value(summary, 'sourceMonths', 'monthly observation must match its month summary');
    }
    for (final observation in summary.dailyTotals) {
      if (observation.granularity != ObservationGranularity.day ||
          observation.year != summary.year ||
          observation.month != summary.month) {
        throw ArgumentError.value(summary, 'sourceMonths', 'daily observations must match their month summary');
      }
    }
    for (final observation in summary.hourlyTotals) {
      if (observation.granularity != ObservationGranularity.hour ||
          observation.year != summary.year ||
          observation.month != summary.month) {
        throw ArgumentError.value(summary, 'sourceMonths', 'hourly observations must match their month summary');
      }
    }
    for (final observation in summary.weekdayFiveMinuteObservation) {
      _validateMonthProfile(observation, summary, isWeekend: false);
    }
    for (final observation in summary.weekendFiveMinuteObservation) {
      _validateMonthProfile(observation, summary, isWeekend: true);
    }
  }

  void _validateMonthProfile(Observation observation, MonthSummary summary, {required bool isWeekend}) {
    _assertFiveMinute(observation);
    if (observation.year != summary.year ||
        observation.month != summary.month ||
        observation.day != 1 ||
        observation.isWeekend != isWeekend) {
      final category = isWeekend ? 'weekend' : 'weekday';
      throw ArgumentError.value(
        summary,
        'sourceMonths',
        'five-minute $category profile must use the normalized month date',
      );
    }
  }

  void _assertFiveMinute(Observation observation) {
    assert(
      observation.granularity == ObservationGranularity.minutes5,
      'SummaryBuilder accepts only minutes5 source observations',
    );
  }

  int _compareBusinessDateTime(Observation left, Observation right) {
    final components = [
      (left.year, right.year),
      (left.month, right.month),
      (left.day, right.day),
      (left.hour, right.hour),
      (left.minute, right.minute),
    ];
    for (final (leftValue, rightValue) in components) {
      final comparison = leftValue.compareTo(rightValue);
      if (comparison != 0) return comparison;
    }
    return 0;
  }
}
