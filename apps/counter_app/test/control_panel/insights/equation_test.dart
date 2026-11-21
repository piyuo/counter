import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/control_panel/insights/equation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_l10n/shared_l10n.dart';

Widget _equationApp({required int coveredSeconds}) => MaterialApp(
  localizationsDelegates: Localization.localizationsDelegates,
  supportedLocales: Localization.supportedLocales,
  home: Scaffold(
    body: Equation(
      amount: 6,
      coveredSeconds: coveredSeconds,
      metric: core_domain.DashboardMetric.appear,
      detectionType: core_domain.DetectionType.people,
    ),
  ),
);

void main() {
  testWidgets('shows the hourly rate from count and observed time', (tester) async {
    await tester.pumpWidget(_equationApp(coveredSeconds: 1800));
    await tester.pumpAndSettle();
    expect(find.textContaining('= 12 /hr'), findsOneWidget);
  });

  testWidgets('shows zero rather than a non-finite rate without coverage', (tester) async {
    await tester.pumpWidget(_equationApp(coveredSeconds: 0));
    await tester.pumpAndSettle();

    expect(find.textContaining('= 0 /hr'), findsOneWidget);
  });
}
