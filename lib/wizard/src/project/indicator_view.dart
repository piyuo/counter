import 'package:flutter/cupertino.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class IndicatorView extends StatelessWidget {
  const IndicatorView({
    required this.value,
    required this.maxValue,
    super.key,
  });

  /// The value to be displayed.
  final double value;

  /// The maximum value.
  final double maxValue;

  @override
  Widget build(BuildContext context) {
    // Create animated radial gauge.
    // All arguments changes will be automatically animated.
    return AnimatedRadialGauge(
      /// The animation duration.
      duration: const Duration(seconds: 1),
      radius: 120,
      value: value,
      axis: GaugeAxis(
        /// Provide the [min] and [max] value for the [value] argument.
        min: 0,
        max: maxValue + 1,

        /// Render the gauge as a 180-degree arc.
        degrees: 180,

        /// Set the background color and axis thickness.
        style: const GaugeAxisStyle(
          thickness: 20,
          background: Color(0xFFDFE2EC),
        ),

        /// Define the pointer that will indicate the progress (optional).
        pointer: GaugePointer.needle(
          width: 14,
          height: 100,
          borderRadius: 24,
          color: CupertinoColors.activeBlue,
        ),

        /// Define the progress bar (optional).
        progressBar: const GaugeProgressBar.rounded(
          color: CupertinoColors.activeGreen,
        ),
      ),

      builder: (context, child, value) => RadialGaugeLabel(
        value: value,
        style: const TextStyle(
          color: CupertinoColors.activeOrange,
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
