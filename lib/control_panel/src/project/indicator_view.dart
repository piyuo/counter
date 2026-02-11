import 'package:flutter/cupertino.dart';

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
    return Text(value.toStringAsFixed(0), // show value as integer
        style: const TextStyle(
          fontSize: 72,
          height: 0.6,
          fontWeight: FontWeight.bold,
          color: CupertinoColors.activeGreen,
        ));
  }
}
