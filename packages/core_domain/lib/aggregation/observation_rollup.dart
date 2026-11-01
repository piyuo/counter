// TOC
// 1. aggregateObservations — Combine observations across periods
// 2. averageFiveMinuteProfiles — Average time-of-day profiles
// 3. Private helpers

import 'package:core_domain/model/activity_payload.dart';
import 'package:core_domain/model/observation_granularity.dart';

import '../model/activity.dart';
import '../model/observation.dart';
import '../model/observation_series.dart';

/// Combines observations into hour, day, month, or year observations.
///
/// Supports minutes5→hour/day, day→month, and month→year aggregation.
/// Sources are sorted chronologically at the target period's resolution.
/// Area names are taken from the earliest source observation containing that
/// area ID; occupancy-last values come from the latest source containing it.
/// An area missing from an observation means no update, not zero occupancy.
/// Aggregates a list of observations into a single observation at the specified granularity.
/// Throws an [ArgumentError] if the list is empty, contains observations with the wrong granularity,
/// belongs to different aggregation periods, or contains duplicate source slots.
Observation aggregateObservations(List<Observation> observations, {required ObservationGranularity granularity}) {
  if (observations.isEmpty) {
    throw ArgumentError.value(observations, 'observations', 'must not be empty');
  }
  final sourceGranularity = switch (granularity) {
    ObservationGranularity.hour || ObservationGranularity.day => ObservationGranularity.minutes5,
    ObservationGranularity.month => ObservationGranularity.day,
    ObservationGranularity.year => ObservationGranularity.month,
    ObservationGranularity.minutes5 => throw ArgumentError.value(
      granularity,
      'granularity',
      'must be hour, day, month, or year',
    ),
  };

  final ordered = List<Observation>.of(observations)..sort((left, right) => _compareSources(left, right, granularity));
  final first = ordered.first;
  final sourceIds = <int>{};

  for (final observation in ordered) {
    if (observation.granularity != sourceGranularity) {
      throw ArgumentError.value(
        observation.granularity,
        'observations',
        'must contain only $sourceGranularity observations for $granularity aggregation',
      );
    }
    if (!_belongsToSamePeriod(first, observation, granularity)) {
      throw ArgumentError.value(observation, 'observations', 'must belong to the same aggregation period');
    }
    if (!sourceIds.add(observation.id)) {
      throw ArgumentError.value(observation.id, 'observations', 'must not contain duplicate source slots');
    }
    for (final area in observation.areas) {
      _validateAreaMetrics(area);
    }
  }

  var confidenceSum = 0.0;
  var confidenceSampleCount = 0;
  var coveredSeconds = 0;
  var frameCount = 0;
  final orderedObservations = <Observation>[];

  for (final observation in ordered) {
    orderedObservations.add(observation);
    confidenceSum += observation.confidenceSum;
    confidenceSampleCount += observation.confidenceSampleCount;
    coveredSeconds += observation.coveredSeconds;
    frameCount += observation.frameCount;
  }

  return Observation(
    granularity: granularity,
    year: first.year,
    month: granularity == ObservationGranularity.year ? -1 : first.month,
    day: granularity == ObservationGranularity.hour || granularity == ObservationGranularity.day ? first.day : -1,
    hour: granularity == ObservationGranularity.hour ? first.hour : -1,
    minute: -1,
    confidenceSum: confidenceSum,
    confidenceSampleCount: confidenceSampleCount,
    coveredSeconds: coveredSeconds,
    frameCount: frameCount,
    areas: _aggregateAreas(orderedObservations),
  );
}

/// Combines matching time-of-day slots across source profiles.
///
/// Missing slots and areas are omitted rather than treated as zero. Event
/// counts in profiles are weighted averages across contributing observations.
/// Occupancy, dwell, and presence statistics are also weighted averages;
/// integer values are rounded
/// to the nearest whole value. [Activity.occupancyMax] remains the maximum
/// across contributors, while [Activity.occupancyLast] is zero because the
/// profile does not represent a real final frame. Histogram buckets use
/// largest-remainder rounding to match the averaged dwell sample count.
ObservationSeries averageFiveMinuteProfiles(Iterable<Iterable<Observation>> profiles) {
  final observationsBySlot = <int, List<Observation>>{};
  for (final profile in profiles) {
    final slotsInProfile = <int>{};
    for (final observation in profile) {
      if (observation.granularity != ObservationGranularity.minutes5) {
        throw ArgumentError.value(observation.granularity, 'profiles', 'must contain only minutes5 observations');
      }
      if (!slotsInProfile.add(observation.timeKey)) {
        throw ArgumentError.value(observation.timeKey, 'profiles', 'must not contain duplicate time slots');
      }
      observationsBySlot.putIfAbsent(observation.timeKey, () => []).add(observation);
    }
  }

  final slots = observationsBySlot.keys.toList()..sort();
  return ObservationSeries.fromObservations([
    for (final slot in slots) _averageFiveMinuteSlot(observationsBySlot[slot]!),
  ]);
}

