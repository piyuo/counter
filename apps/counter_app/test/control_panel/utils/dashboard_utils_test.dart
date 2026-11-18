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
}
