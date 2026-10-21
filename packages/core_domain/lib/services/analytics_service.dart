import 'package:core_domain/core_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_service.g.dart';

abstract class AnalyticsService {
  AnalyticsState get state;

  /// save an observation to the analytics service
  ///
  /// The observation will be processed and aggregated into the appropriate
  /// day summary within the analytics service.
  Future<void> add(Observation observation);

  /// Retrieves a day summary for the specified business date components.
  ///
  /// Returns the day summary if it exists, or `null` if no summary is available
  /// for the given date.
  Future<DaySummary?> getDaySummary(int year, int month, int day);

  /// Retrieves a month summary for the specified year and month.
  ///
  /// Returns the month summary if it exists, or `null` if no summary is available
  /// for the given month.
  Future<MonthSummary?> getMonthSummary(int year, int month);

  /// Retrieves a year summary for the specified year.
  ///
  /// Returns the year summary if it exists, or `null` if no summary is available
  /// for the given year.
  Future<YearSummary?> getYearSummary(int year);
}

@riverpod
AnalyticsService analyticsService(Ref ref) {
  throw UnimplementedError('analyticsServiceProvider must be overridden');
}
