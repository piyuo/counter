import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/control_panel/insights/observation_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

void main() {
  testWidgets('shows covered seconds only for non-empty observations', (
    tester,
  ) async {
    final observations = [
      core_domain.Observation(
        year: 2026,
        month: 10,
        day: 26,
        hour: 10,
        minute: 0,
        coveredSeconds: 100,
        areas: const [],
        frameCount: 1,
      ),
      core_domain.Observation(
        year: 2026,
        month: 10,
        day: 26,
        hour: 10,
        minute: 5,
        coveredSeconds: 50,
        areas: const [],
        frameCount: 1,
      ),
      core_domain.Observation.missing(
        year: 2026,
        month: 10,
        day: 26,
        hour: 10,
        minute: 10,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: Localization.localizationsDelegates,
        supportedLocales: Localization.supportedLocales,
        home: Scaffold(
          body: ObservationTile(
            initiallyExpanded: true,
            isExpanded: true,
            observations: observations,
            expectedSeconds: 300,
            areaId: 1,
            metric: core_domain.DashboardMetric.appear,
            measurement: null,
            timeFormat: DateFormat('HH:mm'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final coverageText = find.text(': 100s');
    expect(coverageText, findsOneWidget);
    expect(find.text(': 50s'), findsOneWidget);
    expect(find.text('0s'), findsNothing);
    expect(tester.widget<Text>(coverageText).textAlign, TextAlign.right);
    expect(tester.getSize(coverageText).width, 64);
  });
}
