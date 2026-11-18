import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_domain/model/observation_series.dart';
import 'package:counter_app/control_panel/insights/area_section.dart';
import 'package:counter_app/control_panel/insights/dashboard_formatter.dart';
import 'package:counter_app/control_panel/insights/insight_chart.dart';
import 'package:counter_app/control_panel/insights/insight_comparison_period_dropdown.dart';
import 'package:counter_app/control_panel/insights/primary_metric.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_l10n/generated/localization_de.dart';
import 'package:shared_l10n/shared_l10n.dart';

class _GermanLocalizationDelegate extends LocalizationsDelegate<Localization> {
  const _GermanLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'de';

  @override
  Future<Localization> load(Locale locale) => SynchronousFuture(LocalizationDe());

  @override
  bool shouldReload(_GermanLocalizationDelegate old) => false;
}

class _TestAppNotifier extends core_domain.AppNotifier {
  @override
  Future<core_domain.AppState> build() async => const core_domain.AppState();
}

Widget _withAppState(Widget child) =>
    ProviderScope(overrides: [core_domain.appProvider.overrideWith(_TestAppNotifier.new)], child: child);

core_domain.DashboardCardData _chartCard({
  core_domain.DashboardMetric metric = core_domain.DashboardMetric.passBy,
  double? todayValue = 340,
  double? comparisonValue = 310,
  double? liveRate,
  List<core_domain.DashboardChartPoint>? chartPoints,
}) => core_domain.DashboardCardData(
  metric: metric,
  primary: liveRate == null
      ? null
      : core_domain.DashboardMeasurement(amount: liveRate, metric: metric, expectedSeconds: 3600, coveredSeconds: 2400),
  recentHourObservations: null,
  comparisonValue: null,
  periods: const [],
  chartPoints:
      chartPoints ??
      [
        for (var hour = 0; hour < 24; hour++)
          core_domain.DashboardChartPoint(
            minuteOfDay: hour * 60,
            todayValue: hour == 12 ? todayValue : null,
            comparisonValue: hour == 12 ? comparisonValue : null,
          ),
      ],
);

Widget _chartApp(
  core_domain.DashboardCardData card, {
  Locale locale = const Locale('en'),
  ThemeData? theme,
  String comparisonLabel = 'Yesterday',
  int? currentHour,
  bool showLiveMarker = true,
  VoidCallback? onHourlyBarsPaint,
  VoidCallback? onExtremeLabelsPaint,
  VoidCallback? onLiveMarkerPaint,
}) => MaterialApp(
  locale: locale,
  theme: theme ?? ThemeData.light(),
  localizationsDelegates: locale.languageCode == 'de'
      ? [const _GermanLocalizationDelegate(), ...Localization.localizationsDelegates.skip(1)]
      : Localization.localizationsDelegates,
  supportedLocales: Localization.supportedLocales,
  home: Scaffold(
    body: InsightChart(
      data: card,
      metricLabel: 'Metric',
      comparisonLabel: comparisonLabel,
      height: 150,
      currentHour: currentHour,
      showLiveMarker: showLiveMarker,
      onHourlyBarsPaint: onHourlyBarsPaint,
      onExtremeLabelsPaint: onExtremeLabelsPaint,
      onLiveMarkerPaint: onLiveMarkerPaint,
    ),
  ),
);

String _normalizeSemanticText(String value) => value.replaceAll('\u202f', ' ').replaceAll('\u00a0', ' ');

