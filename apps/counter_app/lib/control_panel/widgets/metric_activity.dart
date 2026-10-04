import 'package:flutter/material.dart';
import 'package:shared_l10n/shared_l10n.dart';

import 'info_dialog.dart';

class ActivityMetricData {
  const ActivityMetricData({required this.passBy, required this.stayed, required this.entered, required this.exited});

  final String passBy;
  final String stayed;
  final String entered;
  final String exited;
}

class DetailMetricData {
  const DetailMetricData({required this.appeared, required this.disappeared});

  final String appeared;
  final String disappeared;
}

class MetricEvents extends StatelessWidget {
  const MetricEvents({super.key, required this.title, required this.data, required this.valueColor});

  final String title;
  final ActivityMetricData data;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _MetricItem(value: data.passBy, label: context.l.passed_by, valueColor: valueColor),
            ),
            Expanded(
              child: _MetricItem(value: data.stayed, label: context.l.stayed, valueColor: valueColor),
            ),
            Expanded(
              child: _MetricItem(value: data.entered, label: context.l.entered, valueColor: valueColor),
            ),
            Expanded(
              child: _MetricItem(value: data.exited, label: context.l.exited, valueColor: valueColor),
            ),
          ],
        ),
      ],
    );
  }
}

class MetricDetailActivity extends StatelessWidget {
  const MetricDetailActivity({super.key, required this.data, required this.valueColor});

  final DetailMetricData data;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _MetricItem(
                value: data.appeared,
                label: context.l.appeared,
                valueColor: valueColor,
                compact: true,
              ),
            ),
            Expanded(
              child: _MetricItem(
                value: data.disappeared,
                label: context.l.disappeared,
                valueColor: valueColor,
                compact: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MetricItem extends StatelessWidget {
  const _MetricItem({required this.value, required this.label, required this.valueColor, this.compact = false});

  final String value;
  final String label;
  final Color valueColor;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    Map<String, String> infoContent = {
      context.l.passed_by: context.l.passed_by_help,
      context.l.stayed: context.l.stayed_help,
      context.l.entered: context.l.entered_help,
      context.l.exited: context.l.exited_help,
      context.l.appeared: context.l.appeared_help,
      context.l.disappeared: context.l.disappeared_help,
    };

    void showInfo() {
      final content = infoContent[label];
      if (content == null) return;
      showInfoDialog(context: context, title: label, content: content);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => showInfo(),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: valueColor,
                decoration: TextDecoration.none,
                height: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: GestureDetector(
              onTap: () => showInfo(),
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: Colors.blueGrey.shade800, decoration: TextDecoration.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
