import 'package:core_domain/model/observation.dart';
import 'package:core_domain/model/observation_series.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'insight_dashboard.freezed.dart';

/// Historical period used as a reference for traffic comparisons.
///
/// Comparisons are aligned to the same business-local
/// wall-clock time window as the current traffic.
enum TrafficComparisonPeriod {
  /// Same time window yesterday.
  yesterday,

  /// Same time window seven days ago.
  sameDayLastWeek,

  /// Typical traffic for the same time window this month.
  monthlyAverage,

  /// Typical traffic for the same time window this year.
  yearlyAverage,
}

/// Traffic dashboard data for the Piyuo Counter main screen.
///
/// Provides a quick overview of foot traffic around or
/// inside the monitored business.
///
/// The dashboard focuses on three questions:
///
/// 1. How busy is the location right now?
/// 2. Is traffic higher or lower than usual?
/// 3. How has traffic changed throughout the day?
///
/// The primary metric is the recent-hour traffic total,
/// calculated from completed 5-minute observations and the
/// current partial observation when available.
///
/// Example:
///   Dashboard updated at: 11:37 AM
///   Traffic window: 10:40 AM - 11:37 AM
///   Traffic rate: 30 pass-bys/hour
///
/// Updates:
///   The dashboard updates as live observation snapshots change and when
///   each 5-minute observation is finalized.
///
///   Five-minute observations are aligned to business-local wall-clock
///   boundaries: 11:00, 11:05, 11:10, 11:15, etc.
///
/// Comparisons:
///   Historical traffic is compared using the same
///   wall-clock-aligned time window.
///
///   Missing historical data is represented by null,
///   never by zero.
///
/// This is an immutable, derived model used by the UI.
/// It is not stored as a separate historical record.
@freezed
class InsightDashboard with _$InsightDashboard {
  const InsightDashboard({
    required this.businessDate,
    this.comparisonPeriod = TrafficComparisonPeriod.yesterday,
    this.recentHourObservation,
    this.comparisonRecentHourObservation,
    this.todaySeries,
    this.comparisonSeries,
    this.comparisonTypicalDay,
  });

  /// Business-local date in YYYY-MM-DD format.
  ///
  /// Example: "2026-10-21"
  final String businessDate;

  /// Selected historical comparison period.
  ///
  /// The user can change this selection on the dashboard.
  final TrafficComparisonPeriod comparisonPeriod;

  /// Traffic observed during the recent hour, including the current partial
  /// 5-minute observation when available.
  ///
  /// Example:
  ///   Updated at: 11:37 AM
  ///   Window: 10:40 AM - 11:37 AM
  ///
  /// The hourly rate is normalized to 60 minutes.
  ///
  /// If some observations are missing, the rate is
  /// estimated using the available observation duration.
  ///
  /// Null when no observations are available.
  final Observation? recentHourObservation;

  /// Historical traffic for the recent-hour comparison window.
  ///
  /// For yesterday and sameDayLastWeek:
  ///   Uses observations from the corresponding time window on that day.
  ///
  /// For monthlyAverage and yearlyAverage:
  ///   Represents typical traffic for the matching weekday or weekend profile.
  ///
  /// Null when the selected comparison has no data.
  final Observation? comparisonRecentHourObservation;

  /// Completed 5-minute traffic observations for the current business date.
  ///
  /// Used to display:
  ///   - Breakfast traffic
  ///   - Lunch traffic
  ///   - Dinner traffic
  ///
  /// Business periods are configured separately and
  /// are not hardcoded into this model.
  final ObservationSeries? todaySeries;

  /// 5-minute observations used to build the selected historical comparison.
  final ObservationSeries? comparisonSeries;

  /// Typical traffic total for the selected comparison period.
  ///
  /// This is [DaySummary.dailyTotal] for daily comparisons,
  /// [MonthSummary.monthlyTotal] for monthly comparisons, or
  /// [YearSummary.yearlyTotal] for yearly comparisons.
  final Observation? comparisonTypicalDay;
}
