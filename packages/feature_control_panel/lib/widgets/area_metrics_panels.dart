// TOC:
//  - AreaMetricsPanels: shared renderer for global + per-area metric cards
//  - AreaMetricsPanelModel / AreaMetricGridModel / AreaMetricCell: view models for panel composition

import 'package:flutter/material.dart';

class AreaMetricsPanelModel {
  const AreaMetricsPanelModel({required this.grids, this.title, this.valueColor = Colors.lightBlue});

  final String? title;
  final Color valueColor;
  final List<AreaMetricGridModel> grids;
}

class AreaMetricGridModel {
  const AreaMetricGridModel({
    required this.cells,
    required this.crossAxisCount,
    required this.mainAxisExtent,
    this.showTopDivider = false,
  });

  final List<AreaMetricCell> cells;
  final int crossAxisCount;
  final double mainAxisExtent;
  final bool showTopDivider;
}

class AreaMetricCell {
  const AreaMetricCell({
    required this.value,
    required this.label,
    this.valueColor,
    this.valueSuffix,
    this.compact = false,
  });

  final String value;
  final String label;
  final Color? valueColor;
  final String? valueSuffix;
  final bool compact;
}

class AreaMetricsPanels extends StatelessWidget {
  const AreaMetricsPanels({required this.panels, required this.backgroundColor, super.key});

  final List<AreaMetricsPanelModel> panels;

  final Color backgroundColor;

  static const _headerStyle = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
  );

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (final panel in panels) {
      if (panel.title != null && panel.title!.isNotEmpty) {
        children.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
            child: Text(panel.title!, style: _headerStyle),
          ),
        );
      }
      children.add(_buildPanel(panel));
    }

    return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: children);
  }

  Widget _buildPanel(AreaMetricsPanelModel panel) {
    final children = <Widget>[];

    for (var i = 0; i < panel.grids.length; i++) {
      final grid = panel.grids[i];

      if (grid.showTopDivider) {
        children.add(const Divider(color: Colors.white24, thickness: 0.6, height: 2));
        children.add(const SizedBox(height: 2));
      }

      children.add(
        _buildMetricGrid(
          grid.cells,
          crossAxisCount: grid.crossAxisCount,
          mainAxisExtent: grid.mainAxisExtent,
          defaultValueColor: panel.valueColor,
        ),
      );

      if (i < panel.grids.length - 1) {
        children.add(const SizedBox(height: 2));
      }
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(12)),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }

  Widget _buildMetricGrid(
    List<AreaMetricCell> cells, {
    required int crossAxisCount,
    required double mainAxisExtent,
    required Color defaultValueColor,
  }) {
    return GridView.count(
      padding: EdgeInsets.zero,
      primary: false,
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      mainAxisExtent: mainAxisExtent,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        for (final cell in cells)
          _MetricUnit(
            value: cell.value,
            label: cell.label,
            valueColor: cell.valueColor ?? defaultValueColor,
            valueSuffix: cell.valueSuffix,
            compact: cell.compact,
          ),
      ],
    );
  }
}

class _MetricUnit extends StatelessWidget {
  const _MetricUnit({
    required this.value,
    required this.label,
    this.valueColor = Colors.lightBlue,
    this.valueSuffix,
    this.compact = false,
  });

  final String value;
  final String label;
  final Color valueColor;
  final String? valueSuffix;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    color: valueColor,
                    fontSize: compact ? 20 : 24,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                if (valueSuffix != null)
                  TextSpan(
                    text: valueSuffix,
                    style: TextStyle(
                      color: valueColor,
                      fontSize: compact ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                    ),
                  ),
              ],
            ),
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.blueGrey.shade900,
            fontSize: compact ? 12 : 12,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}
