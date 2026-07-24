// TOC:
// - PayloadDetailScreen: per-payload analytics screen routed by payloadId
//   Redesigned to use traditional list widgets (ListView/Card/ListTile)
//   instead of custom panel/progress-bar controls, for easier scanning.

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/providers/recent_payloads_provider.dart';
import 'package:feature_control_panel/utils/format_compact_duration.dart';
import 'package:feature_control_panel/utils/format_percent.dart';
import 'package:feature_control_panel/widgets/payloads_screen_helper.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:liquid_glass_widgets/widgets/feedback/glass_progress_indicator.dart';
import 'package:shared_l10n/shared_l10n.dart';

/// Traffic-light color for a coverage/confidence percentage, so a bad
/// window is visible at a glance without reading the number.
Color _percentColor(double percent) {
  if (percent >= 90) return Colors.green.shade600;
  if (percent >= 70) return Colors.orange.shade700;
  return Colors.red.shade600;
}

class PayloadDetailScreen extends ConsumerStatefulWidget {
  const PayloadDetailScreen({required this.payloadId, super.key});

  final String payloadId;

  @override
  ConsumerState<PayloadDetailScreen> createState() => _PayloadDetailScreenState();
}

class _PayloadDetailScreenState extends ConsumerState<PayloadDetailScreen> {
  bool _isResending = false;

  Future<void> _resend(core_domain.QueuedPayload pendingPayload) async {
    setState(() => _isResending = true);
    try {
      await resendQueuedPayloads(
        context: context,
        telemetryService: ref.read(core_domain.telemetryServiceProvider),
        payloads: [pendingPayload],
      );
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final payloadsAsync = ref.watch(recentPayloadsProvider);
    final appState = ref.watch(core_domain.appProvider).asData?.value;
    if (appState == null) return const SizedBox.shrink();

    return feature_pip.PipScaffold(
      action: appState.isLocalDeviceOnly
          ? null
          : feature_pip.PipActionButton(
              label: context.l.payloads_screen_resend,
              onPressed: _isResending
                  ? null
                  : () async {
                      final payloads = await ref.read(recentPayloadsProvider.future);
                      if (!context.mounted) return;
                      final pendingPayload = core_domain.findPendingPayloadById(payloads, widget.payloadId);
                      if (pendingPayload == null) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(context.l.payloads_screen_payload_not_exists)));
                        return;
                      }
                      await _resend(pendingPayload);
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
          final pendingPayload = core_domain.findPendingPayloadById(payloads, widget.payloadId);
          if (pendingPayload == null) {
            return Center(child: Text(context.l.payloads_screen_payload_not_exists));
          }

          final payload = pendingPayload.payload;
          final start = payload.startUtc.toLocal();
          final locale = Localizations.localeOf(context).toString();
          final dayFmt = DateFormat.yMMMMd(locale);
          final hourFmt = DateFormat.jm(locale);
          final coveragePercent = (payload.coverage * 100.0).clamp(0.0, 100.0);

          return ListView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
            children: [
              feature_pip.PipHeader(
                icon: Icons.bar_chart,
                title: '${dayFmt.format(start)} ${hourFmt.format(start)}',
                subtitle: payloadDeliveryStatusDescription(context, pendingPayload, hourFmt),
              ),
              _SectionHeader('${payload.session}  #${payload.sequence}'),
              _SummaryTile(
                label: context.l.payloads_screen_coverage,
                value: formatPercent(context, coveragePercent),
                valueColor: _percentColor(coveragePercent),
                subtitle: payload.isPartial ? context.l.payloads_screen_partial : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: coveragePercent / 100.0,
                    minHeight: 6,
                    backgroundColor: _percentColor(coveragePercent).withValues(alpha: 0.2),
                    color: _percentColor(coveragePercent),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _SummaryTile(label: context.l.payloads_screen_process_fps, value: payload.fps.toStringAsFixed(2)),
              _SummaryTile(
                label: context.l.payloads_screen_confidence,
                value: formatPercent(context, payload.confidence),
                valueColor: _percentColor(payload.confidence),
              ),
              _SummaryTile(label: context.l.payloads_screen_frame_processed, value: '${payload.frameCount}'),
              _SummaryTile(
                label: context.l.payloads_screen_missing_time,
                value: formatCompactDuration(context.l, payload.missingSec.toDouble()),
              ),
              Divider(height: 32, color: Theme.of(context).dividerColor.withValues(alpha: 0.4)),
              for (var i = 0; i < payload.areas.length; i++) ...[
                if (i > 0)
                  Divider(
                    height: 24,
                    indent: 16,
                    endIndent: 16,
                    color: Theme.of(context).dividerColor.withValues(alpha: 0.4),
                  ),
                _AreaListItem(area: payload.areas[i]),
              ],
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}

/// Bold caption used to separate major sections in the list.
class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        text,
        style:
            Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold) ??
            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

/// One label/value row. Label is muted (secondary) so the eye lands on the
/// value; the value uses tabular figures so digits line up vertically
/// across rows regardless of digit count.
class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value, this.icon, this.iconColor});

