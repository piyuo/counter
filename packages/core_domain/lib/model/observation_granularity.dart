/// The granularity of an [Observation].
///
/// The same [Observation] model is used at every aggregation level:
/// 5 minutes → hour → day → month → year.
enum ObservationGranularity { minutes5, hour, day, month, year }

extension ObservationGranularityDuration on ObservationGranularity {
  int expectedSecondsFor(int year, int month) => switch (this) {
    ObservationGranularity.minutes5 => 300,
    ObservationGranularity.hour => 3600,
    ObservationGranularity.day => 86400,
    ObservationGranularity.month => DateTime.utc(year, month + 1).difference(DateTime.utc(year, month)).inSeconds,
    ObservationGranularity.year => DateTime.utc(year + 1).difference(DateTime.utc(year)).inSeconds,
  };
}
