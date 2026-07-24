// TOC:
// - RecentHourDetailScreen: payload list for one start-hour group routed by slotMs with selection + resend

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/providers/recent_payloads_provider.dart';
import 'package:feature_control_panel/widgets/payloads_screen_helper.dart';
import 'package:feature_control_panel/widgets/selection_checkbox.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:liquid_glass_widgets/widgets/feedback/glass_progress_indicator.dart';
import 'package:shared_l10n/shared_l10n.dart';

class PayloadsHourScreen extends ConsumerStatefulWidget {
  const PayloadsHourScreen({required this.slotMs, super.key});

  final int slotMs;

  @override
  ConsumerState<PayloadsHourScreen> createState() => _RecentPayloadsHourScreenState();
}

class _RecentPayloadsHourScreenState extends ConsumerState<PayloadsHourScreen> {
  final Set<String> _selectedPayloadIds = <String>{};
  bool _isResending = false;

  bool _isPayloadSelected(String payloadId) => _selectedPayloadIds.contains(payloadId);

  void _togglePayloadSelection(String payloadId, bool selected) {
    setState(() {
      if (selected) {
        _selectedPayloadIds.add(payloadId);
      } else {
        _selectedPayloadIds.remove(payloadId);
      }
    });
  }

  Future<void> _resendSelectedPayloads(List<core_domain.QueuedPayload> payloads) async {
    final selectedPayloads = payloads.where((pending) => _isPayloadSelected(pending.id)).toList(growable: false);

    setState(() {
      _isResending = true;
    });

    try {
      final resent = await resendQueuedPayloads(
        context: context,
        telemetryService: ref.read(core_domain.telemetryServiceProvider),
        payloads: selectedPayloads,
        emptySelectionMessage: context.l.payloads_screen_select_first,
      );
      if (!mounted || !resent) return;

      setState(() {
        _selectedPayloadIds.clear();
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
              onPressed: (_isResending || _selectedPayloadIds.isEmpty)
                  ? null
                  : () async {
                      final payloads = await ref.read(recentPayloadsProvider.future);
                      final group = core_domain.findStartHourGroupBySlotMs(payloads, widget.slotMs);
                      if (!context.mounted) return;
                      if (group == null) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(context.l.payloads_screen_hour_not_exists)));
                        return;
                      }
                      await _resendSelectedPayloads(group.payloads);
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
          final group = core_domain.findStartHourGroupBySlotMs(payloads, widget.slotMs);
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
                  title: dayFmt.format(group.startHourLocal),
                  subtitle: hourFmt.format(group.startHourLocal),
                ),
                feature_pip.PipPanel(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      for (var i = 0; i < group.payloads.length; i++) ...[
                        ListTile(
                          leading: SelectionCheckbox(
                            value: _isPayloadSelected(group.payloads[i].id),
                            onChanged: (value) => _togglePayloadSelection(group.payloads[i].id, value == true),
                          ),
                          title: Text(
                            '${payloadTimeFmt.format(group.payloads[i].payload.startUtc.toLocal())} - '
                            '${payloadTimeFmt.format(core_domain.getPayloadEndUtc(group.payloads[i].payload).toLocal())}',
                          ),
                          subtitle: Text(payloadDeliveryStatusDescription(context, group.payloads[i], payloadTimeFmt)),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            ref.push(core_domain.OpenPayloadDetail(payloadId: group.payloads[i].id));
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
