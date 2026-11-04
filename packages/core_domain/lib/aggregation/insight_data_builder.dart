import '../model/activity.dart';
import '../model/business_period.dart';
import '../model/insight_dashboard.dart';
import '../model/observation.dart';
import '../model/observation_payload.dart';
import '../model/observation_series.dart';
import '../state/models/interest_area.dart';

enum InsightMetric {
  passBy,
  stagnant,
  entry,
  exit,
  appear,
  disappear,
  occupancyMean,
  occupancyPeak,
  dwellTimeMean,
  dwellTimeMax,
}

class InsightMetricValue {
  const InsightMetricValue({required this.value, this.estimated = false});

  final double value;
  final bool estimated;
}

class InsightPeriodData {
  const InsightPeriodData({
    required this.period,
    required this.status,
    required this.primary,
    required this.comparisonValue,
  });

  final BusinessPeriod period;
  final BusinessPeriodStatus status;
  final InsightMetricValue? primary;
  final double? comparisonValue;
}

class InsightChartPoint {
  const InsightChartPoint({required this.minuteOfDay, this.todayValue, this.comparisonValue});

  final int minuteOfDay;
  final double? todayValue;
  final double? comparisonValue;
}

class InsightCardData {
  const InsightCardData({
    required this.metric,
    required this.primary,
    required this.comparisonValue,
    required this.periods,
    required this.chartPoints,
  });

  final InsightMetric metric;
  final InsightMetricValue? primary;
  final double? comparisonValue;
  final List<InsightPeriodData> periods;
  final List<InsightChartPoint> chartPoints;
}

class InsightAreaData {
  const InsightAreaData({required this.areaId, required this.name, required this.isGlobal, required this.cards});

  final int areaId;
  final String? name;
  final bool isGlobal;
  final List<InsightCardData> cards;

  InsightCardData card(InsightMetric metric) => cards.firstWhere((card) => card.metric == metric);
}

class InsightDashboardDataBuilder {
  const InsightDashboardDataBuilder();

  /// A value is only marked as estimated when the observed coverage is more
  /// than this fraction below the expected coverage. Small interruptions
  /// (e.g. 5 seconds out of an hour) are not worth flagging.
  static const double _coverageTolerance = 0.05;

  List<InsightAreaData> build({
    required InsightDashboard dashboard,
    required List<InterestArea> customAreas,
    required List<BusinessPeriod> businessPeriods,
    required DateTime now,
  }) {
    final today = dashboard.todaySeries ?? ObservationSeries.empty;
    final comparison = dashboard.comparisonSeries ?? ObservationSeries.empty;
    final currentSlotEnd = (now.hour * 60 + now.minute) ~/ 5 * 5;
    final areas = <InsightAreaData>[
      for (final area in customAreas.where((area) => area.enabled && area.id != kGlobalAreaId))
        _buildArea(
          areaId: area.id,
          name: area.name,
          isGlobal: false,
          dashboard: dashboard,
          today: today,
          comparison: comparison,
          businessPeriods: businessPeriods,
          now: now,
          currentSlotEnd: currentSlotEnd,
        ),
    ];
    areas.add(
      _buildArea(
        areaId: kGlobalAreaId,
        name: null,
        isGlobal: true,
        dashboard: dashboard,
        today: today,
        comparison: comparison,
        businessPeriods: businessPeriods,
        now: now,
        currentSlotEnd: currentSlotEnd,
      ),
    );
    return List.unmodifiable(areas);
  }

  InsightAreaData _buildArea({
    required int areaId,
    required String? name,
    required bool isGlobal,
    required InsightDashboard dashboard,
    required ObservationSeries today,
    required ObservationSeries comparison,
    required List<BusinessPeriod> businessPeriods,
    required DateTime now,
    required int currentSlotEnd,
  }) {
    final metrics = [
      InsightMetric.passBy,
      InsightMetric.stagnant,
      if (!isGlobal) InsightMetric.entry,
      if (!isGlobal) InsightMetric.exit,
      InsightMetric.appear,
      InsightMetric.disappear,
      InsightMetric.occupancyMean,
      InsightMetric.occupancyPeak,
      InsightMetric.dwellTimeMean,
      InsightMetric.dwellTimeMax,
    ];
    return InsightAreaData(
      areaId: areaId,
      name: name,
      isGlobal: isGlobal,
      cards: [
        for (final metric in metrics)
          _buildCard(
            metric: metric,
            areaId: areaId,
            dashboard: dashboard,
            today: today,
            comparison: comparison,
            businessPeriods: businessPeriods,
            now: now,
            currentSlotEnd: currentSlotEnd,
          ),
      ],
    );
  }