Observation _averageFiveMinuteSlot(List<Observation> contributors) {
  final first = contributors.first;
  final confidenceSum = _averageDouble(contributors.map((observation) => observation.confidenceSum));
  final confidenceSampleCount = _averageInt(contributors.map((observation) => observation.confidenceSampleCount));
  final coveredSeconds = _averageInt(contributors.map((observation) => observation.coveredSeconds));
  return Observation(
    granularity: ObservationGranularity.minutes5,
    year: first.year,
    month: first.month,
    day: first.day,
    hour: first.hour,
    minute: first.minute,
    confidenceSum: confidenceSum,
    confidenceSampleCount: confidenceSampleCount,
    coveredSeconds: coveredSeconds,
    areas: _averageAreas(contributors),
    frameCount: _averageInt(contributors.map((observation) => observation.frameCount)),
    weekendOverride: first.isWeekend,
  );
}

List<Activity> _averageAreas(List<Observation> contributors) {
  final areaMetricsById = <int, List<Activity>>{};
  for (final observation in contributors) {
    for (final metrics in observation.areas) {
      areaMetricsById.putIfAbsent(metrics.areaId, () => []).add(metrics);
    }
  }

  final areaIds = areaMetricsById.keys.toList()..sort();
  return [for (final areaId in areaIds) _averageAreaMetrics(areaMetricsById[areaId]!)];
}

Activity _averageAreaMetrics(List<Activity> contributors) {
  for (final area in contributors) {
    _validateAreaMetrics(area);
  }

  final first = contributors.first;
  final validOccupancyMetrics = contributors.where((area) => area.occupancySampleCount > 0).toList();
  final occupancySampleCount = validOccupancyMetrics.isEmpty
      ? 0
      : _averageInt(validOccupancyMetrics.map((area) => area.occupancySampleCount));
  final occupancySampleSum = validOccupancyMetrics.isEmpty
      ? 0
      : _averageInt(validOccupancyMetrics.map((area) => area.occupancySum));
  final occupancySampleSumSquares = validOccupancyMetrics.isEmpty
      ? 0
      : _averageInt(validOccupancyMetrics.map((area) => area.occupancySumSquares));
  final dwellSampleCount = _averageInt(contributors.map((area) => area.dwellSampleCount));
  final dwellSumSeconds = _averageInt(contributors.map((area) => area.dwellSumSeconds));
  final presenceSampleCount = _averageInt(contributors.map((area) => area.presenceSampleCount));
  final presenceSumSeconds = _averageInt(contributors.map((area) => area.presenceSumSeconds));

  return Activity(
    areaId: first.areaId,
    areaName: first.areaName,
    passBy: _averageDouble(contributors.map((area) => area.passBy)),
    stagnant: _averageDouble(contributors.map((area) => area.stagnant)),
    entry: _averageDouble(contributors.map((area) => area.entry)),
    exit: _averageDouble(contributors.map((area) => area.exit)),
    appear: _averageDouble(contributors.map((area) => area.appear)),
    disappear: _averageDouble(contributors.map((area) => area.disappear)),
    occupancySampleCount: occupancySampleCount,
    occupancySum: occupancySampleSum,
    occupancySumSquares: occupancySampleSumSquares,
    occupancyMax: validOccupancyMetrics.isEmpty
        ? 0
        : validOccupancyMetrics.map((area) => area.occupancyMax).reduce(_max),
    occupancyLast: 0, // Profiles do not represent a real final frame.
    dwellSampleCount: dwellSampleCount,
    dwellSumSeconds: dwellSumSeconds,
    dwellMaxSeconds: _averageInt(contributors.map((area) => area.dwellMaxSeconds)),
    dwellHistogram: _averageDwellHistogram(contributors, dwellSampleCount),
    presenceSampleCount: presenceSampleCount,
    presenceSumSeconds: presenceSumSeconds,
  );
}

List<Activity> _aggregateAreas(List<Observation> observations) {
  final areasById = <int, Activity>{};
  for (final observation in observations) {
    for (final area in observation.areas) {
      areasById[area.areaId] = _combineAreaMetrics(areasById[area.areaId], area);
    }
  }

  final areas = areasById.values.toList()..sort((left, right) => left.areaId.compareTo(right.areaId));
  return areas;
}

