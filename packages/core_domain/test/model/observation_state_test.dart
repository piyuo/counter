// TOC
// 1. Observation state derived values

import 'package:core_domain/model/observation.dart';
import 'package:core_domain/model/observation_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ObservationState', () {
    const liveObservation = Observation(year: 2026, month: 1, day: 1, hour: 0, minute: 0, areas: [], frameCount: 0);

    test('returns null observation duration without a start time', () {
      const state = ObservationState(liveObservation: liveObservation);

      expect(state.timeSinceObservationStart, isNull);
    });

    test('derives observation duration from its start time', () {
      final startUtc = DateTime.now().toUtc().subtract(const Duration(minutes: 5));
      final state = ObservationState(liveObservation: liveObservation, observationStartUtc: startUtc);

      final earliestDuration = DateTime.now().toUtc().difference(startUtc);
      final observationDuration = state.timeSinceObservationStart!;
      final latestDuration = DateTime.now().toUtc().difference(startUtc);

      expect(observationDuration.compareTo(earliestDuration), greaterThanOrEqualTo(0));
      expect(observationDuration.compareTo(latestDuration), lessThanOrEqualTo(0));
    });
  });
}
