import '../model/activity.dart';
import '../model/business_period.dart';
import '../model/insight_dashboard.dart';
import '../model/observation.dart';
import '../model/observation_payload.dart';
import '../model/observation_series.dart';
import '../state/models/interest_area.dart';

enum InsightMetric { passBy, stagnant, entry, exit, appear, disappear, occupancy, dwellTime }

class InsightMetricValue {
  const InsightMetricValue({required this.value, this.secondaryValue, this.estimated = false});

  final double value;
  final double? secondaryValue;
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
      InsightMetric.occupancy,
      InsightMetric.dwellTime,
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
    final primary = _fromAggregate(dashboard.pastHourObservation, areaId, metric, expectedSeconds: 3600);
    final comparisonValue = _fromAggregate(
      dashboard.comparisonPastHourObservation,
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
    return _valueForActivity(
      area,
      metric,
      coveredSeconds: observation.coveredSeconds,
      expectedSeconds: expectedSeconds,
      forceEstimate: expectedSeconds < 3600,
    );
  }

  InsightMetricValue? _fromObservations(
    List<Observation> observations,
    int areaId,
    InsightMetric metric, {
    required int expectedSeconds,
    bool forceEstimate = false,
  }) {
    if (observations.isEmpty) return null;
    final matchingAreas = <Activity>[];
    var coveredSeconds = 0;
    for (final observation in observations) {
      final area = _activity(observation, areaId);
      if (area == null) continue;
      matchingAreas.add(area);
      coveredSeconds += observation.coveredSeconds;
    }
    if (matchingAreas.isEmpty) return null;
    return _valueForAreas(
      matchingAreas,
      metric,
      coveredSeconds: coveredSeconds,
      expectedSeconds: expectedSeconds,
      forceEstimate: forceEstimate,
    );
  }

  InsightMetricValue? _valueForActivity(
    Activity area,
    InsightMetric metric, {
    required int coveredSeconds,
    required int expectedSeconds,
    bool forceEstimate = false,
  }) => _valueForAreas(
    [area],
    metric,
    coveredSeconds: coveredSeconds,
    expectedSeconds: expectedSeconds,
    forceEstimate: forceEstimate,
  );

  InsightMetricValue? _valueForAreas(
    List<Activity> areas,
    InsightMetric metric, {
    required int coveredSeconds,
    required int expectedSeconds,
    bool forceEstimate = false,
  }) {
    switch (metric) {
      case InsightMetric.passBy ||
          InsightMetric.stagnant ||
          InsightMetric.entry ||
          InsightMetric.exit ||
          InsightMetric.appear ||
          InsightMetric.disappear:
        if (coveredSeconds <= 0) return null;
        final count = areas.fold<double>(0, (total, area) => total + _eventValue(area, metric));
        return InsightMetricValue(
          value: count / coveredSeconds * 3600,
          estimated: forceEstimate || coveredSeconds < expectedSeconds,
        );
      case InsightMetric.occupancy:
        final sampled = areas.where((area) => area.occupancySampleCount > 0).toList();
        if (sampled.isEmpty) return null;
        final sampleCount = sampled.fold<int>(0, (total, area) => total + area.occupancySampleCount);
        final sampleSum = sampled.fold<int>(0, (total, area) => total + area.occupancySum);
        final peak = sampled.map((area) => area.occupancyMax).reduce(_max);
        return InsightMetricValue(value: sampleSum / sampleCount, secondaryValue: peak.toDouble());
      case InsightMetric.dwellTime:
        final sampled = areas.where((area) => area.dwellSampleCount > 0).toList();
        if (sampled.isEmpty) return null;
        final sampleCount = sampled.fold<int>(0, (total, area) => total + area.dwellSampleCount);
        final sampleSum = sampled.fold<int>(0, (total, area) => total + area.dwellSumSeconds);
        final longest = sampled.map((area) => area.dwellMaxSeconds).reduce(_max);
        return InsightMetricValue(value: sampleSum / sampleCount, secondaryValue: longest.toDouble());
    }
  }

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
      InsightMetric.occupancy => area.occupancySampleCount > 0 ? area.occupancyMean : null,
      InsightMetric.dwellTime => area.dwellSampleCount > 0 ? area.dwellMeanSeconds / 60 : null,
    };
  }

  double _eventValue(Activity activity, InsightMetric metric) => switch (metric) {
    InsightMetric.passBy => activity.passBy,
    InsightMetric.stagnant => activity.stagnant,
    InsightMetric.entry => activity.entry,
    InsightMetric.exit => activity.exit,
    InsightMetric.appear => activity.appear,
    InsightMetric.disappear => activity.disappear,
    InsightMetric.occupancy || InsightMetric.dwellTime => 0,
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