void main() {
  testWidgets('overlapping hourly series show labels and selectable values', (tester) async {
    await tester.pumpWidget(_chartApp(_chartCard()));
    await tester.pumpAndSettle();

    expect(find.text('Hourly breakdown'), findsOneWidget);
    for (final hour in [0, 3, 6, 9, 12, 15, 18, 21, 24]) {
      expect(find.text(hour.toString().padLeft(2, '0')), findsOneWidget);
    }
    expect(find.text('01'), findsNothing);
    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Yesterday'), findsOneWidget);

    final plot = find.byKey(const ValueKey('insight-hourly-plot'));
    final origin = tester.getTopLeft(plot);
    final size = tester.getSize(plot);
    await tester.tapAt(origin + Offset(size.width * 12.5 / 24, size.height / 2));
    await tester.pumpAndSettle();

    expect(find.textContaining('12:00'), findsOneWidget);
    expect(find.text('Today: 340'), findsOneWidget);
    expect(find.text('Yesterday: 310'), findsOneWidget);
    expect(find.text('+9.7%'), findsOneWidget);
  });

  testWidgets('hourly chart labels overall extrema across both series', (tester) async {
    final points = [
      for (var hour = 0; hour < 24; hour++)
        core_domain.DashboardChartPoint(
          minuteOfDay: hour * 60,
          todayValue: switch (hour) {
            9 => 120,
            10 => 180,
            11 => 350,
            12 => 300,
            _ => null,
          },
          comparisonValue: switch (hour) {
            9 => 100,
            10 => 90,
            11 => 310,
            12 => 400,
            _ => null,
          },
        ),
    ];

    await tester.pumpWidget(_chartApp(_chartCard(chartPoints: points)));
    await tester.pumpAndSettle();

    final labels = find.byKey(const ValueKey('insight-hourly-extreme-labels'));
    expect(labels, findsOneWidget);
    final semanticLabel = tester.getSemantics(labels).label;
    expect(semanticLabel, contains('400, 12:00'));
    expect(semanticLabel, contains('90, 10:00'));
    expect(semanticLabel.split('; '), hasLength(2));
  });

  testWidgets('all-zero chart selects one observed value and invalid data selects none', (tester) async {
    final zeros = [
      for (var hour = 0; hour < 24; hour++)
        core_domain.DashboardChartPoint(minuteOfDay: hour * 60, todayValue: 0, comparisonValue: 0),
    ];
    await tester.pumpWidget(_chartApp(_chartCard(chartPoints: zeros)));
    await tester.pumpAndSettle();

    final labels = find.byKey(const ValueKey('insight-hourly-extreme-labels'));
    expect(labels, findsOneWidget);
    final zeroLabel = _normalizeSemanticText(tester.getSemantics(labels).label);
    expect(zeroLabel, contains('0, 12:00 AM'));
    expect(zeroLabel.split('; '), hasLength(1));

    final invalid = [
      const core_domain.DashboardChartPoint(minuteOfDay: 0, todayValue: double.nan),
      const core_domain.DashboardChartPoint(minuteOfDay: 60, comparisonValue: double.infinity),
      const core_domain.DashboardChartPoint(minuteOfDay: 120, todayValue: -1),
      const core_domain.DashboardChartPoint(minuteOfDay: -60, todayValue: 100),
      const core_domain.DashboardChartPoint(minuteOfDay: 24 * 60, comparisonValue: 100),
    ];
    await tester.pumpWidget(_chartApp(_chartCard(chartPoints: invalid)));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('insight-hourly-extreme-labels')), findsNothing);
  });

  testWidgets('equal extrema prefer Today, then the earlier hour', (tester) async {
    final points = [
      for (var hour = 0; hour < 24; hour++)
        core_domain.DashboardChartPoint(
          minuteOfDay: hour * 60,
          todayValue: switch (hour) {
            6 => 0,
            7 => 0,
            8 => 0,
            12 => 10,
            13 => 10,
            14 => 10,
            _ => null,
          },
          comparisonValue: switch (hour) {
            8 => 0,
            12 => 10,
            14 => 10,
            _ => null,
          },
        ),
    ];

    await tester.pumpWidget(_chartApp(_chartCard(chartPoints: points)));
    await tester.pumpAndSettle();

    final label = _normalizeSemanticText(
      tester.getSemantics(find.byKey(const ValueKey('insight-hourly-extreme-labels'))).label,
    );
    expect(label, contains('10, 12:00 PM - 1:00 PM, Today'));
    expect(label, contains('0, 6:00 AM - 7:00 AM, Today'));
  });

  testWidgets('live rate marker uses the KPI value in the current hour', (tester) async {
    await tester.pumpWidget(_chartApp(_chartCard(liveRate: 343.4), currentHour: 12));
    await tester.pumpAndSettle();

    final marker = find.byKey(const ValueKey('insight-live-rate-marker'));
    expect(marker, findsOneWidget);
    expect(find.text('Live'), findsOneWidget);
    final markerSemantics = tester.getSemantics(marker).getSemanticsData();
    expect(markerSemantics.label, contains('Live'));
    expect(markerSemantics.value, contains('12:00'));
    expect(markerSemantics.value, contains('343'));
    expect(markerSemantics.value, isNot(contains('343.4')));

    await tester.pumpWidget(_chartApp(_chartCard(liveRate: 344.6), currentHour: 13));
    await tester.pumpAndSettle();
    final updatedSemantics = tester.getSemantics(marker).getSemanticsData();
    expect(updatedSemantics.value, contains('1:00'));
    expect(updatedSemantics.value, contains('345'));
    expect(updatedSemantics.value, isNot(contains('343')));
  });

  testWidgets('live marker is hidden for unavailable, invalid, stopped, and unsupported KPIs', (tester) async {
    for (final card in [
      _chartCard(),
      _chartCard(liveRate: double.nan),
      _chartCard(liveRate: -1),
      _chartCard(metric: core_domain.DashboardMetric.occupancyMean, liveRate: 420),
      _chartCard(metric: core_domain.DashboardMetric.dwellTimeMean, liveRate: 420),
    ]) {
      await tester.pumpWidget(_chartApp(card, currentHour: 12));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('insight-live-rate-marker')), findsNothing);
    }

    await tester.pumpWidget(_chartApp(_chartCard(liveRate: 420), currentHour: 12, showLiveMarker: false));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('insight-live-rate-marker')), findsNothing);
  });

  testWidgets('live updates repaint only the marker unless the shared scale expands', (tester) async {
    final points = _chartCard().chartPoints;
    var barsPaintCount = 0;
    var labelsPaintCount = 0;
    var markerPaintCount = 0;
    Future<void> pumpRate(double rate, {int hour = 12}) async {
      await tester.pumpWidget(
        _chartApp(
          _chartCard(chartPoints: points, liveRate: rate),
          currentHour: hour,
          onHourlyBarsPaint: () => barsPaintCount++,
          onExtremeLabelsPaint: () => labelsPaintCount++,
          onLiveMarkerPaint: () => markerPaintCount++,
        ),
      );
      await tester.pumpAndSettle();
    }

    await pumpRate(200);
    var previousBarsPaintCount = barsPaintCount;
    var previousLabelsPaintCount = labelsPaintCount;
    var previousMarkerPaintCount = markerPaintCount;

    await pumpRate(250);
    expect(barsPaintCount, previousBarsPaintCount);
    expect(labelsPaintCount, previousLabelsPaintCount);
    expect(markerPaintCount, greaterThan(previousMarkerPaintCount));
    previousBarsPaintCount = barsPaintCount;
    previousLabelsPaintCount = labelsPaintCount;
    previousMarkerPaintCount = markerPaintCount;

    await pumpRate(420);
    expect(barsPaintCount, greaterThan(previousBarsPaintCount));
    expect(labelsPaintCount, greaterThan(previousLabelsPaintCount));
    expect(markerPaintCount, greaterThan(previousMarkerPaintCount));
    previousBarsPaintCount = barsPaintCount;
    previousLabelsPaintCount = labelsPaintCount;
    previousMarkerPaintCount = markerPaintCount;

    await pumpRate(250);
    expect(barsPaintCount, previousBarsPaintCount);
    expect(labelsPaintCount, previousLabelsPaintCount);
    expect(markerPaintCount, greaterThan(previousMarkerPaintCount));
    previousBarsPaintCount = barsPaintCount;
    previousLabelsPaintCount = labelsPaintCount;
    previousMarkerPaintCount = markerPaintCount;

    await pumpRate(250, hour: 13);
    expect(barsPaintCount, previousBarsPaintCount);
    expect(labelsPaintCount, previousLabelsPaintCount);
    expect(markerPaintCount, greaterThan(previousMarkerPaintCount));
  });

  testWidgets('empty hourly chart keeps all 24 positions and a fixed timeline', (tester) async {
    final card = core_domain.DashboardCache()
        .build(
          insightState: const core_domain.InsightState(businessDate: '2026-10-29'),
          customAreas: const [],
          businessPeriods: const [],
          now: DateTime(2026, 10, 29, 12, 7),
        )
        .single
        .card(core_domain.DashboardMetric.passBy);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: Localization.localizationsDelegates,
        supportedLocales: Localization.supportedLocales,
        home: Scaffold(
          body: InsightChart(data: card, metricLabel: 'Pass-by', comparisonLabel: 'Yesterday', height: 150),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(card.chartPoints, hasLength(24));
    final plot = find.byKey(const ValueKey('insight-hourly-plot'));
    expect(plot, findsOneWidget);
    expect(tester.getSize(plot).height, 128);
    expect(tester.getSize(plot).width, tester.getSize(find.byType(InsightChart)).width);
    for (final hour in [0, 3, 6, 9, 12, 15, 18, 21, 24]) {
      expect(find.text(hour.toString().padLeft(2, '0')), findsOneWidget);
    }
    expect(find.text('01'), findsNothing);
  });

  testWidgets('formats hourly values using the active locale', (tester) async {
    await tester.pumpWidget(
      _chartApp(
        _chartCard(metric: core_domain.DashboardMetric.occupancyMean, todayValue: 5.75, comparisonValue: null),
        locale: const Locale('de'),
        currentHour: 12,
      ),
    );
    await tester.pumpAndSettle();
    final plot = find.byKey(const ValueKey('insight-hourly-plot'));
    final origin = tester.getTopLeft(plot);
    final size = tester.getSize(plot);
    await tester.tapAt(origin + Offset(size.width * 12.5 / 24, size.height / 2));
    await tester.pumpAndSettle();
    expect(find.text('Heute: 5,75'), findsOneWidget);
    expect(find.textContaining('/hr'), findsNothing);
  });

  testWidgets('small viewport avoids overflow and shows the 24 label across full width', (tester) async {
    tester.view.physicalSize = const Size(220, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_chartApp(_chartCard(liveRate: 420), currentHour: 12));
    await tester.pumpAndSettle();

    expect(find.text('00'), findsOneWidget);
    expect(find.text('21'), findsOneWidget);
    expect(find.text('24'), findsOneWidget);
    expect(find.byKey(const ValueKey('insight-live-rate-marker')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('opens localized chart explanation from the accessible info button', (tester) async {
    final localization = LocalizationDe();

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('de'),
        localizationsDelegates: [const _GermanLocalizationDelegate(), ...Localization.localizationsDelegates.skip(1)],
        supportedLocales: Localization.supportedLocales,
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 500,
              child: InsightChart(
                data: _chartCard(),
                metricLabel: 'Pass-by',
                comparisonLabel: 'Vergleichszeitraum',
                height: 150,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));

    final title = localization.insight_chart_info_title;
    final description = localization.insight_chart_hourly_info;
    final units = localization.insight_chart_info_units;
    final infoButton = tester.widget<IconButton>(
      find.ancestor(of: find.byIcon(Icons.info_outline), matching: find.byType(IconButton)),
    );
    final infoButtonFinder = find.ancestor(of: find.byIcon(Icons.info_outline), matching: find.byType(IconButton));
    final todayLegendFinder = find.text(localization.traffic_period_today);
    expect(infoButton.icon, isA<Icon>());
    expect((infoButton.icon as Icon).icon, Icons.info_outline);
    expect(tester.getTopRight(infoButtonFinder).dx, tester.getTopRight(find.byType(InsightChart)).dx);
    expect(tester.getCenter(infoButtonFinder).dy, tester.getCenter(todayLegendFinder).dy);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byTooltip(title));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text(title), findsOneWidget);
    expect(find.textContaining(description), findsOneWidget);
    expect(find.textContaining(units), findsOneWidget);
    expect(find.text('$description\n\n$units'), findsOneWidget);

    await tester.tap(find.byType(TextButton));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text(title), findsNothing);
  });

  testWidgets('shows placeholders for missing hourly values', (tester) async {
    final card = core_domain.DashboardCardData(
      metric: core_domain.DashboardMetric.passBy,
      primary: null,
      recentHourObservations: null,
      comparisonValue: null,
      periods: const [],
      chartPoints: [
        for (var hour = 0; hour < 24; hour++)
          core_domain.DashboardChartPoint(
            minuteOfDay: hour * 60,
            comparisonValue: hour == 13 ? 2 : null,
            todayValue: hour == 9 || hour == 10 || hour == 12 || hour == 13 ? 1 : null,
          ),
      ],
    );

    await tester.pumpWidget(_chartApp(card));
    await tester.pumpAndSettle();

    final plot = find.byKey(const ValueKey('insight-hourly-plot'));
    final origin = tester.getTopLeft(plot);
    final size = tester.getSize(plot);
    await tester.tapAt(origin + Offset(size.width * 11.5 / 24, size.height / 2));
    await tester.pumpAndSettle();

    expect(find.text('Today: -'), findsOneWidget);
    expect(find.text('Yesterday: -'), findsOneWidget);
  });

  testWidgets('shows observed coverage for incomplete period values', (tester) async {
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
      final areaData = core_domain.DashboardCache()
          .build(
            insightState: core_domain.InsightState(
              businessDate: '2026-10-29',
              todaySeries: ObservationSeries.fromObservations([
                observation(0, 300),
                observation(5, periodCoverage - 300),
              ]),
              recentHourTotal: observation(0, recentHourCoverage),
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
            body: _withAppState(
              AreaSection(
                areaData: areaData,
                comparisonPeriod: core_domain.TrafficPeriod.yesterday,
                onComparisonChanged: (_) {},
                observationStatus: observationStatus,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    await pumpArea(recentHourCoverage: 3600, periodCoverage: 600);
    final statusColor = formatObservationStatusColor(
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
      observationStatus: core_domain.ObservationStatus.started,
    );
    final primaryContext = tester.element(find.byType(PrimaryMetric).first);
    final basedOnMinutesLabel = primaryContext.l.insight_based_on_min('30');
    expect(find.text(basedOnMinutesLabel), findsOneWidget);
  });

  testWidgets('comparison dropdown in the primary metric changes its period', (tester) async {
    final area = core_domain.DashboardCache()
        .build(
          insightState: const core_domain.InsightState(businessDate: '2026-10-29'),
          customAreas: const [core_domain.InterestArea(id: 37, name: 'Entrance')],
          businessPeriods: const [],
          now: DateTime(2026, 10, 29, 12),
        )
        .first;
    var selectedPeriod = core_domain.TrafficPeriod.yesterday;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: Localization.localizationsDelegates,
        supportedLocales: Localization.supportedLocales,
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => _withAppState(
              AreaSection(
                areaData: area,
                comparisonPeriod: selectedPeriod,
                onComparisonChanged: (period) => setState(() => selectedPeriod = period),
                observationStatus: core_domain.ObservationStatus.stopped,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(DropdownButton<core_domain.TrafficPeriod>), findsOneWidget);
    final context = tester.element(find.byType(PrimaryMetric));
    final lastWeekLabel = context.l.insight_comparison_period(context.l.traffic_period_last_week);
    await tester.tap(find.byType(DropdownButton<core_domain.TrafficPeriod>));
    await tester.pumpAndSettle();
    await tester.tap(find.text(lastWeekLabel).last);
    await tester.pumpAndSettle();

    expect(selectedPeriod, core_domain.TrafficPeriod.sameDayLastWeek);
    expect(find.text(lastWeekLabel), findsOneWidget);
  });

  testWidgets('comparison period dropdown accepts a custom font size', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: Localization.localizationsDelegates,
        supportedLocales: Localization.supportedLocales,
        home: Scaffold(
          body: SizedBox(
            width: 240,
            child: InsightComparisonPeriodDropdown(
              value: core_domain.TrafficPeriod.yesterday,
              onChanged: (_) {},
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final dropdown = tester.widget<DropdownButton<core_domain.TrafficPeriod>>(
      find.byType(DropdownButton<core_domain.TrafficPeriod>),
    );
    expect(dropdown.style?.fontSize, 18);
  });

  testWidgets('horizontal paging changes metrics without losing the area section', (tester) async {
    final areas = core_domain.DashboardCache().build(
      insightState: const core_domain.InsightState(businessDate: '2026-10-29'),
      customAreas: const [core_domain.InterestArea(id: 37, name: 'Entrance')],
      businessPeriods: const [],
      now: DateTime(2026, 10, 29, 12),
    );
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: Localization.localizationsDelegates,
        supportedLocales: Localization.supportedLocales,
        home: Scaffold(
          body: _withAppState(
            SingleChildScrollView(
              child: Column(
                children: [
                  AreaSection(
                    areaData: areas.first,
                    comparisonPeriod: core_domain.TrafficPeriod.yesterday,
                    onComparisonChanged: (_) {},
                    observationStatus: core_domain.ObservationStatus.stopped,
                  ),
                  AreaSection(
                    areaData: areas.last,
                    comparisonPeriod: core_domain.TrafficPeriod.yesterday,
                    onComparisonChanged: (_) {},
                    observationStatus: core_domain.ObservationStatus.stopped,
                  ),
                ],
              ),
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
    expect(metricChips, hasLength(1));
    expect(metricChips[0].shape, isA<StadiumBorder>());
    expect(metricChips[0].side, BorderSide.none);
    expect(metricChips[0].visualDensity, const VisualDensity(horizontal: -2, vertical: -4));
    expect(metricChips[0].padding, const EdgeInsets.symmetric(horizontal: 6));
    final statusColor = formatObservationStatusColor(
      tester.element(find.byType(PrimaryMetric).first),
      core_domain.ObservationStatus.stopped,
    );
    expect(metricChips[0].backgroundColor, statusColor.withValues(alpha: 0.18));
    expect(metricChips[0].labelStyle?.color, statusColor.withValues(alpha: 0.9));
    expect(find.text(tester.element(find.byType(PrimaryMetric).first).l.insight_counting_paused), findsNothing);
    final titleTile = find.ancestor(of: find.text('Pass-by Traffic').first, matching: find.byType(ListTile)).first;
    expect(titleTile, findsOneWidget);
    expect(find.descendant(of: titleTile, matching: find.text('Stopped')), findsNothing);

    await tester.drag(find.byType(Card).first, const Offset(-300, 0));
    await tester.pumpAndSettle();

    expect(find.text('2/${areas.first.cards.length}'), findsOneWidget);
    expect(find.text('Lingering'), findsOneWidget);
    expect(find.text('Pass-by Traffic'), findsOneWidget);
    expect(find.text('Entrance'), findsOneWidget);
    expect(find.byIcon(Icons.chevron_left), findsNWidgets(2));
    expect(find.byIcon(Icons.chevron_right), findsNWidgets(2));

    final firstAreaSection = find.byType(AreaSection).first;
    await tester.tap(find.descendant(of: firstAreaSection, matching: find.byIcon(Icons.chevron_left)));
    await tester.pump();
    final incomingPassByTitle = find.descendant(of: firstAreaSection, matching: find.text('Pass-by Traffic'));
    final passByStartX = tester.getCenter(incomingPassByTitle).dx;
    await tester.pump(const Duration(milliseconds: 100));
    expect(tester.getCenter(incomingPassByTitle).dx, greaterThan(passByStartX));
    await tester.pumpAndSettle();
    expect(find.descendant(of: firstAreaSection, matching: find.text('1/${areas.first.cards.length}')), findsOneWidget);
    expect(find.descendant(of: firstAreaSection, matching: find.text('Pass-by Traffic')), findsOneWidget);

    await tester.tap(find.descendant(of: firstAreaSection, matching: find.byIcon(Icons.chevron_right)));
    await tester.pump();
    final incomingLingeringTitle = find.descendant(of: firstAreaSection, matching: find.text('Lingering'));
    final lingeringStartX = tester.getCenter(incomingLingeringTitle).dx;
    await tester.pump(const Duration(milliseconds: 100));
    expect(tester.getCenter(incomingLingeringTitle).dx, lessThan(lingeringStartX));
    await tester.pumpAndSettle();
    expect(find.descendant(of: firstAreaSection, matching: find.text('2/${areas.first.cards.length}')), findsOneWidget);
    expect(find.descendant(of: firstAreaSection, matching: find.text('Lingering')), findsOneWidget);

    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -900));
    await tester.pumpAndSettle();
    expect(find.byType(AreaSection), findsNWidgets(2));
  });

  testWidgets('insight card height follows its business-period content', (tester) async {
    final compactArea = core_domain.DashboardCache()
        .build(
          insightState: const core_domain.InsightState(businessDate: '2026-10-29'),
          customAreas: const [],
          businessPeriods: const [],
          now: DateTime(2026, 10, 29, 12),
        )
        .single;
    final expandedArea = core_domain.DashboardCache()
        .build(
          insightState: const core_domain.InsightState(businessDate: '2026-10-29'),
          customAreas: const [],
          businessPeriods: core_domain.BusinessPeriod.defaultSchedule,
          now: DateTime(2026, 10, 29, 12),
        )
        .single;

    Future<double> cardHeight(core_domain.DashboardAreaData area) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: Localization.localizationsDelegates,
          supportedLocales: Localization.supportedLocales,
          home: Scaffold(
            body: _withAppState(
              SingleChildScrollView(
                child: AreaSection(
                  areaData: area,
                  comparisonPeriod: core_domain.TrafficPeriod.yesterday,
                  onComparisonChanged: (_) {},
                  observationStatus: core_domain.ObservationStatus.stopped,
                ),
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
    final area = core_domain.DashboardCache()
        .build(
          insightState: const core_domain.InsightState(businessDate: '2026-10-29'),
          customAreas: const [],
          businessPeriods: core_domain.BusinessPeriod.defaultSchedule,
          now: DateTime(2026, 10, 29, 12),
        )
        .single;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: Localization.localizationsDelegates,
        supportedLocales: Localization.supportedLocales,
        home: _withAppState(
          MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(1.6)),
            child: Scaffold(
              body: SingleChildScrollView(
                child: AreaSection(
                  areaData: area,
                  comparisonPeriod: core_domain.TrafficPeriod.yesterday,
                  onComparisonChanged: (_) {},
                  observationStatus: core_domain.ObservationStatus.stopped,
                ),
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
