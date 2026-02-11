import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

List<Color> gradientColors = [CupertinoColors.lightBackgroundGray, CupertinoColors.activeOrange];

class GaugeView extends StatelessWidget {
  const GaugeView({required this.chartColor, required this.classId, required this.now, super.key});

  /// The color to be displayed.
  final Color chartColor;

  /// The class id to be displayed.
  final int classId;

  /// The current time to get the current sample.
  final DateTime now;

  /// Build the chart data.
  LineChartData? buildChartData(BuildContext context, Color color) {
    //final filteredActivities = mockDataForPast1Hour(now);
  }

  @override
  Widget build(BuildContext context) {
    final chartData = buildChartData(context, chartColor);
    return Column(
      children: [
        chartData != null
            ? Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 25, 0),
                child: SizedBox(height: 120, child: LineChart(chartData)),
              )
            : SizedBox.shrink(),
      ],
    );
  }
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
