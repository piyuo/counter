import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../widgets/animated_swipe_pager.dart';
import 'dashboard_card.dart';

class AreaSection extends StatefulWidget {
  const AreaSection({
    required this.areaData,
    required this.comparisonPeriod,
    required this.onComparisonChanged,
    required this.observationStatus,
    super.key,
  });

  final core_domain.DashboardAreaData areaData;
  final core_domain.TrafficComparisonPeriod comparisonPeriod;
  final ValueChanged<core_domain.TrafficComparisonPeriod> onComparisonChanged;
  final core_domain.ObservationStatus observationStatus;

  @override
  State<AreaSection> createState() => _AreaSectionState();
}

class _AreaSectionState extends State<AreaSection> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final areaName = widget.areaData.isGlobal
        ? context.l.insight_dashboard_title
        : (widget.areaData.name?.trim().isNotEmpty ?? false)
        ? widget.areaData.name!.trim()
        : '${context.l.main_screen_interest_areas} ${widget.areaData.name}';
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    areaName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                _PageIndicator(
                  currentPage: _selectedPage,
                  count: widget.areaData.cards.length,
                  onPrevious: () => setState(() => _selectedPage--),
                  onNext: () => setState(() => _selectedPage++),
                ),
              ],
            ),
          ),
          AnimatedSwipePager(
            itemCount: widget.areaData.cards.length,
            initialPage: _selectedPage,
            onPageChanged: (page) => setState(() => _selectedPage = page),
            itemBuilder: (context, index) => DashboardCard(
              data: widget.areaData.cards[index],
              comparisonPeriod: widget.comparisonPeriod,
              onComparisonChanged: widget.onComparisonChanged,
              observationStatus: widget.observationStatus,
            ),
          ),
        ],
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({
    required this.currentPage,
    required this.count,
    required this.onPrevious,
    required this.onNext,
  });

  final int currentPage;
  final int count;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        onPressed: currentPage > 0 ? onPrevious : null,
        tooltip: context.l.onboarding_back_action,
        visualDensity: VisualDensity.compact,
        constraints: const BoxConstraints.tightFor(width: 36, height: 36),
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.chevron_left),
      ),
      Text('${currentPage + 1}/$count', style: Theme.of(context).textTheme.labelSmall),
      IconButton(
        onPressed: currentPage < count - 1 ? onNext : null,
        tooltip: context.l.onboarding_next_action,
        visualDensity: VisualDensity.compact,
        constraints: const BoxConstraints.tightFor(width: 36, height: 36),
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.chevron_right),
      ),
    ],
  );
}
