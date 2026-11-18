import 'package:core_domain/model/observation.dart';
import 'package:core_domain/model/observation_series.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'insight_state.freezed.dart';

/// Historical period used as a reference for traffic comparisons or filter.
/// wall-clock time window as the current traffic.
enum TrafficPeriod {
  /// it has all today observations plus ongoing live observations (update every second).
  liveToday,

  /// Today up to latest observation
  today,

  /// Same time window yesterday.
  yesterday,

  /// Same time window seven days ago.
  sameDayLastWeek,

  /// Typical traffic for the same time window in the last completed month.
  lastMonthAverage,

  /// Typical traffic for the same time window in the last completed year.
  lastYearAverage,

  /// Custom day selected by the user.
  customDay,
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
///  Example:
///   Updated at: 11:37 AM
///   Selected slots: 10:40 AM - 11:40 AM
///   Current live slot: 11:35 AM - 11:40 AM (partial)
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
class InsightState with _$InsightState {
  const InsightState({
    required this.businessDate,
    this.comparisonPeriod = TrafficPeriod.yesterday,
    this.recentHourTotal,
    this.recentHourObservations,
    this.comparisonRecentHourTotal,
    this.todaySeries,
    this.comparisonSeries,
    this.comparisonTotal,
  });

  /// Creates an initial state for [businessDate] with no observations.
  static InsightState empty({required String businessDate}) =>
      InsightState(businessDate: businessDate, comparisonPeriod: TrafficPeriod.yesterday);

  /// Business-local date in YYYY-MM-DD format.
  ///
  /// Example: "2026-10-21"
  final String businessDate;

  /// Selected historical comparison period.
  ///
  /// The user can change this selection on the dashboard.
  final TrafficPeriod comparisonPeriod;

  /// Traffic observed during the recent hour, including the current partial
  /// 5-minute observation when available.
  ///
  /// Example:
  ///   Updated at: 11:37 AM
  ///   Window: 10:40 AM - 11:37 AM
  ///
  /// The window is limited to the current business date and never crosses
  /// midnight. For example, at 00:20 it includes observations from 00:00
  /// through 00:20, never observations from the previous day.
  ///
  /// The hourly rate is normalized to 60 minutes.
  ///
  /// If some observations are missing, the rate is
  /// estimated using the available observation duration.
  ///
  /// Null when no observations are available.
  final Observation? recentHourTotal;

  /// let user double check the recent hour observations.
  final ObservationSeries? recentHourObservations;

  /// Historical traffic for the recent-hour comparison window.
  ///
  /// For yesterday and sameDayLastWeek:
  ///   Uses observations from the corresponding time window on that day.
  ///
  /// For monthlyAverage and yearlyAverage:
  ///   Represents typical traffic for the matching weekday or weekend profile.
  ///
  /// Null when the selected comparison has no data.
  final Observation? comparisonRecentHourTotal;

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
  final Observation? comparisonTotal;
}
