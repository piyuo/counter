// TOC
// 1. Observation state derived values

import 'package:core_domain/model/observation_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ObservationState', () {
    test('returns null observation duration without a start time', () {
      const state = ObservationState();

      expect(state.observationDuration, isNull);
    });

    test('derives observation duration from its start time', () {
      final startUtc = DateTime.now().toUtc().subtract(const Duration(minutes: 5));
      final state = ObservationState(observationStartUtc: startUtc);

      final earliestDuration = DateTime.now().toUtc().difference(startUtc);
      final observationDuration = state.observationDuration!;
      final latestDuration = DateTime.now().toUtc().difference(startUtc);

      expect(observationDuration.compareTo(earliestDuration), greaterThanOrEqualTo(0));
      expect(observationDuration.compareTo(latestDuration), lessThanOrEqualTo(0));
    });
  });
}
