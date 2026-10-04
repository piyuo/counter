import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

String formatPercent(BuildContext context, double value) {
  final formatter = NumberFormat.decimalPatternDigits(
    locale: Localizations.localeOf(context).toLanguageTag(),
    decimalDigits: 1,
  );

  final text = '${formatter.format(value)}%';
  return text;
}
