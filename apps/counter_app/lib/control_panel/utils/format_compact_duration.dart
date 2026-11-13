import 'package:shared_l10n/shared_l10n.dart';

class DurationParts {
  final int days, hours, minutes, seconds;
  const DurationParts(this.days, this.hours, this.minutes, this.seconds);

  @override
  bool operator ==(Object other) =>
      other is DurationParts &&
      days == other.days &&
      hours == other.hours &&
      minutes == other.minutes &&
      seconds == other.seconds;

  @override
  int get hashCode => Object.hash(days, hours, minutes, seconds);

  @override
  String toString() => 'DurationParts(days: $days, hours: $hours, minutes: $minutes, seconds: $seconds)';
}

/// Splits whole [totalSeconds] into day/hour/minute/second components.
DurationParts breakdownDuration(int totalSeconds) => DurationParts(
  totalSeconds ~/ 86400,
  (totalSeconds % 86400) ~/ 3600,
  (totalSeconds % 3600) ~/ 60,
  totalSeconds % 60,
);

/// Formats [totalSeconds] into a compact, localized, at-most-two-unit
/// string suitable for tight UI space (e.g. "2m 45s", "1d", "23h 59m").
///
/// Tiers:
/// - < 60s          -> whole seconds only
/// - < 1 hour       -> minutes [+ seconds if seconds != 0]
/// - < 1 day        -> hours [+ minutes if minutes != 0]
/// - >= 1 day       -> days [+ hours if hours != 0]
///
/// When [fixedWidth] is true, the output keeps a stable character count
/// within a tier so live-updating text doesn't jump:
/// - the second unit is always shown, even when zero ("2m 00s", not "2m")
/// - the trailing unit is zero-padded to two digits ("32m 02s", "1h 05m")
/// - the seconds-only tier is padded too ("05s")
/// Pair this with `FontFeature.tabularFigures()` on the Text style so the
/// digits themselves are equal width. Width still changes when the value
/// crosses into a new tier (e.g. 59s -> 1m 00s), which is unavoidable.
///
/// Takes [Localization] directly rather than a `BuildContext` so this stays
/// a pure function: no widget tree dependency, trivially unit-testable, and
/// usable outside of build methods (isolates, background formatting, etc).
/// At call sites, pass `context.l` — e.g. `formatCompactDuration(context.l, seconds)`.
String formatCompactDuration(Localization l10n, int totalSeconds, {bool fixedWidth = false}) {
  final total = totalSeconds;
  final p = breakdownDuration(totalSeconds);

  String num(int value, {bool pad = false}) => pad ? value.toString().padLeft(2, '0') : value.toString();

  String unit(String pattern, int value, {bool pad = false}) => pattern.replaceAll('%s', num(value, pad: pad));

  String twoUnit(String first, String second) =>
      l10n.durationTwoUnit.replaceFirst('%first', first).replaceFirst('%second', second);

  if (total < 60) {
    return unit(l10n.durationSecondsShort, total, pad: fixedWidth);
  } else if (total < 3600) {
    if (p.seconds == 0 && !fixedWidth) return unit(l10n.durationMinutesShort, p.minutes);
    return twoUnit(
      unit(l10n.durationMinutesShort, p.minutes),
      unit(l10n.durationSecondsShort, p.seconds, pad: fixedWidth),
    );
  } else if (total < 86400) {
    if (p.minutes == 0 && !fixedWidth) return unit(l10n.durationHoursShort, p.hours);
    return twoUnit(unit(l10n.durationHoursShort, p.hours), unit(l10n.durationMinutesShort, p.minutes, pad: fixedWidth));
  } else {
    if (p.hours == 0 && !fixedWidth) return unit(l10n.durationDaysShort, p.days);
    return twoUnit(unit(l10n.durationDaysShort, p.days), unit(l10n.durationHoursShort, p.hours, pad: fixedWidth));
  }
}
