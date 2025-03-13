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
    return SizedBox(
      width: 240,
      height: 70,
      child: AnimatedRadialGauge(
        duration: const Duration(milliseconds: 200),
        value: value + 4, // avoid 0 show strange black color
        axis: GaugeAxis(
          min: 0,
          max: maxValue + 5,
          // 4 for start value plus 4, 1 form max value padding. cause value equal to max value to show strange color
          degrees: 165,
          style: const GaugeAxisStyle(
            thickness: 18,
            background: Color(0xFFDFE2EC),
          ),
          pointer: GaugePointer.needle(
            width: 14,
            height: 50,
            color: CupertinoColors.activeBlue.withValues(alpha: 0.7),
          ),
          progressBar: const GaugeProgressBar.rounded(
            color: CupertinoColors.activeGreen,
          ),
        ),
        builder: (context, child, _) => RadialGaugeLabel(
          value: value,
          style: const TextStyle(
            color: CupertinoColors.activeOrange,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
