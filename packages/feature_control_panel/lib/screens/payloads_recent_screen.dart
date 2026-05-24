// TOC:
// - RecentScreen: grouped telemetry payload history by date -> hour with selection + resend

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/providers/recent_payloads_provider.dart';
import 'package:feature_control_panel/screens/payload_resend_helper.dart';
import 'package:feature_control_panel/widgets/selection_checkbox.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class PayloadsRecentScreen extends ConsumerStatefulWidget {
  const PayloadsRecentScreen({super.key});

  @override
  ConsumerState<PayloadsRecentScreen> createState() => _RecentScreenState();
}

class _RecentScreenState extends ConsumerState<PayloadsRecentScreen> {
  final Set<DateTime> _selectedDays = <DateTime>{};
  final Set<DateTime> _selectedHours = <DateTime>{};
  bool _isResending = false;

  Widget _buildDayCheckbox(core_domain.DeliveryDateGroup dateGroup) {
    return SelectionCheckbox(
      value: _dayCheckboxValue(dateGroup),
      tristate: true,
      onChanged: (value) => _toggleDaySelection(dateGroup, value == true),
    );
  }

  Widget _buildHourCheckbox(core_domain.DeliveryHourGroup hourGroup) {
    return SelectionCheckbox(
      value: _isHourSelected(hourGroup.startHourLocal),
      onChanged: (value) => _toggleHourSelection(hourGroup, value == true),
    );
  }

  bool _isDaySelected(DateTime dayLocal) => _selectedDays.contains(core_domain.dayStartLocal(dayLocal));

  bool _isHourSelected(DateTime hourLocal) => _selectedHours.contains(hourLocal);

  bool? _dayCheckboxValue(core_domain.DeliveryDateGroup dateGroup) {
    final daySelected = _isDaySelected(dateGroup.dayLocal);
    if (daySelected) return true;
    final anyHourSelected = dateGroup.hours.any((h) => _isHourSelected(h.startHourLocal));
    return anyHourSelected ? null : false;
  }

  void _toggleDaySelection(core_domain.DeliveryDateGroup dateGroup, bool selected) {
    setState(() {
      final dayKey = core_domain.dayStartLocal(dateGroup.dayLocal);
      if (selected) {
        _selectedDays.add(dayKey);
      } else {
        _selectedDays.remove(dayKey);
      }
    });
  }

  void _toggleHourSelection(core_domain.DeliveryHourGroup hourGroup, bool selected) {
    setState(() {
      if (selected) {
        _selectedHours.add(hourGroup.startHourLocal);
      } else {
        _selectedHours.remove(hourGroup.startHourLocal);
      }
    });
  }

  int _selectionCount(List<core_domain.DeliveryDateGroup> dateGroups) {
    var count = 0;
    for (final day in dateGroups) {
      if (_isDaySelected(day.dayLocal)) {
        count += day.hours.length;
        continue;
      }
      count += day.hours.where((h) => _isHourSelected(h.startHourLocal)).length;
    }
    return count;
  }

  String _hourDeliveryStatusDescription(core_domain.DeliveryHourGroup hourGroup) {
    final deliveredCount = hourGroup.deliveredCount;
    final totalCount = hourGroup.totalCount;

    switch (hourGroup.deliveryStatus) {
      case core_domain.DeliveryStatus.allDelivered:
        return 'Delivered ($deliveredCount/$totalCount)';
      case core_domain.DeliveryStatus.partiallyDelivered:
        return 'Partially delivered ($deliveredCount/$totalCount)';
      case core_domain.DeliveryStatus.noneDelivered:
        return 'Pending delivery (0/$totalCount)';
    }
  }

  String _dayDeliveryStatusDescription(core_domain.DeliveryDateGroup dateGroup) {
    final deliveredCount = dateGroup.deliveredCount;
    final totalCount = dateGroup.totalCount;

    switch (dateGroup.deliveryStatus) {
      case core_domain.DeliveryStatus.allDelivered:
        return 'Delivered ($deliveredCount/$totalCount)';
      case core_domain.DeliveryStatus.partiallyDelivered:
        return 'Partially delivered ($deliveredCount/$totalCount)';
      case core_domain.DeliveryStatus.noneDelivered:
        return 'Pending delivery (0/$totalCount)';
    }
  }

  Future<void> _resendSelection(List<core_domain.DeliveryDateGroup> dateGroups) async {
    final selectedPayloads = core_domain.collectSelectedPayloads(
      dateGroups,
      isDaySelected: _isDaySelected,
      isHourSelected: _isHourSelected,
    );

    setState(() {
      _isResending = true;
    });

    try {
      final resent = await resendQueuedPayloads(
        context: context,
        ref: ref,
        payloads: selectedPayloads,
        emptySelectionMessage: 'Select at least one date or hour first.',
      );
      if (!mounted || !resent) return;

      setState(() {
        _selectedDays.clear();
        _selectedHours.clear();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isResending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(core_domain.appProvider).asData?.value;
    if (appState == null) {
      return const SizedBox.shrink();
    }
    final payloadsAsync = ref.watch(recentPayloadsProvider);
    final dateGroups = payloadsAsync.maybeWhen(
      data: core_domain.groupByDeliveryDate,
      orElse: () => const <core_domain.DeliveryDateGroup>[],
    );
    final locale = Localizations.localeOf(context).toString();
    final dayFmt = DateFormat.yMMMMd(locale);
    final hourFmt = DateFormat.jm(locale);
    final selectedGroupCount = _selectionCount(dateGroups);

    return feature_pip.PipScaffold(
      action: appState.isLocalDeviceOnly
          ? null
          : feature_pip.PipActionButton(
              label: 'Resend',
              onPressed: (_isResending || dateGroups.isEmpty || selectedGroupCount == 0)
                  ? null
                  : () => _resendSelection(dateGroups),
            ),
      builder: (scrollController) => payloadsAsync.when(
        loading: () => const Center(child: GlassProgressIndicator.circular(strokeWidth: 2.5, color: Colors.white)),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Failed to load recent payloads: $error', textAlign: TextAlign.center),
          ),
        ),
        data: (payloads) {
          final dateGroups = core_domain.groupByDeliveryDate(payloads);
          if (dateGroups.isEmpty) {
            return const Center(child: Text('No payloads yet.'));
          }

          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
            child: Column(
              children: [
                feature_pip.PipHeader(
                  icon: Icons.bar_chart,
                  title: 'Recent Payloads',
                  subtitle: 'Select by date or hour to resend',
                ),
                for (var i = 0; i < dateGroups.length; i++) ...[
                  feature_pip.PipPanel(
                    child: ExpansionTile(
                      iconColor: Colors.white70,
                      collapsedIconColor: Colors.white70,
                      maintainState: true,
                      initiallyExpanded: i == 0,
                      leading: _buildDayCheckbox(dateGroups[i]),
                      title: Text(dayFmt.format(dateGroups[i].dayLocal)),
                      subtitle: Text(_dayDeliveryStatusDescription(dateGroups[i])),
                      children: [
                        for (final hourGroup in dateGroups[i].hours)
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 42, right: 16),
                            leading: _buildHourCheckbox(hourGroup),
                            title: Text(hourFmt.format(hourGroup.startHourLocal)),
                            subtitle: Text(_hourDeliveryStatusDescription(hourGroup)),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              ref.push(
                                core_domain.OpenPayloadsHour(slotMs: hourGroup.startHourLocal.millisecondsSinceEpoch),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
