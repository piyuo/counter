import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:vision/vision.dart' as vision;

List<Color> gradientColors = [
  CupertinoColors.lightBackgroundGray,
  CupertinoColors.activeOrange,
];

class GaugeView extends StatelessWidget {
  const GaugeView({
    required this.chartColor,
    required this.onTapChart,
    required this.classId,
    required this.tallyCounter,
    required this.tallyAnnotation,
    required this.filter,
    required this.now,
    super.key,
  });

  /// The color to be displayed.
  final Color chartColor;

  /// The callback function when the chart is tapped.
  final VoidCallback onTapChart;

  /// The class id to be displayed.
  final int classId;

  /// The counter to be displayed.
  final vision.TallyCounter tallyCounter;

  /// The annotation for display counter.
  final vision.TallyAnnotation tallyAnnotation;

  /// The filter to get sampler count.
  final vision.Filter filter;

  /// The current time to get the current sample.
  final DateTime now;

  /// Build the chart data.
  LineChartData? buildChartData(BuildContext context, Color color) {
    final filteredActivities = tallyCounter.activities; // already filtered by filter when sampling
    //final filteredActivities = mockDataForPast1Hour(now);
    final chartActivities = makeChartActivities(filteredActivities);
    int maxRounded, numberStep;
    (maxRounded, numberStep) = getMaxRoundedAndStep(tallyCounter.maxValue.toDouble());

    DateTime startTime;
    int stepMinutes;
    (startTime, stepMinutes) = getStartTimeAndStep(filter, now);

    final startTimeToMinute = filter.filterType == vision.FilterType.custom
        ? DateTime(now.year, now.month, now.day, filter.start.hour, filter.start.minute)
        : DateTime(startTime.year, startTime.month, startTime.day, startTime.hour, startTime.minute);
    final endTimeToMinute = filter.filterType == vision.FilterType.custom
        ? DateTime(now.year, now.month, now.day, filter.end.hour, filter.end.minute)
        : DateTime(now.year, now.month, now.day, now.hour, now.minute);
    Duration difference = endTimeToMinute.difference(startTimeToMinute);
    int displayedTimeCount = (difference.inMinutes / stepMinutes).toInt();
    final gridLine = FlLine(color: CupertinoColors.opaqueSeparator.resolveFrom(context), strokeWidth: 1);

    List<FlSpot> buildSpots() {
      return chartActivities.map((activity) {
        Duration difference = activity.createdAt.difference(startTimeToMinute);
        return FlSpot(
          difference.inMinutes / stepMinutes,
          tallyCounter.getValue(activity).toDouble(),
        );
      }).toList();
    }

    return LineChartData(
      minX: 0,
      maxX: displayedTimeCount.toDouble(),
      minY: 0,
      maxY: maxRounded.toDouble(),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: numberStep.toDouble(),
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) => gridLine,
        getDrawingVerticalLine: (value) => gridLine,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (double value, TitleMeta meta) {
              DateTime time = startTimeToMinute.add(Duration(minutes: value.toInt() * stepMinutes));
              String formattedTime = DateFormat('HH:mm').format(time);
              return SideTitleWidget(
                meta: meta,
                child: Text(formattedTime,
                    style: TextStyle(
                      fontSize: 12,
                    )),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 38,
            interval: numberStep.toDouble(),
            getTitlesWidget: (double value, TitleMeta meta) {
              return value == 0 || value == maxRounded
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        value.toInt().toString(),
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.right,
                      ),
                    );
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      lineBarsData: [
        LineChartBarData(
          spots: buildSpots(),
          isCurved: false,
          gradient: LinearGradient(
            colors: [color, color],
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [color.withValues(alpha: 0.3), color.withValues(alpha: 0.5)],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final chartData = buildChartData(context, chartColor);
    return Column(children: [
      CupertinoListTile(
        title: Text('${vision.classTitleById(context, classId)} ${tallyAnnotation.title}',
            style: TextStyle(color: chartColor)),
        leading: Icon(vision.classIconById(classId), color: chartColor),
        trailing: const CupertinoListTileChevron(),
        additionalInfo: Text(
          textAlign: TextAlign.end,
          tallyCounter.formattedValue(context),
          style:
              TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: CupertinoColors.label.resolveFrom(context)),
        ),
        onTap: onTapChart,
      ),
      chartData != null
          ? Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 25, 0),
              child: SizedBox(
                height: 120,
                child: LineChart(chartData),
              ),
            )
          : SizedBox.shrink(),
    ]);
  }
}

List<vision.Activity> mockDataForPast1Hour(DateTime now) {
  final rand = Random(); // Instance to generate random numbers in range 0 to 2.
  final startTime = DateTime(now.year, now.month, now.day, now.hour - 1, now.minute);

  return List.generate(60, (index) {
    final createdAt = startTime.add(Duration(minutes: index));
    //print('createdAt: ${createdAt.millisecondsSinceEpoch}');

    return vision.Activity(
      createdAt: createdAt,
      spawned: rand.nextInt(2), // Random value from 0 to 21
      vanished: rand.nextInt(2),
      entered: rand.nextInt(2),
      exited: rand.nextInt(2),
      stagnant: rand.nextInt(2),
      reentered: rand.nextInt(2),
      occupied: rand.nextInt(2),
      stayDuration: rand.nextInt(2) * 10, // multiplied to simulate longer durations
    );
  });
//.reversed.toList()
}

/// Get the maxRounded and step values based on the maximum count
(int, int) getMaxRoundedAndStep(num maxCount) {
  if (maxCount <= 0) return (10, 5); // Default values

  // Determine the nearest power of 10
  int magnitude = pow(10, (log(maxCount) / log(10)).floor()).toInt();
  int maxRounded;

  // Find an appropriate maxRounded value (10, 20, 50, 100, 200, 500, ...)
  if (maxCount <= magnitude * 2) {
    maxRounded = magnitude * 2;
  } else if (maxCount <= magnitude * 5) {
    maxRounded = magnitude * 5;
  } else {
    maxRounded = magnitude * 10;
  }

  // Compute the ideal step, ensure it's at least 5 and a multiple of 5
  int step = max(5, ((maxRounded ~/ 4) / 5).round() * 5);

  return (maxRounded, step);
}

/// Get the start time and step interval based on the filter
(DateTime, int) getStartTimeAndStep(vision.Filter filter, DateTime now) {
  const int kIntervalCount = 5;
  const int kMinStepMinutes = 1;

  if (filter.filterType == vision.FilterType.custom) {
    // Use custom filter's start and end times
    DateTime startTime = DateTime(now.year, now.month, now.day, filter.start.hour, filter.start.minute);

    DateTime endTime = DateTime(now.year, now.month, now.day, filter.end.hour, filter.end.minute);
    assert(startTime.isBefore(endTime), 'End time must be after start time');

    if (!startTime.isBefore(endTime)) {
      throw ArgumentError('End time must be after start time');
    }

    final totalMinutes = endTime.difference(startTime).inMinutes;
    final stepMinutes = max(kMinStepMinutes, totalMinutes ~/ kIntervalCount);
    return (startTime, stepMinutes);
  } else {
    final totalMinutes = switch (filter.filterType) {
      vision.FilterType.pass1Hour => 60,
      vision.FilterType.pass2Hour => 120,
      vision.FilterType.pass4Hour => 240,
      vision.FilterType.pass8Hour => 480,
      vision.FilterType.past12Hour => 720,
      vision.FilterType.past24Hour => 1440,
      vision.FilterType.custom => 0, // never reach here
    };

    final stepMinutes = totalMinutes ~/ kIntervalCount;
    final startTime = now.subtract(Duration(minutes: totalMinutes));
    return (startTime, stepMinutes);
  }
}

/// Safely sample activity data with guaranteed preservation of isolated points
///
/// [activities] List of activities, already sorted by time (newest last) and filtered
/// Returns a sampled list of activities, ensuring no isolated data points are skipped
List<vision.Activity> makeChartActivities(List<vision.Activity> activities) {
  if (activities.isEmpty) return [];

  final targetPoints = 12;

  // Return original list if it's within target size or 1-hour range
  if (activities.length <= targetPoints) {
    return activities;
  }

  // Calculate time-based sampling interval
  final timeSpan = activities.last.createdAt.difference(activities.first.createdAt);
  final minutesPerPoint = timeSpan.inMinutes / targetPoints;

  final result = <vision.Activity>[];
  var lastIncludedTime = activities.first.createdAt;

  // Always include the first point
  result.add(activities.first);

  // Sample middle points based on time interval and isolation
  for (int i = 1; i < activities.length - 1; i++) {
    final activity = activities[i];
    final timeSinceLastIncluded = activity.createdAt.difference(lastIncludedTime).inMinutes;

    // Check if this point is isolated or far enough from last included point
    final isIsolatedPoint = i < activities.length - 1 &&
        activities[i + 1].createdAt.difference(activity.createdAt).inMinutes > minutesPerPoint &&
        timeSinceLastIncluded > minutesPerPoint;

    if (timeSinceLastIncluded >= minutesPerPoint || isIsolatedPoint) {
      result.add(activity);
      lastIncludedTime = activity.createdAt;
    }
  }

  // Always include the last point
  if (result.last != activities.last) {
    result.add(activities.last);
  }

  return result;
}
