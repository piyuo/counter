import 'package:flutter/material.dart';
import 'package:shared_l10n/shared_l10n.dart';

import 'info_dialog.dart';

class HeroMetricData {
  const HeroMetricData({required this.value, required this.label, this.valueColor = const Color(0xFF303030)});

  final String value;
  final String label;
  final Color valueColor;
}

class MetricHero extends StatelessWidget {
  const MetricHero({super.key, required this.data});

  final HeroMetricData data;

  static const _valueStyle = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    height: 1.0,
    decoration: TextDecoration.none,
  );

  static const _labelStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFF455A64),
    decoration: TextDecoration.none,
  );

  static const _captionStyle = TextStyle(fontSize: 12, color: Colors.black26, decoration: TextDecoration.none);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.visibility, size: 16, color: Colors.green),
            SizedBox(width: 6),
            Text(context.l.metric_live, style: _captionStyle),
          ],
        ),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: GestureDetector(
            onTap: () => _showInfoDialog(context),
            child: Text(data.value, style: _valueStyle.copyWith(color: data.valueColor)),
          ),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () => _showInfoDialog(context),
          child: Text(data.label, textAlign: TextAlign.center, style: _labelStyle),
        ),
      ],
    );
  }

  void _showInfoDialog(BuildContext context) {
    showInfoDialog(context: context, title: context.l.current_occupancy, content: context.l.current_occupancy_help);
  }
}
