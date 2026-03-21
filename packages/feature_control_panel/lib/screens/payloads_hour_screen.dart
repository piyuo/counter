// TOC:
// - RecentHourDetailScreen: payload list for one start-hour group routed by slotMs with selection + resend

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/providers/recent_payloads_provider.dart';
import 'package:feature_control_panel/screens/payload_resend_helper.dart';
import 'package:feature_control_panel/widgets/selection_checkbox.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:liquid_glass_widgets/widgets/feedback/glass_progress_indicator.dart';

class PayloadsHourScreen extends ConsumerStatefulWidget {
  const PayloadsHourScreen({required this.slotMs, super.key});

  final int slotMs;

  @override
  ConsumerState<PayloadsHourScreen> createState() => _RecentPayloadsHourScreenState();
}

class _RecentPayloadsHourScreenState extends ConsumerState<PayloadsHourScreen> {
  final Set<String> _selectedPayloadIds = <String>{};
  bool _isResending = false;

  String _payloadDeliveryStatusDescription(core_domain.QueuedPayload payload, DateFormat timeFmt) {
    if (payload.isUploaded) {
      return 'Delivered on ${timeFmt.format(payload.uploadedAtUtc!.toLocal())}';
    }
    final nowUtc = DateTime.now().toUtc();
    if (payload.payload.endUtc.isAfter(nowUtc)) {
      return 'Pending to ${timeFmt.format(payload.payload.endUtc.toLocal())}';
    }
    return 'Failed on ${timeFmt.format(payload.payload.endUtc.toLocal())}';
  }

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

  int _selectionCount(List<core_domain.QueuedPayload> payloads) {
    return payloads.where((pending) => _isPayloadSelected(pending.id)).length;
  }

  Future<void> _resendSelectedPayloads(List<core_domain.QueuedPayload> payloads) async {
    final selectedPayloads = payloads.where((pending) => _isPayloadSelected(pending.id)).toList(growable: false);

    setState(() {
      _isResending = true;
    });

    try {
      final resent = await resendQueuedPayloads(
        context: context,
        ref: ref,
        payloads: selectedPayloads,
        emptySelectionMessage: 'Select at least one payload first.',
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
    final payloadsAsync = ref.watch(recentPayloadsProvider);
    final locale = Localizations.localeOf(context).toString();
    final dayFmt = DateFormat.yMMMMd(locale);
    final hourFmt = DateFormat.jm(locale);
    final payloadTimeFmt = hourFmt;

    return feature_pip.PipScaffold(
      action: feature_pip.PipActionButton(
        label: 'Resend',
        onPressed: (_isResending || _selectedPayloadIds.isEmpty)
            ? null
            : () async {
                final payloads = await ref.read(recentPayloadsProvider.future);
                final group = core_domain.findStartHourGroupBySlotMs(payloads, widget.slotMs);
                if (!context.mounted) return;
                if (group == null) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('This start hour no longer exists.')));
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
            child: Text('Failed to load payloads: $error', textAlign: TextAlign.center),
          ),
        ),
        data: (payloads) {
          final group = core_domain.findStartHourGroupBySlotMs(payloads, widget.slotMs);
          if (group == null) {
            return const Center(child: Text('This start hour no longer exists.'));
          }
          final selectedCount = _selectionCount(group.payloads);

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
                            '${payloadTimeFmt.format(group.payloads[i].payload.endUtc.toLocal())}',
                          ),
                          subtitle: Text(_payloadDeliveryStatusDescription(group.payloads[i], payloadTimeFmt)),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            ref.push(core_domain.OpenPayloadDetail(payloadId: group.payloads[i].id));
                          },
                        ),
                        if (i < group.payloads.length - 1) const Divider(height: 1),
                      ],
                      const SizedBox(height: 12),
                      Text('Selected $selectedCount payload(s)', style: Theme.of(context).textTheme.bodySmall),
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
