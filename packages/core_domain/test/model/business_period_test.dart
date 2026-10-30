import 'dart:convert';

import 'package:core_domain/model/business_period.dart';
import 'package:core_domain/state/models/app_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BusinessPeriod', () {
    const breakfast = BusinessPeriod(id: 'breakfast', name: 'Breakfast', startMinute: 7 * 60, endMinute: 9 * 60);

    test('reports status at business-local period boundaries', () {
      expect(breakfast.statusAt(DateTime(2026, 10, 29, 6, 59)), BusinessPeriodStatus.notStarted);
      expect(breakfast.statusAt(DateTime(2026, 10, 29, 7)), BusinessPeriodStatus.inProgress);
      expect(breakfast.statusAt(DateTime(2026, 10, 29, 8, 59)), BusinessPeriodStatus.inProgress);
      expect(breakfast.statusAt(DateTime(2026, 10, 29, 9)), BusinessPeriodStatus.completed);
    });

    test('round-trips its persisted JSON representation', () {
      expect(BusinessPeriod.fromJson(breakfast.toJson()), breakfast);
    });

    test('provides default business periods in configured order', () {
      expect(BusinessPeriod.defaultSchedule.map((period) => period.id), ['breakfast', 'lunch', 'dinner']);
    });

    test('AppState defaults old saved configuration to the business schedule', () {
      final restored = AppState.fromJson({'uploadConfig': <String, dynamic>{}});

      expect(restored.businessPeriods, BusinessPeriod.defaultSchedule);
    });

    test('AppState restores configured business periods', () {
      final restored = AppState.fromJson({
        'uploadConfig': <String, dynamic>{},
        'businessPeriods': [breakfast.toJson()],
      });

      expect(restored.businessPeriods, [breakfast]);
    });

    test('AppState business periods survive JSON persistence', () {
      const state = AppState(businessPeriods: [breakfast]);

      final restored = AppState.fromJson(jsonDecode(jsonEncode(state.toJson())) as Map<String, dynamic>);

      expect(restored.businessPeriods, [breakfast]);
    });
  });
}
