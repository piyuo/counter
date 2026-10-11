// TOC:
// - RecentHourDetailScreen: payload list for one business hour with selection + resend

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/control_panel/widgets/payloads_screen_helper.dart';
import 'package:counter_app/control_panel/widgets/selection_checkbox.dart';
import 'package:counter_app/providers/recent_payloads_provider.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:liquid_glass_widgets/widgets/feedback/glass_progress_indicator.dart';
import 'package:shared_l10n/shared_l10n.dart';

class PayloadsHourScreen extends ConsumerStatefulWidget {
  const PayloadsHourScreen({required this.year, required this.month, required this.day, required this.hour, super.key});

  final int year;
  final int month;
  final int day;
  final int hour;

  @override
  ConsumerState<PayloadsHourScreen> createState() => _RecentPayloadsHourScreenState();
}

class _RecentPayloadsHourScreenState extends ConsumerState<PayloadsHourScreen> {
  final Set<int> _selectedObservationIds = <int>{};
  bool _isResending = false;

  bool _isObservationSelected(int observationId) => _selectedObservationIds.contains(observationId);

  void _togglePayloadSelection(int observationId, bool selected) {
    setState(() {
      if (selected) {
        _selectedObservationIds.add(observationId);
      } else {
        _selectedObservationIds.remove(observationId);
      }
    });
  }

  Future<void> _resendSelectedObservations(List<core_domain.QueuedObservation> observations) async {
    final selectedObservations = observations
        .where((pending) => _isObservationSelected(pending.observation.id))
        .toList(growable: false);

    setState(() {
      _isResending = true;
    });

    try {
      final resent = await resendQueuedObservations(
        context: context,
        telemetryService: ref.read(core_domain.telemetryServiceProvider),
        observations: selectedObservations,
        emptySelectionMessage: context.l.payloads_screen_select_first,
      );
      if (!mounted || !resent) return;

      setState(() {
        _selectedObservationIds.clear();
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
    final locale = Localizations.localeOf(context).toString();
    final dayFmt = DateFormat.yMMMMd(locale);
    final hourFmt = DateFormat.jm(locale);
    final payloadTimeFmt = hourFmt;

    return feature_pip.PipScaffold(
      action: appState.isLocalDeviceOnly
          ? null
          : feature_pip.PipActionButton(
              label: context.l.payloads_screen_resend,
              onPressed: (_isResending || _selectedObservationIds.isEmpty)
                  ? null
                  : () async {
                      final payloads = await ref.read(recentPayloadsProvider.future);
                      final group = core_domain.findStartHourGroup(
                        payloads,
                        year: widget.year,
                        month: widget.month,
                        day: widget.day,
                        hour: widget.hour,
                      );
                      if (!context.mounted) return;
                      if (group == null) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(context.l.payloads_screen_hour_not_exists)));
                        return;
                      }
                      await _resendSelectedObservations(group.payloads);
                    },
            ),
      builder: (scrollController) => payloadsAsync.when(
        loading: () => const Center(child: GlassProgressIndicator.circular(strokeWidth: 2.5, color: Colors.white)),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('${context.l.payloads_screen_failed_load} $error', textAlign: TextAlign.center),
          ),
        ),
        data: (payloads) {
          final group = core_domain.findStartHourGroup(
            payloads,
            year: widget.year,
            month: widget.month,
            day: widget.day,
            hour: widget.hour,
          );
          if (group == null) {
            return Center(child: Text(context.l.payloads_screen_hour_not_exists));
          }

          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
            child: Column(
              children: [
                feature_pip.PipHeader(
                  icon: Icons.bar_chart,
                  title: dayFmt.format(DateTime(group.year, group.month, group.day)),
                  subtitle: hourFmt.format(DateTime(group.year, group.month, group.day, group.hour)),
                ),
                feature_pip.PipPanel(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      for (var i = 0; i < group.payloads.length; i++) ...[
                        ListTile(
                          leading: SelectionCheckbox(
                            value: _isObservationSelected(group.payloads[i].observation.id),
                            onChanged: (value) =>
                                _togglePayloadSelection(group.payloads[i].observation.id, value == true),
                          ),
                          title: Text(formatObservationWindow(group.payloads[i].observation, payloadTimeFmt)),
                          subtitle: Text(payloadDeliveryStatusDescription(context, group.payloads[i], payloadTimeFmt)),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            ref.push(
                              core_domain.OpenPayloadDetail(payloadId: group.payloads[i].observation.id.toString()),
                            );
                          },
                        ),
                        if (i < group.payloads.length - 1) const Divider(height: 1),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
