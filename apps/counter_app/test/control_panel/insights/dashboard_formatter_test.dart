import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/control_panel/insights/dashboard_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_l10n/shared_l10n.dart';

void main() {
  testWidgets('formatPercentString formats a fraction as a percentage', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: Localization.localizationsDelegates,
        supportedLocales: Localization.supportedLocales,
        home: Builder(builder: (context) => Text(formatPercentString(context, 0.95))),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.widget<Text>(find.byType(Text)).data, '95%');
  });

  testWidgets('formatMetricHelp converts escaped newlines to line breaks', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: Localization.localizationsDelegates,
        supportedLocales: Localization.supportedLocales,
        home: Builder(builder: (context) => Text(formatMetricHelp(context, core_domain.DashboardMetric.appear))),
      ),
    );
    await tester.pumpAndSettle();

    final help = tester.widget<Text>(find.byType(Text)).data!;
    expect(help, contains('\n'));
    expect(help, isNot(contains(r'\n')));
  });
}
