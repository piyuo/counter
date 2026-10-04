import 'package:flutter/material.dart';
import 'package:shared_l10n/shared_l10n.dart';

import 'metric_activity.dart';
import 'metric_hero.dart';
import 'metric_statistics.dart';

class MetricCardData {
  const MetricCardData({
    this.title,
    required this.valueColor,
    required this.hero,
    required this.activity,
    required this.details,
    required this.summary,
  });

  final String? title;
  final Color valueColor;

  final HeroMetricData hero;
  final ActivityMetricData activity;
  final DetailMetricData details;
  final SummaryMetricData summary;
}

///
/// Main metrics widget
///
class MetricCards extends StatelessWidget {
  const MetricCards({super.key, required this.panels, required this.backgroundColor});

  final List<MetricCardData> panels;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final panel in panels)
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: _MetricCard(panel: panel, backgroundColor: backgroundColor),
          ),
      ],
    );
  }
}

class _MetricCard extends StatefulWidget {
  const _MetricCard({required this.panel, required this.backgroundColor});

  final MetricCardData panel;
  final Color backgroundColor;

  @override
  State<_MetricCard> createState() => _MetricCardState();
}

class _MetricCardState extends State<_MetricCard> {
  bool _showDetails = false;
  static const _titleStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: widget.backgroundColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.panel.title != null && widget.panel.title!.isNotEmpty) ...[
            Text(widget.panel.title!, style: _titleStyle),
            const SizedBox(height: 12),
          ],
          MetricHero(data: widget.panel.hero),
          const SizedBox(height: 8),
          const Divider(height: 1, color: Colors.black26, thickness: 0.5),
          const SizedBox(height: 2),
          MetricEvents(
            title: context.l.metric_events,
            data: widget.panel.activity,
            valueColor: widget.panel.valueColor,
          ),
          const SizedBox(height: 16),
          if (_showDetails)
            MetricDetailActivity(
              data: widget.panel.details,
              valueColor: widget.panel.valueColor.withValues(alpha: .75),
            ),

          if (_showDetails) const SizedBox(height: 16),

          Center(
            child: GestureDetector(
              onTap: () => setState(() => _showDetails = !_showDetails),
              child: Text(
                _showDetails ? context.l.metric_show_less : context.l.metric_show_more,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: widget.panel.valueColor),
              ),
            ),
          ),

          const SizedBox(height: 10),
          MetricStatistics(data: widget.panel.summary, valueColor: widget.panel.valueColor),
        ],
      ),
    );
  }
}