Activity _combineAreaMetrics(Activity? previous, Activity current) {
  _validateAreaMetrics(current);
  if (previous != null) _validateAreaMetrics(previous);

  final occupancySampleCount = (previous?.occupancySampleCount ?? 0) + current.occupancySampleCount;
  final occupancySampleSum = (previous?.occupancySum ?? 0) + current.occupancySum;
  final dwellSampleCount = (previous?.dwellSampleCount ?? 0) + current.dwellSampleCount;
  final dwellSumSeconds = (previous?.dwellSumSeconds ?? 0) + current.dwellSumSeconds;
  final presenceTrackCount = (previous?.presenceSampleCount ?? 0) + current.presenceSampleCount;
  final presenceSumSeconds = (previous?.presenceSumSeconds ?? 0) + current.presenceSumSeconds;

  return Activity(
    areaId: current.areaId,
    areaName: previous?.areaName ?? current.areaName,
    passBy: (previous?.passBy ?? 0) + current.passBy,
    stagnant: (previous?.stagnant ?? 0) + current.stagnant,
    entry: (previous?.entry ?? 0) + current.entry,
    exit: (previous?.exit ?? 0) + current.exit,
    appear: (previous?.appear ?? 0) + current.appear,
    disappear: (previous?.disappear ?? 0) + current.disappear,
    occupancySampleCount: occupancySampleCount,
    occupancySum: occupancySampleSum,
    occupancySumSquares: (previous?.occupancySumSquares ?? 0) + current.occupancySumSquares,
    occupancyMax: _combinedOccupancyMax(previous, current),
    occupancyLast: current.occupancySampleCount > 0 ? current.occupancyLast : previous?.occupancyLast ?? 0,
    dwellSampleCount: dwellSampleCount,
    dwellSumSeconds: dwellSumSeconds,
    dwellMaxSeconds: _max(previous?.dwellMaxSeconds ?? 0, current.dwellMaxSeconds),
    dwellHistogram: List<int>.generate(
      kDwellBucketCount,
      (index) => (previous?.dwellHistogram[index] ?? 0) + current.dwellHistogram[index],
    ),
    presenceSampleCount: presenceTrackCount,
    presenceSumSeconds: presenceSumSeconds,
  );
}

void _validateAreaMetrics(Activity metrics) {
  if (metrics.dwellHistogram.length != kDwellBucketCount) {
    throw ArgumentError.value(metrics.dwellHistogram, 'dwellHistogram', 'must contain $kDwellBucketCount buckets');
  }
  final histogramTotal = metrics.dwellHistogram.fold<int>(0, (sum, count) => sum + count);
  if (metrics.dwellHistogram.any((count) => count < 0) || histogramTotal != metrics.dwellSampleCount) {
    throw ArgumentError.value(
      metrics.dwellHistogram,
      'dwellHistogram',
      'bucket total $histogramTotal must equal dwellSampleCount ${metrics.dwellSampleCount}',
    );
  }
}

int _combinedOccupancyMax(Activity? previous, Activity current) {
  final previousHasSamples = (previous?.occupancySampleCount ?? 0) > 0;
  final currentHasSamples = current.occupancySampleCount > 0;
  if (!currentHasSamples) return previousHasSamples ? previous!.occupancyMax : 0;
  if (!previousHasSamples) return current.occupancyMax;
  return _max(previous!.occupancyMax, current.occupancyMax);
}

List<int> _averageDwellHistogram(List<Activity> contributors, int averagedSampleCount) {
  final exactBucketCounts = List<double>.generate(
    kDwellBucketCount,
    (index) => _averageDouble(contributors.map((area) => area.dwellHistogram[index].toDouble())),
  );
  final bucketCounts = exactBucketCounts.map((count) => count.floor()).toList();
  final remaining = averagedSampleCount - bucketCounts.fold<int>(0, (sum, count) => sum + count);
  final bucketsByLargestRemainder = List<int>.generate(kDwellBucketCount, (index) => index)
    ..sort((left, right) {
      final leftRemainder = exactBucketCounts[left] - exactBucketCounts[left].floorToDouble();
      final rightRemainder = exactBucketCounts[right] - exactBucketCounts[right].floorToDouble();
      final remainderOrder = rightRemainder.compareTo(leftRemainder);
      return remainderOrder != 0 ? remainderOrder : left.compareTo(right);
    });
  for (final index in bucketsByLargestRemainder.take(remaining)) {
    bucketCounts[index]++;
  }
  return bucketCounts;
}

int _averageInt(Iterable<int> values) {
  final list = values.toList();
  return (list.reduce((sum, value) => sum + value) / list.length).round();
}

double _averageDouble(Iterable<double> values) {
  final list = values.toList();
  return list.reduce((sum, value) => sum + value) / list.length;
}

bool _belongsToSamePeriod(Observation first, Observation current, ObservationGranularity target) => switch (target) {
  ObservationGranularity.hour =>
    current.year == first.year &&
        current.month == first.month &&
        current.day == first.day &&
        current.hour == first.hour,
  ObservationGranularity.day => current.year == first.year && current.month == first.month && current.day == first.day,
  ObservationGranularity.month => current.year == first.year && current.month == first.month,
  ObservationGranularity.year => current.year == first.year,
  ObservationGranularity.minutes5 => false,
};

int _compareSources(Observation left, Observation right, ObservationGranularity target) => switch (target) {
  ObservationGranularity.hour || ObservationGranularity.day => left.timeKey.compareTo(right.timeKey),
  ObservationGranularity.month => left.day.compareTo(right.day),
  ObservationGranularity.year =>
    left.month != right.month ? left.month.compareTo(right.month) : left.day.compareTo(right.day),
  ObservationGranularity.minutes5 => left.timeKey.compareTo(right.timeKey),
};

int _max(int first, int second) => first > second ? first : second;
