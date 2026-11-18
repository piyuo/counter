import 'package:counter_app/control_panel/utils/format_compact_duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_l10n/shared_l10n.dart';

void testWithLocalization(String description, void Function(BuildContext context) body) {
  testWidgets(description, (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: Localization.localizationsDelegates,
        supportedLocales: Localization.supportedLocales,
        home: const SizedBox(),
      ),
    );
    await tester.pumpAndSettle();
    body(tester.element(find.byType(SizedBox)));
  });
}

void main() {
  group('breakdownDuration', () {
    test('splits into days/hours/minutes/seconds', () {
      expect(breakdownDuration(90061), const DurationParts(1, 1, 1, 1));
    });

    test('supports value equality', () {
      expect(const DurationParts(1, 2, 3, 4), const DurationParts(1, 2, 3, 4));
    });
  });

  group('formatCompactDuration - seconds only (<60s)', () {
    testWithLocalization('accepts whole seconds only', (context) {
      expect(formatCompactDuration(context, 45), '45s');
    });

    testWithLocalization('0 seconds', (context) => expect(formatCompactDuration(context, 0), '0s'));
    testWithLocalization('30 seconds', (context) => expect(formatCompactDuration(context, 30), '30s'));
    testWithLocalization('59 seconds', (context) => expect(formatCompactDuration(context, 59), '59s'));

    testWithLocalization('whole seconds do not show decimal places', (context) {
      expect(formatCompactDuration(context, 5), '5s');
    });
  });

  group('formatCompactSeconds', () {
    testWithLocalization('formats seconds only with localized digit grouping and unit text', (context) {
      expect(formatCompactSeconds(context, 5), '5s');
      expect(formatCompactSeconds(context, 1234), '1,234s');
    });
  });

  group('formatCompactDuration - minutes/seconds (<1h)', () {
    testWithLocalization('exactly 1 minute collapses to single unit', (context) {
      expect(formatCompactDuration(context, 60), '1m');
    });
    testWithLocalization('1 minute 30 seconds', (context) => expect(formatCompactDuration(context, 90), '1m 30s'));
    testWithLocalization('5 minutes 45 seconds', (context) => expect(formatCompactDuration(context, 345), '5m 45s'));
    testWithLocalization('59 minutes 59 seconds', (context) => expect(formatCompactDuration(context, 3599), '59m 59s'));
    testWithLocalization(
      '2 minutes 0 seconds collapses',
      (context) => expect(formatCompactDuration(context, 120), '2m'),
    );
  });

  group('formatCompactDuration - hours/minutes (<24h)', () {
    testWithLocalization('exactly 1 hour collapses to single unit', (context) {
      expect(formatCompactDuration(context, 3600), '1h');
    });
    testWithLocalization('1 hour 30 minutes', (context) => expect(formatCompactDuration(context, 5400), '1h 30m'));
    testWithLocalization('2 hours 15 minutes', (context) => expect(formatCompactDuration(context, 8100), '2h 15m'));
    testWithLocalization(
      '2 hours 0 minutes collapses',
      (context) => expect(formatCompactDuration(context, 7200), '2h'),
    );
    testWithLocalization('23 hours 59 minutes', (context) => expect(formatCompactDuration(context, 86340), '23h 59m'));
  });

  group('formatCompactDuration - days/hours (>=24h)', () {
    testWithLocalization('exactly 1 day collapses to single unit', (context) {
      expect(formatCompactDuration(context, 86400), '1d');
    });
    testWithLocalization('1 day 12 hours', (context) => expect(formatCompactDuration(context, 129600), '1d 12h'));
    testWithLocalization('5 days 3 hours', (context) => expect(formatCompactDuration(context, 442800), '5d 3h'));
    testWithLocalization(
      '10 days 0 hours collapses',
      (context) => expect(formatCompactDuration(context, 864000), '10d'),
    );
    testWithLocalization('365 days exactly', (context) => expect(formatCompactDuration(context, 31536000), '365d'));

    testWithLocalization('a value that lands mid-tier with a sub-hour remainder still collapses', (context) {
      // 5 days + 3 minutes -- remainder is under an hour, so hours == 0.
      expect(formatCompactDuration(context, 432180), '5d');
    });
  });

  group('formatCompactDuration - large duration sanity check', () {
    testWithLocalization('11 days 13 hours 46 minutes 40 seconds -> shows days/hours', (context) {
      expect(formatCompactDuration(context, 1000000), '11d 13h');
    });
  });

  group('formatCompactDuration - localized interpolation', () {
    testWithLocalization('passes units through localization methods', (context) {
      expect(formatCompactDuration(context, 90), '1m 30s');
    });
  });
}
