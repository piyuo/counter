import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_domain/model/observation_series.dart';
import 'package:counter_app/control_panel/insights/business_period_row.dart';
import 'package:counter_app/control_panel/insights/insight_primary_metric.dart';
import 'package:counter_app/control_panel/insights/insight_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_l10n/shared_l10n.dart';

void main() {
  testWidgets('shows estimated labels for incomplete primary and period values', (tester) async {
    const builder = core_domain.InsightDashboardDataBuilder();
    const area = core_domain.InterestArea(id: 37, name: 'Entrance');
    const period = core_domain.BusinessPeriod(id: 'morning', name: 'Morning', startMinute: 600, endMinute: 610);

    core_domain.Observation observation(int minute, int coveredSeconds) => core_domain.Observation(
      year: 2026,
      month: 10,
      day: 29,
      hour: 10,
      minute: minute,
      coveredSeconds: coveredSeconds,
      areas: const [core_domain.Activity(areaId: 37, areaName: 'Entrance', passBy: 10)],
      frameCount: 1,
    );

    Future<void> pumpArea({
      required int recentHourCoverage,
      required int periodCoverage,
      core_domain.ObservationStatus observationStatus = core_domain.ObservationStatus.stopped,
    }) async {
      final areaData = builder
          .build(
            dashboard: core_domain.InsightDashboard(
              businessDate: '2026-10-29',
              todaySeries: ObservationSeries.fromObservations([
                observation(0, 300),
                observation(5, periodCoverage - 300),
              ]),
              recentHourObservation: observation(0, recentHourCoverage),
            ),
            customAreas: const [area],
            businessPeriods: const [period],
            now: DateTime(2026, 10, 29, 10, 10),
          )
          .first;
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: Localization.localizationsDelegates,
          supportedLocales: Localization.supportedLocales,
          home: Scaffold(
            body: AreaInsightSection(
              areaData: areaData,
              comparisonPeriod: core_domain.TrafficComparisonPeriod.yesterday,
              observationStatus: observationStatus,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    await pumpArea(recentHourCoverage: 3600, periodCoverage: 600);
    expect(find.text('Estimated'), findsNothing);
    final statusColor = insightObservationStatusColor(
      tester.element(find.byType(PrimaryMetric).first),
      core_domain.ObservationStatus.stopped,
    );
    final metricText = tester.widget<Text>(
      find.descendant(
        of: find.byType(PrimaryMetric),
        matching: find.byWidgetPredicate(
          (widget) => widget is Text && widget.textSpan?.toPlainText().startsWith('10 ') == true,
        ),
      ),
    );
    final metricSpans = (metricText.textSpan! as TextSpan).children!.cast<TextSpan>();
    expect(metricSpans.first.style!.color, statusColor);
    expect(metricSpans.last.style!.color, statusColor);

    await pumpArea(
      recentHourCoverage: 1800,
      periodCoverage: 569,
      observationStatus: core_domain.ObservationStatus.live,
    );
    expect(find.text('Estimated'), findsOneWidget);
    final primaryEstimateLabel = tester.element(find.byType(PrimaryMetric).first).l.insight_early_estimate;
    final primaryEstimateChip = tester.widget<Chip>(
      find.ancestor(
        of: find.descendant(of: find.byType(PrimaryMetric).first, matching: find.text(primaryEstimateLabel)),
        matching: find.byType(Chip),
      ),
    );
    final periodEstimateChip = tester.widget<Chip>(
      find.ancestor(of: find.text('Estimated'), matching: find.byType(Chip)),
    );
    for (final chip in [primaryEstimateChip, periodEstimateChip]) {
      expect(chip.backgroundColor, Colors.yellow.withValues(alpha: 0.18));
      expect(chip.labelStyle?.color, Colors.yellow.shade900.withValues(alpha: 0.9));
    }
    final periodTitle = find.descendant(of: find.byType(BusinessPeriodRow), matching: find.text('Morning'));
    final periodTitleBounds = tester.getRect(periodTitle);
    final periodValue = find.descendant(
      of: find.byType(BusinessPeriodRow),
      matching: find.byWidgetPredicate(
        (widget) => widget is Text && widget.textAlign == TextAlign.end && widget.style?.fontWeight == FontWeight.w600,
      ),
    );
    final periodEstimateBounds = tester.getRect(find.ancestor(of: find.text('Estimated'), matching: find.byType(Chip)));
    final periodValueBounds = tester.getRect(periodValue);
    expect(periodEstimateBounds.center.dy, closeTo(periodTitleBounds.center.dy, 1));
    expect(periodEstimateBounds.left, greaterThanOrEqualTo(periodTitleBounds.right - 1));
    expect(periodEstimateBounds.center.dy, isNot(closeTo(periodValueBounds.center.dy, 1)));
  });

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
                AreaInsightSection(
                  areaData: areas.first,
                  comparisonPeriod: core_domain.TrafficComparisonPeriod.yesterday,
                  observationStatus: core_domain.ObservationStatus.stopped,
                ),
                AreaInsightSection(
                  areaData: areas.last,
                  comparisonPeriod: core_domain.TrafficComparisonPeriod.yesterday,
                  observationStatus: core_domain.ObservationStatus.stopped,
                ),
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
    expect(find.text('Stopped'), findsNWidgets(2));
    final statusLabel = find.text('Stopped').first;
    expect(find.ancestor(of: statusLabel, matching: find.byType(Chip)), findsOneWidget);
    expect(find.ancestor(of: statusLabel, matching: find.byType(PrimaryMetric)), findsOneWidget);
    final metricChips = tester
        .widgetList<Chip>(find.descendant(of: find.byType(PrimaryMetric).first, matching: find.byType(Chip)))
        .toList();
    expect(metricChips, hasLength(2));
    expect(metricChips[0].shape, isA<StadiumBorder>());
    expect(metricChips[0].side, BorderSide.none);
    expect(metricChips[0].visualDensity, const VisualDensity(horizontal: -2, vertical: -4));
    expect(metricChips[0].padding, const EdgeInsets.symmetric(horizontal: 6));
    expect(metricChips[1].shape, metricChips[0].shape);
    expect(metricChips[1].side, metricChips[0].side);
    expect(metricChips[1].visualDensity, metricChips[0].visualDensity);
    expect(metricChips[1].padding, metricChips[0].padding);
    final statusColor = insightObservationStatusColor(
      tester.element(find.byType(PrimaryMetric).first),
      core_domain.ObservationStatus.stopped,
    );
    expect(metricChips[0].backgroundColor, statusColor.withValues(alpha: 0.18));
    expect(metricChips[0].labelStyle?.color, statusColor.withValues(alpha: 0.9));
    expect(metricChips[1].backgroundColor, Colors.yellow.withValues(alpha: 0.18));
    expect(metricChips[1].labelStyle?.color, Colors.yellow.shade900.withValues(alpha: 0.9));
    final titleRow = find.ancestor(of: find.text('Pass-by Traffic').first, matching: find.byType(Row)).first;
    expect(find.descendant(of: titleRow, matching: find.text('Stopped')), findsNothing);

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
              child: AreaInsightSection(
                areaData: area,
                comparisonPeriod: core_domain.TrafficComparisonPeriod.yesterday,
                observationStatus: core_domain.ObservationStatus.stopped,
              ),
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
              child: AreaInsightSection(
                areaData: area,
                comparisonPeriod: core_domain.TrafficComparisonPeriod.yesterday,
                observationStatus: core_domain.ObservationStatus.stopped,
              ),
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
