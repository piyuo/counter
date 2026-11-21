import 'package:core_domain/core_domain.dart';
import 'package:counter_app/control_panel/utils/dashboard_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'getDashboardCoveredSeconds sums observation coverage regardless of area data',
    () {
      final observations = [
        Observation(
          year: 2026,
          month: 1,
          day: 1,
          hour: 10,
          minute: 0,
          coveredSeconds: 100,
          areas: const [],
          frameCount: 0,
        ),
        Observation(
          year: 2026,
          month: 1,
          day: 1,
          hour: 10,
          minute: 5,
          coveredSeconds: 200,
          areas: const [],
          frameCount: 0,
        ),
      ];

      expect(getDashboardCoveredSeconds(observations), 300);
    },
  );

  test(
    'groupDashboardObservationsByBusinessPeriod uses half-open period ranges',
    () {
      const breakfast = BusinessPeriod(
        id: 'breakfast',
        name: 'Breakfast',
        startMinute: 7 * 60,
        endMinute: 9 * 60,
      );
      const lunch = BusinessPeriod(
        id: 'lunch',
        name: 'Lunch',
        startMinute: 11 * 60,
        endMinute: 12 * 60,
      );
      final observations = [
        for (final minute in [
          6 * 60 + 55,
          7 * 60,
          8 * 60 + 55,
          9 * 60,
          11 * 60,
          12 * 60,
        ])
          Observation(
            year: 2026,
            month: 1,
            day: 1,
            hour: minute ~/ 60,
            minute: minute % 60,
            areas: const [],
            frameCount: 0,
          ),
      ];

      final groups = groupDashboardObservationsByBusinessPeriod(
        observations,
        const [breakfast, lunch],
      );

      expect(groups.map((group) => group.period.id), ['breakfast', 'lunch']);
      expect(
        groups.map(
          (group) => group.observations
              .map((observation) => observation.slotKey)
              .toList(),
        ),
        [
          [7 * 60, 8 * 60 + 55],
          [11 * 60],
        ],
      );
    },
  );
}