  InsightCardData _buildCard({
    required InsightMetric metric,
    required int areaId,
    required InsightDashboard dashboard,
    required ObservationSeries today,
    required ObservationSeries comparison,
    required List<BusinessPeriod> businessPeriods,
    required DateTime now,
    required int currentSlotEnd,
  }) {
    final primary = _fromAggregate(dashboard.recentHourObservation, areaId, metric, expectedSeconds: 3600);
    final comparisonValue = _fromAggregate(
      dashboard.comparisonRecentHourObservation,
      areaId,
      metric,
      expectedSeconds: 3600,
    )?.value;
    final periods = [
      for (final period in businessPeriods)
        _buildPeriod(period: period, areaId: areaId, metric: metric, today: today, comparison: comparison, now: now),
    ];
    return InsightCardData(
      metric: metric,
      primary: primary,
      comparisonValue: comparisonValue,
      periods: List.unmodifiable(periods),
      chartPoints: _buildChartPoints(metric, areaId, today, comparison, currentSlotEnd),
    );
  }

  InsightPeriodData _buildPeriod({
    required BusinessPeriod period,
    required int areaId,
    required InsightMetric metric,
    required ObservationSeries today,
    required ObservationSeries comparison,
    required DateTime now,
  }) {
    final status = period.statusAt(now);
    final endMinute = switch (status) {
      BusinessPeriodStatus.notStarted => period.startMinute,
      BusinessPeriodStatus.inProgress => _min(period.endMinute, now.hour * 60 + now.minute ~/ 5 * 5),
      BusinessPeriodStatus.completed => period.endMinute,
    };
    if (status == BusinessPeriodStatus.notStarted || endMinute <= period.startMinute) {
      return InsightPeriodData(period: period, status: status, primary: null, comparisonValue: null);
    }

    final expectedSeconds = (endMinute - period.startMinute) * 60;
    final primary = _fromObservations(
      _inRange(today, period.startMinute, endMinute),
      areaId,
      metric,
      expectedSeconds: expectedSeconds,
    );
    final comparisonValue = _fromObservations(
      _inRange(comparison, period.startMinute, endMinute),
      areaId,
      metric,
      expectedSeconds: expectedSeconds,
    )?.value;
    return InsightPeriodData(period: period, status: status, primary: primary, comparisonValue: comparisonValue);
  }

  InsightMetricValue? _fromAggregate(
    Observation? observation,
    int areaId,
    InsightMetric metric, {
    required int expectedSeconds,
  }) {
    if (observation == null) return null;
    final area = _activity(observation, areaId);
    if (area == null) return null;
    return _valueForSingleSample(
      area,
      metric,
      coveredSeconds: observation.coveredSeconds,
      expectedSeconds: expectedSeconds,
    );
  }

  InsightMetricValue? _fromObservations(
    List<Observation> observations,
    int areaId,
    InsightMetric metric, {
    required int expectedSeconds,
  }) {
    if (observations.isEmpty) return null;
    final samples = <Activity>[];
    var coveredSeconds = 0;
    for (final observation in observations) {
      final area = _activity(observation, areaId);
      if (area == null) continue;
      samples.add(area);
      coveredSeconds += observation.coveredSeconds;
    }
    if (samples.isEmpty) return null;
    return _valueForSamples(samples, metric, coveredSeconds: coveredSeconds, expectedSeconds: expectedSeconds);
  }

  InsightMetricValue? _valueForSingleSample(
    Activity sample,
    InsightMetric metric, {
    required int coveredSeconds,
    required int expectedSeconds,
  }) => _valueForSamples([sample], metric, coveredSeconds: coveredSeconds, expectedSeconds: expectedSeconds);

  /// Aggregates [samples] (the same area across different time slots) into one value.
  InsightMetricValue? _valueForSamples(
    List<Activity> samples,
    InsightMetric metric, {
    required int coveredSeconds,
    required int expectedSeconds,
  }) {
    assert(
      samples.isNotEmpty && samples.every((sample) => sample.areaId == samples.first.areaId),
      'samples must all belong to the same area',
    );
    switch (metric) {
      case InsightMetric.passBy ||
          InsightMetric.stagnant ||
          InsightMetric.entry ||
          InsightMetric.exit ||
          InsightMetric.appear ||
          InsightMetric.disappear:
        if (coveredSeconds <= 0) return null;
        final count = samples.fold<double>(0, (total, sample) => total + _eventValue(sample, metric));
        return InsightMetricValue(
          value: count / coveredSeconds * 3600,
          estimated: _isEstimated(coveredSeconds: coveredSeconds, expectedSeconds: expectedSeconds),
        );
      case InsightMetric.occupancyMean:
        final sampled = samples.where((sample) => sample.occupancySampleCount > 0).toList();
        if (sampled.isEmpty) return null;
        final sampleCount = sampled.fold<int>(0, (total, sample) => total + sample.occupancySampleCount);
        final sampleSum = sampled.fold<int>(0, (total, sample) => total + sample.occupancySum);
        return InsightMetricValue(value: sampleSum / sampleCount);
      case InsightMetric.occupancyPeak:
        final sampled = samples.where((sample) => sample.occupancySampleCount > 0).toList();
        if (sampled.isEmpty) return null;
        return InsightMetricValue(value: sampled.map((sample) => sample.occupancyMax).reduce(_max).toDouble());
      case InsightMetric.dwellTimeMean:
        final sampled = samples.where((sample) => sample.dwellSampleCount > 0).toList();
        if (sampled.isEmpty) return null;
        final sampleCount = sampled.fold<int>(0, (total, sample) => total + sample.dwellSampleCount);
        final sampleSum = sampled.fold<int>(0, (total, sample) => total + sample.dwellSumSeconds);
        return InsightMetricValue(value: sampleSum / sampleCount);
      case InsightMetric.dwellTimeMax:
        final sampled = samples.where((sample) => sample.dwellSampleCount > 0).toList();
        if (sampled.isEmpty) return null;
        return InsightMetricValue(value: sampled.map((sample) => sample.dwellMaxSeconds).reduce(_max).toDouble());
    }
  }

