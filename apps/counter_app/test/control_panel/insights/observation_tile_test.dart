import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/control_panel/insights/observation_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

Widget _tileApp(
  List<core_domain.Observation> observations, {
  bool? showInProgressLabel,
}) => MaterialApp(
  localizationsDelegates: Localization.localizationsDelegates,
  supportedLocales: Localization.supportedLocales,
  home: Scaffold(
    body: SingleChildScrollView(
      child: ObservationTile(
        initiallyExpanded: true,
        isExpanded: true,
        observations: observations,
        expectedSeconds: 300,
        areaId: 1,
        metric: core_domain.DashboardMetric.appear,
        measurement: null,
        timeFormat: DateFormat('HH:mm'),
        showInProgressLabel: showInProgressLabel,
      ),
    ),
  ),
);

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

    await tester.pumpWidget(_tileApp(observations));
    await tester.pumpAndSettle();

    final timeHeading = find.text('Time');
    expect(timeHeading, findsOneWidget);
    expect(find.text('Observed'), findsOneWidget);
    expect(find.text('Count'), findsOneWidget);
    expect(find.text('10:00 – 11:00'), findsOneWidget);
    expect(find.text('In progress'), findsOneWidget);
    expect(tester.getSize(timeHeading).width, 112);

    final coverageText = find.text('100s');
    expect(coverageText, findsOneWidget);
    expect(find.text('50s'), findsOneWidget);
    expect(find.text('0s'), findsNothing);
    expect(tester.widget<Text>(coverageText).textAlign, TextAlign.right);
    expect(tester.getSize(coverageText).width, 58);
  });

  testWidgets('hides the in-progress label for 12 observations', (
    tester,
  ) async {
    final observations = List.generate(
      12,
      (index) => core_domain.Observation(
        year: 2026,
        month: 10,
        day: 26,
        hour: 10,
        minute: index * 5,
        coveredSeconds: 100,
        areas: const [],
        frameCount: 1,
      ),
    );

    await tester.pumpWidget(_tileApp(observations));
    await tester.pumpAndSettle();

    expect(find.text('In progress'), findsNothing);
  });

  testWidgets('allows completed short periods to hide the in-progress label', (
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
    ];

    await tester.pumpWidget(_tileApp(observations, showInProgressLabel: false));
    await tester.pumpAndSettle();

    expect(find.text('In progress'), findsNothing);
  });
}
