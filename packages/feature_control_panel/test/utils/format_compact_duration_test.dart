import 'package:feature_control_panel/utils/format_compact_duration.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_l10n/shared_l10n.dart';

// Fake implementation of Localization for testing.
// Uses Fake instead of Mock to avoid noSuchMethod complications with getters.
class _FakeLocalization extends Fake implements Localization {
  @override
  String durationSecondsShort = '%ss';

  @override
  String durationMinutesShort = '%sm';

  @override
  String durationHoursShort = '%sh';

  @override
  String durationDaysShort = '%sd';

  @override
  String durationTwoUnit = '%first %second';
}

void main() {
  late _FakeLocalization l10n;

  setUp(() {
    l10n = _FakeLocalization();
  });

  group('breakdownDuration', () {
    test('splits into days/hours/minutes/seconds', () {
      expect(breakdownDuration(90061), const DurationParts(1, 1, 1, 1));
    });

    test('rounds fractional seconds before splitting', () {
      expect(breakdownDuration(59.6), const DurationParts(0, 0, 1, 0));
    });

    test('supports value equality', () {
      expect(const DurationParts(1, 2, 3, 4), const DurationParts(1, 2, 3, 4));
    });
  });

  group('formatCompactDuration - seconds only (<60s)', () {
    test('0 seconds', () => expect(formatCompactDuration(l10n, 0), '0s'));
    test('30 seconds', () => expect(formatCompactDuration(l10n, 30), '30s'));
    test('59 seconds', () => expect(formatCompactDuration(l10n, 59), '59s'));
    test('rounds up within tier', () => expect(formatCompactDuration(l10n, 29.6), '30s'));

    test('.round() rounds halves away from zero, not down', () {
      // 0.5.round() == 1 in Dart, not 0 -- documenting this explicitly since
      // it's easy to assume banker's rounding or round-towards-zero here.
      expect(formatCompactDuration(l10n, 0.5), '1s');
    });

    test('boundary just under 1 minute stays in seconds tier', () {
      expect(formatCompactDuration(l10n, 59.4), '59s');
    });
  });

  group('formatCompactDuration - minutes/seconds (<1h)', () {
    test('exactly 1 minute collapses to single unit', () {
      expect(formatCompactDuration(l10n, 60), '1m');
    });
    test('1 minute 30 seconds', () => expect(formatCompactDuration(l10n, 90), '1m 30s'));
    test('5 minutes 45 seconds', () => expect(formatCompactDuration(l10n, 345), '5m 45s'));
    test('59 minutes 59 seconds', () => expect(formatCompactDuration(l10n, 3599), '59m 59s'));
    test('2 minutes 0 seconds collapses', () => expect(formatCompactDuration(l10n, 120), '2m'));

    test('boundary just under 1 hour stays in minutes/seconds tier', () {
      expect(formatCompactDuration(l10n, 3599.4), '59m 59s');
    });

    test('rounding a hair over 1 minute rolls into the next tier', () {
      // 59.9.round() == 60, so this is NOT '60s' -- it's '1m'. Documents the
      // rollover behavior at the tier boundary rather than asserting the
      // (incorrect) pre-round value.
      expect(formatCompactDuration(l10n, 59.9), '1m');
    });
  });

  group('formatCompactDuration - hours/minutes (<24h)', () {
    test('exactly 1 hour collapses to single unit', () {
      expect(formatCompactDuration(l10n, 3600), '1h');
    });
    test('1 hour 30 minutes', () => expect(formatCompactDuration(l10n, 5400), '1h 30m'));
    test('2 hours 15 minutes', () => expect(formatCompactDuration(l10n, 8100), '2h 15m'));
    test('2 hours 0 minutes collapses', () => expect(formatCompactDuration(l10n, 7200), '2h'));
    test('23 hours 59 minutes', () => expect(formatCompactDuration(l10n, 86340), '23h 59m'));

    test('boundary just under 1 day stays in hours/minutes tier', () {
      expect(formatCompactDuration(l10n, 86399.4), '23h 59m');
    });

    test('rounding a hair over 1 hour rolls into the next tier', () {
      expect(formatCompactDuration(l10n, 3599.9), '1h');
    });
  });

  group('formatCompactDuration - days/hours (>=24h)', () {
    test('exactly 1 day collapses to single unit', () {
      expect(formatCompactDuration(l10n, 86400), '1d');
    });
    test('1 day 12 hours', () => expect(formatCompactDuration(l10n, 129600), '1d 12h'));
    test('5 days 3 hours', () => expect(formatCompactDuration(l10n, 442800), '5d 3h'));
    test('10 days 0 hours collapses', () => expect(formatCompactDuration(l10n, 864000), '10d'));
    test('365 days exactly', () => expect(formatCompactDuration(l10n, 31536000), '365d'));

    test('rounding a hair over 1 day rolls into the next tier', () {
      expect(formatCompactDuration(l10n, 86399.9), '1d');
    });

    test('a value that lands mid-tier with a sub-hour remainder still collapses', () {
      // 5 days + 3 minutes -- remainder is under an hour, so hours == 0.
      expect(formatCompactDuration(l10n, 432180), '5d');
    });
  });

  group('formatCompactDuration - large duration sanity check', () {
    test('11 days 13 hours 46 minutes 40 seconds -> shows days/hours', () {
      expect(formatCompactDuration(l10n, 1000000), '11d 13h');
    });
  });

  group('formatCompactDuration - localization drives formatting, not Dart code', () {
    test('only substitutes the %s token, leaves surrounding text untouched', () {
      l10n.durationSecondsShort = 'sec:%s!';
      expect(formatCompactDuration(l10n, 45), 'sec:45!');
    });

    test('durationTwoUnit template controls both spacing and ordering', () {
      l10n.durationTwoUnit = '%second-%first';
      expect(formatCompactDuration(l10n, 90), '30s-1m');
    });

    test('durationTwoUnit with no separator (e.g. CJK-style concatenation)', () {
      l10n.durationTwoUnit = '%first%second';
      expect(formatCompactDuration(l10n, 5400), '1h30m');
    });
  });
}
