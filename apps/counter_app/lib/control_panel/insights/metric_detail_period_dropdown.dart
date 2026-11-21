import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dashboard_formatter.dart';

class MetricDetailPeriodDropdown extends StatelessWidget {
  const MetricDetailPeriodDropdown({
    super.key,
    required this.value,
    required this.customDate,
    required this.onChanged,
  });

  final core_domain.TrafficPeriod value;
  final DateTime customDate;
  final ValueChanged<core_domain.TrafficPeriod> onChanged;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMMMd(
      Localizations.localeOf(context).toString(),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButtonFormField<core_domain.TrafficPeriod>(
        initialValue: value,
        isExpanded: true,
        alignment: Alignment.center,
        style: const TextStyle(color: Colors.white),
        dropdownColor: Colors.blue.shade700,
        iconEnabledColor: Colors.white,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.blue.shade700,
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        items: [
          for (final period in core_domain.TrafficPeriod.values)
            if (period != core_domain.TrafficPeriod.liveToday)
              DropdownMenuItem(
                value: period,
                alignment: Alignment.center,
                child: Text(
                  period == core_domain.TrafficPeriod.customDay
                      ? (value == period
                            ? dateFormat.format(customDate)
                            : MaterialLocalizations.of(
                                context,
                              ).datePickerHelpText)
                      : formatTrafficPeriodLabel(context, period),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
        ],
        onChanged: (period) {
          if (period != null) onChanged(period);
        },
      ),
    );
  }
}