  final String label;
  final String value;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mutedLabel = theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.6);
    return ListTile(
      leading: icon != null ? Icon(icon, size: 22, color: iconColor ?? theme.colorScheme.primary) : null,
      minLeadingWidth: 0,
      title: Text(label, style: TextStyle(fontSize: 16, color: mutedLabel)),
      trailing: Text(
        value,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, fontFeatures: const [FontFeature.tabularFigures()]),
      ),
    );
  }
}

/// One label/value row for top-level payload stats, with an optional
/// subtitle and value color (used for coverage/confidence warnings).
class _SummaryTile extends StatelessWidget {
  const _SummaryTile({required this.label, required this.value, this.subtitle, this.valueColor});

  final String label;
  final String value;
  final String? subtitle;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mutedLabel = theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.6);
    return ListTile(
      title: Text(label, style: TextStyle(fontSize: 16, color: mutedLabel)),
      subtitle: subtitle != null
          ? Text(subtitle!, style: TextStyle(fontSize: 13, color: Colors.orange.shade700))
          : null,
      trailing: Text(
        value,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: valueColor,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}

/// Renders one [AreaPayload] as a plain, transparent list section: a bold
/// "Area N" caption followed by its metrics, grouped under small uppercase
/// captions (Traffic / Presence / Occupancy / Dwell time) so related
/// numbers are visually clustered instead of one long flat list.
class _AreaListItem extends StatelessWidget {
  const _AreaListItem({required this.area});

  final core_domain.AreaPayload area;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader('${context.l.payloads_screen_area} ${area.areaId}'),
        _MetricRow(label: context.l.passed_by, value: '${area.passBy}', icon: Icons.moving, iconColor: Colors.blueGrey),
        _MetricRow(
          label: context.l.stayed,
          value: '${area.stay}',
          icon: Icons.accessibility_new_outlined,
          iconColor: Colors.blue.shade600,
        ),
        _MetricRow(
          label: context.l.entered,
          value: '${area.entry}',
          icon: Icons.login,
          iconColor: Colors.green.shade600,
        ),
        _MetricRow(
          label: context.l.exited,
          value: '${area.exit}',
          icon: Icons.logout,
          iconColor: Colors.orange.shade700,
        ),
        _MetricRow(label: context.l.appeared, value: '${area.appear}'),
        _MetricRow(label: context.l.disappeared, value: '${area.disappear}'),
        _MetricRow(label: context.l.average_occupancy, value: area.avgOccupancy.toStringAsFixed(2)),
        _MetricRow(label: context.l.maximum_occupancy, value: '${area.maxOccupancy}'),
        _MetricRow(label: context.l.average_stay, value: formatCompactDuration(context.l, area.avgDwellSec)),
        _MetricRow(label: context.l.maximum_stay, value: formatCompactDuration(context.l, area.maxDwellSec)),
      ],
    );
  }
}
