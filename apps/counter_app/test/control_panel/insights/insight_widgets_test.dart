import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/control_panel/insights/insight_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_l10n/shared_l10n.dart';

void main() {
  testWidgets('horizontal paging changes metrics without losing the area section', (tester) async {
    final areas = const core_domain.InsightDashboardDataBuilder().build(
      dashboard: const core_domain.InsightDashboard(businessDate: '2026-10-29'),
      customAreas: const [core_domain.InterestArea(id: 37, name: 'Entrance')],
      businessPeriods: const [],
      now: DateTime(2026, 10, 29, 12),
    );
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: Localization.localizationsDelegates,
        supportedLocales: Localization.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                AreaInsightSection(area: areas.first, comparisonPeriod: core_domain.TrafficComparisonPeriod.yesterday),
                AreaInsightSection(area: areas.last, comparisonPeriod: core_domain.TrafficComparisonPeriod.yesterday),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Entrance'), findsOneWidget);
    expect(find.text('Pass-by Traffic'), findsNWidgets(2));
    expect(find.text('vs. Yesterday'), findsWidgets);

    final passByTitle = find.text('Pass-by Traffic').first;
    final initialTitleX = tester.getCenter(passByTitle).dx;
    final gesture = await tester.startGesture(tester.getCenter(find.byType(Card).first));
    await gesture.moveBy(const Offset(-60, 0));
    await tester.pump();

    expect(tester.getCenter(passByTitle).dx, lessThan(initialTitleX));
    expect(find.text('Lingering'), findsOneWidget);

    await gesture.moveBy(const Offset(-240, 0));
    await gesture.up();
    await tester.pumpAndSettle();

    expect(find.text('2/${areas.first.cards.length}'), findsOneWidget);
    expect(find.text('Lingering'), findsOneWidget);
    expect(find.text('Pass-by Traffic'), findsOneWidget);
    expect(find.text('Entrance'), findsOneWidget);
    expect(find.byIcon(Icons.swipe), findsNWidgets(2));

    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -900));
    await tester.pumpAndSettle();
    expect(find.text('Camera View'), findsOneWidget);
  });

  testWidgets('insight card height follows its business-period content', (tester) async {
    final builder = const core_domain.InsightDashboardDataBuilder();
    final compactArea = builder
        .build(
          dashboard: const core_domain.InsightDashboard(businessDate: '2026-10-29'),
          customAreas: const [],
          businessPeriods: const [],
          now: DateTime(2026, 10, 29, 12),
        )
        .single;
    final expandedArea = builder
        .build(
          dashboard: const core_domain.InsightDashboard(businessDate: '2026-10-29'),
          customAreas: const [],
          businessPeriods: core_domain.BusinessPeriod.defaultSchedule,
          now: DateTime(2026, 10, 29, 12),
        )
        .single;

    Future<double> cardHeight(core_domain.InsightAreaData area) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: Localization.localizationsDelegates,
          supportedLocales: Localization.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: AreaInsightSection(area: area, comparisonPeriod: core_domain.TrafficComparisonPeriod.yesterday),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      return tester.getSize(find.byType(Card).first).height;
    }

    final compactHeight = await cardHeight(compactArea);
    final expandedHeight = await cardHeight(expandedArea);

    expect(expandedHeight, greaterThan(compactHeight));
  });

  testWidgets('small viewport and larger text keep dashboard content scrollable', (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final area = const core_domain.InsightDashboardDataBuilder()
        .build(
          dashboard: const core_domain.InsightDashboard(businessDate: '2026-10-29'),
          customAreas: const [],
          businessPeriods: core_domain.BusinessPeriod.defaultSchedule,
          now: DateTime(2026, 10, 29, 12),
        )
        .single;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: Localization.localizationsDelegates,
        supportedLocales: Localization.supportedLocales,
        home: MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(1.6)),
          child: Scaffold(
            body: SingleChildScrollView(
              child: AreaInsightSection(area: area, comparisonPeriod: core_domain.TrafficComparisonPeriod.yesterday),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(Card), findsOneWidget);
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -500));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
