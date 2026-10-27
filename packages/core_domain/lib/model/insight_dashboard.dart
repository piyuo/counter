import 'package:core_domain/model/observation.dart';
import 'package:core_domain/model/observation_series.dart';

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
/// The primary metric is the estimated hourly traffic rate,
/// calculated from available 5-minute observations within
/// the past 60 minutes.
///
/// Example:
///   Dashboard updated at: 11:35 AM
///   Traffic window: 10:35 AM - 11:35 AM
///   Traffic rate: 30 pass-bys/hour
///
/// Updates:
///   The dashboard updates whenever a new 5-minute
///   observation becomes available.
///
///   Updates are aligned to business-local wall-clock time:
///   11:00, 11:05, 11:10, 11:15, etc.
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
class InsightDashboard {
  const InsightDashboard({
    required this.businessDate,
    this.comparisonPeriod = TrafficComparisonPeriod.yesterday,
    this.pastHourObservation,
    this.comparisonPastHourObservation,
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

  /// Traffic observed during the most recent 60-minute window from todaySeries.
  ///
  /// Example:
  ///   Updated at: 11:35 AM
  ///   Window: 10:35 AM - 11:35 AM
  ///
  /// The hourly rate is normalized to 60 minutes.
  ///
  /// If some observations are missing, the rate is
  /// estimated using the available observation duration.
  ///
  /// Null when no observations are available.
  final Observation? pastHourObservation;

  /// Historical traffic used as the comparison baseline. the most recent 60-minute window from comparisonSeries
  ///
  /// For yesterday and sameDayLastWeek:
  ///   Represents traffic from a specific previous day.
  ///
  /// For monthlyAverage and yearlyAverage:
  ///   Represents typical traffic calculated from
  ///   historical observations.
  ///
  /// Null when the selected comparison has no data.
  final Observation? comparisonPastHourObservation;

  /// Traffic 5-minute observations for the current business date.
  ///
  /// Used to display:
  ///   - Breakfast traffic
  ///   - Lunch traffic
  ///   - Dinner traffic
  ///
  /// Business periods are configured separately and
  /// are not hardcoded into this model.
  final ObservationSeries? todaySeries;

  /// use to compare with todaySeries, comparisonSeries is from comparisonPeriod.
  final ObservationSeries? comparisonSeries;

  /// Typical day traffic for the selected comparison period. we use this to predict expected traffic patterns.
  ///
  /// it is dailyTotal in DaySummary.
  /// it is monthlyTotal in MonthSummary.
  /// it is yearlyTotal in YearSummary.
  final Observation? comparisonTypicalDay;
}
