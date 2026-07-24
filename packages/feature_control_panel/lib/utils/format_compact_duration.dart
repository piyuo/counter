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

/// Splits [totalSeconds] into day/hour/minute/second components.
/// Rounds to the nearest whole second first (away from zero, per
/// [double.round] semantics) before splitting.
DurationParts breakdownDuration(double totalSeconds) {
  final total = totalSeconds.round();
  return DurationParts(total ~/ 86400, (total % 86400) ~/ 3600, (total % 3600) ~/ 60, total % 60);
}

/// Formats [totalSeconds] into a compact, localized, at-most-two-unit
/// string suitable for tight UI space (e.g. "2m 45s", "1d", "23h 59m").
///
/// Tiers:
/// - < 60s          -> seconds only
/// - < 1 hour        -> minutes [+ seconds if seconds != 0]
/// - < 1 day         -> hours [+ minutes if minutes != 0]
/// - >= 1 day        -> days [+ hours if hours != 0]
///
/// Takes [Localization] directly rather than a `BuildContext` so this stays
/// a pure function: no widget tree dependency, trivially unit-testable, and
/// usable outside of build methods (isolates, background formatting, etc).
/// At call sites, pass `context.l` — e.g. `formatCompactDuration(context.l, seconds)`.
String formatCompactDuration(Localization l10n, double totalSeconds) {
  final total = totalSeconds.round();
  final p = breakdownDuration(totalSeconds);

  String unit(String pattern, int value) => pattern.replaceAll('%s', value.toString());

  String twoUnit(String first, String second) =>
      l10n.durationTwoUnit.replaceFirst('%first', first).replaceFirst('%second', second);

  if (total < 60) {
    return unit(l10n.durationSecondsShort, p.seconds);
  } else if (total < 3600) {
    if (p.seconds == 0) return unit(l10n.durationMinutesShort, p.minutes);
    return twoUnit(unit(l10n.durationMinutesShort, p.minutes), unit(l10n.durationSecondsShort, p.seconds));
  } else if (total < 86400) {
    if (p.minutes == 0) return unit(l10n.durationHoursShort, p.hours);
    return twoUnit(unit(l10n.durationHoursShort, p.hours), unit(l10n.durationMinutesShort, p.minutes));
  } else {
    if (p.hours == 0) return unit(l10n.durationDaysShort, p.days);
    return twoUnit(unit(l10n.durationDaysShort, p.days), unit(l10n.durationHoursShort, p.hours));
  }
}
