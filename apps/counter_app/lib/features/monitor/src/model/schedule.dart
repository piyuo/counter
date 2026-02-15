import 'package:flutter/material.dart';

/// Represents a project schedule.
class Schedule {
  Schedule();

  /// List of schedule periods.
  final List<SchedulePeriod> schedulePeriods = [];
}

/// Represents a schedule period.
class SchedulePeriod {
  SchedulePeriod({
    required this.label,
    required this.startTime,
    required this.endTime,
  });

  /// Label for the schedule period.
  String label;

  /// Start time for the schedule period.
  TimeOfDay startTime;

  /// End time for the schedule period.
  TimeOfDay endTime;

  /// Duration of the schedule period.
  Duration get duration => endTime.durationFrom(startTime);

  /// Format the schedule period as a string.
  String formatString(BuildContext context) {
    return '${startTime.format(context)} - ${endTime.format(context)}';
  }

  /// Format the start time as a string.
  String formatStartTime(BuildContext context) {
    return startTime.format(context);
  }

  /// Format the end time as a string.
  String formatEndTime(BuildContext context) {
    return endTime.format(context);
  }
}

/// Extension methods for TimeOfDay.
extension TimeOfDayExtension on TimeOfDay {
  String format() {
    final hours = hour.toString().padLeft(2, '0');
    final minutes = minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  Duration durationFrom(TimeOfDay other) {
    final startInMinutes = other.hour * 60 + other.minute;
    final endInMinutes = hour * 60 + minute;
    return Duration(minutes: endInMinutes - startInMinutes);
  }
}
