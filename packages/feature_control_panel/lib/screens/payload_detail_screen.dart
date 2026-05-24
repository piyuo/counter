// TOC:
// - RecentPayloadDetailScreen: per-payload analytics cards routed by payloadId

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/providers/recent_payloads_provider.dart';
import 'package:feature_control_panel/screens/payload_resend_helper.dart';
import 'package:feature_control_panel/widgets/area_metrics_panel_layouts.dart';
import 'package:feature_control_panel/widgets/area_metrics_panels.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:liquid_glass_widgets/widgets/feedback/glass_progress_indicator.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';

class PayloadDetailScreen extends ConsumerStatefulWidget {
  const PayloadDetailScreen({required this.payloadId, super.key});

  final String payloadId;

  @override
  ConsumerState<PayloadDetailScreen> createState() => _PayloadDetailScreenState();
}

class _PayloadDetailScreenState extends ConsumerState<PayloadDetailScreen> {
  bool _isResending = false;

  String _payloadDeliveryStatusDescription(core_domain.QueuedPayload queued, DateFormat timeFmt) {
    if (queued.isUploaded) {
      return 'Delivered on ${timeFmt.format(queued.uploadedAtUtc!.toLocal())}';
    }
    final nowUtc = DateTime.now().toUtc();
    final payloadEndUtc = core_domain.getPayloadEndUtc(queued.payload);
    if (payloadEndUtc.isAfter(nowUtc)) {
      return 'Pending to ${timeFmt.format(payloadEndUtc.toLocal())}';
    }
    return 'Failed on ${timeFmt.format(payloadEndUtc.toLocal())}';
  }

  @override
  Widget build(BuildContext context) {
    final payloadsAsync = ref.watch(recentPayloadsProvider);
    final appState = ref.watch(core_domain.appProvider).asData?.value;
    if (appState == null) {
      return const SizedBox.shrink();
    }

    return feature_pip.PipScaffold(
      action: appState.isLocalDeviceOnly
          ? null
          : feature_pip.PipActionButton(
              label: 'Resend',
              onPressed: _isResending
                  ? null
                  : () async {
                      setState(() {
                        _isResending = true;
                      });

                      try {
                        final payloads = await ref.read(recentPayloadsProvider.future);
                        if (!context.mounted) return;

                        final pendingPayload = core_domain.findPendingPayloadById(payloads, widget.payloadId);
                        if (pendingPayload == null) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(const SnackBar(content: Text('This payload no longer exists.')));
                          return;
                        }

                        await resendQueuedPayloads(context: context, ref: ref, payloads: [pendingPayload]);
                      } finally {
                        if (mounted) {
                          setState(() {
                            _isResending = false;
                          });
                        }
                      }
                    },
            ),
      builder: (scrollController) => payloadsAsync.when(
        loading: () => const Center(child: GlassProgressIndicator.circular(strokeWidth: 2.5, color: Colors.white)),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Failed to load payload detail: $error', textAlign: TextAlign.center),
          ),
        ),
        data: (payloads) {
          final pendingPayload = core_domain.findPendingPayloadById(payloads, widget.payloadId);
          if (pendingPayload == null) {
            return const Center(child: Text('This payload no longer exists.'));
          }

          final payload = pendingPayload.payload;
          final start = payload.startUtc.toLocal();
          final locale = Localizations.localeOf(context).toString();
          final dayFmt = DateFormat.yMMMMd(locale);
          final hourFmt = DateFormat.jm(locale);
          final donePercent = (payload.coverage * 100.0).clamp(0.0, 100.0);
          final missingPercent = (100.0 - donePercent).clamp(0.0, 100.0);

          final progressSegments = [
            Segment(
              value: donePercent.round().clamp(0, 100),
              color: Colors.lightBlue,
              label: const Text('Done', style: TextStyle(fontSize: 10)),
              valueLabel: Text('${donePercent.toStringAsFixed(1)}%', style: const TextStyle(fontSize: 10)),
            ),
            Segment(
              value: missingPercent.round().clamp(0, 100),
              color: Colors.orange.withValues(alpha: 0.6),
              label: const Text('Missing', style: TextStyle(fontSize: 10)),
              valueLabel: Text('${missingPercent.toStringAsFixed(1)}%', style: const TextStyle(fontSize: 10)),
            ),
          ];

          final areaPanels = buildPayloadAreaMetricPanels(areas: payload.areas);

          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                feature_pip.PipHeader(
                  icon: Icons.bar_chart,
                  title: '${dayFmt.format(start)} ${hourFmt.format(start)}',
                  subtitle: _payloadDeliveryStatusDescription(pendingPayload, hourFmt),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${payload.session}  #${payload.sequence}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      PrimerProgressBar(
                        segments: progressSegments,
                        maxTotalValue: 100,
                        barStyle: const SegmentedBarStyle(padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4)),
                        legendStyle: const SegmentedBarLegendStyle(
                          spacing: 0,
                          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                        ),
                      ),
                    ],
                  ),
                ),
                AreaMetricsPanels(panels: areaPanels, backgroundColor: Colors.grey.shade100),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