  /// True when coverage falls short of the expected duration by more than
  /// [_coverageTolerance]. For a 3600s window, anything below 3420s is an estimate.
  bool _isEstimated({required int coveredSeconds, required int expectedSeconds}) =>
      coveredSeconds < expectedSeconds * (1 - _coverageTolerance);

  List<InsightChartPoint> _buildChartPoints(
    InsightMetric metric,
    int areaId,
    ObservationSeries today,
    ObservationSeries comparison,
    int currentSlotEnd,
  ) {
    final todayByMinute = <int, double?>{};
    for (final observation in today) {
      final minute = observation.hour * 60 + observation.minute;
      if (minute >= currentSlotEnd) continue;
      todayByMinute[minute] = _chartValue(observation, areaId, metric);
    }
    final comparisonByMinute = <int, double?>{
      for (final observation in comparison)
        observation.hour * 60 + observation.minute: _chartValue(observation, areaId, metric),
    };
    final minutes = {...todayByMinute.keys, ...comparisonByMinute.keys}.toList()..sort();
    return List.unmodifiable([
      for (final minute in minutes)
        InsightChartPoint(
          minuteOfDay: minute,
          todayValue: todayByMinute[minute],
          comparisonValue: comparisonByMinute[minute],
        ),
    ]);
  }

  double? _chartValue(Observation observation, int areaId, InsightMetric metric) {
    final area = _activity(observation, areaId);
    if (area == null) return null;
    return switch (metric) {
      InsightMetric.passBy => observation.coveredSeconds > 0 ? area.passBy : null,
      InsightMetric.stagnant => observation.coveredSeconds > 0 ? area.stagnant : null,
      InsightMetric.entry => observation.coveredSeconds > 0 ? area.entry : null,
      InsightMetric.exit => observation.coveredSeconds > 0 ? area.exit : null,
      InsightMetric.appear => observation.coveredSeconds > 0 ? area.appear : null,
      InsightMetric.disappear => observation.coveredSeconds > 0 ? area.disappear : null,
      InsightMetric.occupancyMean => area.occupancySampleCount > 0 ? area.occupancyMean : null,
      InsightMetric.occupancyPeak => area.occupancySampleCount > 0 ? area.occupancyMax.toDouble() : null,
      InsightMetric.dwellTimeMean => area.dwellSampleCount > 0 ? area.dwellMeanSeconds / 60 : null,
      InsightMetric.dwellTimeMax => area.dwellSampleCount > 0 ? area.dwellMaxSeconds / 60 : null,
    };
  }

  double _eventValue(Activity activity, InsightMetric metric) => switch (metric) {
    InsightMetric.passBy => activity.passBy,
    InsightMetric.stagnant => activity.stagnant,
    InsightMetric.entry => activity.entry,
    InsightMetric.exit => activity.exit,
    InsightMetric.appear => activity.appear,
    InsightMetric.disappear => activity.disappear,
    InsightMetric.occupancyMean ||
    InsightMetric.occupancyPeak ||
    InsightMetric.dwellTimeMean ||
    InsightMetric.dwellTimeMax => 0,
  };

  Activity? _activity(Observation observation, int areaId) {
    for (final area in observation.areas) {
      if (area.areaId == areaId) return area;
    }
    return null;
  }

  List<Observation> _inRange(ObservationSeries series, int startMinute, int endMinute) => [
    for (final observation in series)
      if (observation.hour * 60 + observation.minute >= startMinute &&
          observation.hour * 60 + observation.minute < endMinute)
        observation,
  ];

  int _min(int left, int right) => left < right ? left : right;
  int _max(int left, int right) => left > right ? left : right;
}
