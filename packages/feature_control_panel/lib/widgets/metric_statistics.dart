import 'package:feature_control_panel/utils/format_compact_duration.dart';
import 'package:flutter/material.dart';
import 'package:shared_l10n/shared_l10n.dart';

import 'info_dialog.dart';

class SummaryMetricData {
  const SummaryMetricData({
    required this.avgOccupancy,
    required this.maxOccupancy,
    required this.avgDwell,
    required this.maxDwell,
  });

  final String avgOccupancy;
  final String maxOccupancy;
  final double avgDwell;
  final double maxDwell;
}

class MetricStatistics extends StatelessWidget {
  const MetricStatistics({super.key, required this.data, required this.valueColor});

  final SummaryMetricData data;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 2, 16, 0),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueGrey.withValues(alpha: .15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              context.l.metric_statistics,
              style: TextStyle(fontSize: 12, color: Colors.black26, decoration: TextDecoration.none),
            ),
          ),

          _SummaryRow(label: context.l.average_occupancy, value: data.avgOccupancy, valueColor: valueColor),
          _SummaryRow(label: context.l.maximum_occupancy, value: data.maxOccupancy, valueColor: valueColor),
          const Divider(height: 12, color: Colors.black26, thickness: 0.5),
          _SummaryRow(
            label: context.l.average_stay,
            value: formatCompactDuration(context.l, data.avgDwell),
            valueColor: valueColor,
          ),
          _SummaryRow(
            label: context.l.maximum_stay,
            value: formatCompactDuration(context.l, data.maxDwell),
            valueColor: valueColor,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value, required this.valueColor});

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    Map<String, String> infoContent = {
      context.l.average_occupancy: context.l.average_occupancy_help,
      context.l.maximum_occupancy: context.l.maximum_occupancy_help,
      context.l.average_stay: context.l.average_stay_help,
      context.l.maximum_stay: context.l.maximum_stay_help,
    };

    void showInfo(BuildContext context) {
      final content = infoContent[label];
      if (content == null) return;

      showInfoDialog(context: context, title: label, content: content);
    }

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => showInfo(context),
            child: Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.blueGrey.shade700, decoration: TextDecoration.none),
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valueColor,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}
