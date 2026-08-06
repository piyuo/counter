// TOC:
// - DetectionParamsScreen: glass-based editor for persisted detection/tracking params
// - _DetectionParamsScreenState: manages a local draft and persists on interaction end
// - _DetectionSliderTile: reusable slider row with title, description, and value label

import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/utils/format_compact_duration.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../widgets/info_dialog.dart';

class DetectionParamsScreen extends ConsumerStatefulWidget {
  const DetectionParamsScreen({super.key});

  @override
  ConsumerState<DetectionParamsScreen> createState() => _DetectionParamsScreenState();
}

class _DetectionParamsScreenState extends ConsumerState<DetectionParamsScreen> {
  core_domain.DetectionParams? _draft;

  Future<void> _persist(core_domain.DetectionParams params) async {
    await ref.read(core_domain.appProvider.notifier).setDetectionParams(params);
  }

  void _updateDraft(core_domain.DetectionParams Function(core_domain.DetectionParams current) update) {
    final current = _draft ?? ref.read(core_domain.appProvider).asData?.value.detectionParams;
    if (current == null) return;

    setState(() {
      _draft = update(current);
    });
  }

  void _persistDraft() {
    final draft = _draft;
    if (draft == null) return;
    unawaited(_persist(draft));
  }

  Future<void> _resetToDefaults(BuildContext context) async {
    final confirmed = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(context.l.detection_screen_reset),
        content: Text(context.l.detection_screen_reset_content),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, false),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context, true),
            child: Text(MaterialLocalizations.of(context).okButtonLabel),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    const defaults = core_domain.DetectionParams();
    setState(() {
      _draft = defaults;
    });
    await _persist(defaults);
  }

  @override
  Widget build(BuildContext context) {
    final appStateAsync = ref.watch(core_domain.appProvider);

    return feature_pip.PipScaffold(
      action: feature_pip.PipActionButton(
        label: context.l.detection_screen_reset,
        onPressed: () => _resetToDefaults(context),
      ),
      builder: (scrollController) {
        return appStateAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Failed to load detection settings.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          data: (appState) {
            final params = _draft ?? appState.detectionParams;

            // Keep the end-user UI intentionally small. These six controls map
            // to concepts users can usually reason about: detection strictness,
            // new-track creation, lost-track retention, tracklet-id delay, and
            // the stay/disappear dwell windows used by window counting.
            // The remaining DetectionParams fields are still persisted and sent
            // to VisionParams, but stay hidden here because they are tracker-
            // internal matching heuristics or edge-zone tuning knobs:
            // trackLowThresh, maxMatchDistance, proximityThresh,
            // appearanceThresh, frameRate, lambda, softMotionGating,
            // preferAppearanceFallbackOnLowIou, trackletEdgeZoneRatio,
            // trackletEdgeZoneMinPx, and trackletEdgeOverrideTimeSec.

            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
              child: Column(
                children: [
                  feature_pip.PipHeader(
                    icon: Icons.tune,
                    title: context.l.detection_screen_title,
                    subtitle: context.l.detection_screen_subtitle,
                  ),
                  feature_pip.PipPanel(
                    child: Column(
                      children: [
                        _DetectionToggleTile(
                          title: context.l.detection_screen_show_track_id,
                          description: context.l.detection_screen_show_track_id_help,
                          value: appState.isTrackIdVisible,
                          onChanged: (value) {
                            setState(() {
                              ref.read(core_domain.appProvider.notifier).setTrackIdVisible(value);
                            });
                          },
                        ),
                        const Divider(height: 1),
                        _DetectionSliderTile(
                          title: context.l.detection_screen_confidence,
                          description: context.l.detection_screen_confidence_help,
                          infoContent: context.l.detection_screen_confidence_dialog,
                          value: params.trackHighThresh,
                          min: 0,
                          max: 1,
                          divisions: 100,
                          valueLabel: _percentLabel(params.trackHighThresh),
                          minLabel: context.l.detection_screen_confidence_min_label,
                          maxLabel: context.l.detection_screen_confidence_max_label,
                          onChanged: (value) => _updateDraft((current) => current.copyWith(trackHighThresh: value)),
                          onChangeEnd: (_) => _persistDraft(),
                        ),
                        const Divider(height: 1),
                        _DetectionSliderTile(
                          title: context.l.detection_screen_new_track,
                          description: context.l.detection_screen_new_track_help,
                          infoContent: context.l.detection_screen_track_dialog,
                          value: params.newTrackThresh,
                          min: 0,
                          max: 1,
                          divisions: 100,
                          valueLabel: _percentLabel(params.newTrackThresh),
                          minLabel: context.l.detection_screen_new_track_min_label,
                          maxLabel: context.l.detection_screen_new_track_max_label,
                          onChanged: (value) => _updateDraft((current) => current.copyWith(newTrackThresh: value)),
                          onChangeEnd: (_) => _persistDraft(),
                        ),
                        const Divider(height: 1),
                        _DetectionSliderTile(
                          title: context.l.detection_screen_track_memory,
                          description: context.l.detection_screen_track_memory_help,
                          infoContent: context.l.detection_screen_track_memory,
                          value: params.maxTimeLostSec.toDouble(),
                          min: 0.1,
                          max: 30,
                          divisions: 30,
                          valueLabel: formatCompactDuration(context.l, params.maxTimeLostSec),
                          minLabel: context.l.detection_screen_track_memory_min_label,
                          maxLabel: context.l.detection_screen_track_memory_max_label,
                          onChanged: (value) => _updateDraft((current) => current.copyWith(maxTimeLostSec: value)),
                          onChangeEnd: (_) => _persistDraft(),
                        ),
                        const Divider(height: 1),
                        _DetectionSliderTile(
                          title: context.l.detection_screen_min_presence,
                          description: context.l.detection_screen_min_presence_help,
                          infoContent: context.l.detection_screen_minimum_visible,
                          value: params.trackletMinPresenceTimeSec,
                          min: 0,
                          max: 5,
                          divisions: 100,
                          valueLabel: formatCompactDuration(context.l, params.trackletMinPresenceTimeSec),
                          minLabel: context.l.detection_screen_min_presence_min_label,
                          maxLabel: context.l.detection_screen_min_presence_max_label,
                          onChanged: (value) =>
                              _updateDraft((current) => current.copyWith(trackletMinPresenceTimeSec: value)),
                          onChangeEnd: (_) => _persistDraft(),
                        ),
                        const Divider(height: 1),
                        _DetectionSliderTile(
                          title: context.l.detection_screen_stay,
                          description: context.l.detection_screen_stay_help,
                          infoContent: context.l.detection_screen_stay_threshold,
                          value: params.stayThresholdSeconds.toDouble(),
                          min: 0,
                          max: 1500,
                          divisions: 60,
                          valueLabel: formatCompactDuration(context.l, params.stayThresholdSeconds.toDouble()),
                          minLabel: context.l.detection_screen_stay_min_label,
                          maxLabel: context.l.detection_screen_stay_max_label,
                          onChanged: (value) =>
                              _updateDraft((current) => current.copyWith(stayThresholdSeconds: value.round())),
                          onChangeEnd: (_) => _persistDraft(),
                        ),
                        const Divider(height: 1),
                        _DetectionSliderTile(
                          title: context.l.detection_screen_disappear,
                          description: context.l.detection_screen_disappear_help,
                          infoContent: context.l.detection_screen_disappear_dialog,
                          value: params.disappearThresholdSeconds.toDouble(),
                          min: 0,
                          max: 30,
                          divisions: 30,
                          valueLabel: formatCompactDuration(context.l, params.disappearThresholdSeconds.toDouble()),
                          minLabel: context.l.detection_screen_disappear_min_label,
                          maxLabel: context.l.detection_screen_disappear_max_label,
                          onChanged: (value) =>
                              _updateDraft((current) => current.copyWith(disappearThresholdSeconds: value.round())),
                          onChangeEnd: (_) => _persistDraft(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

String _percentLabel(double value) => '${(value * 100).toStringAsFixed(0)}%';

class _DetectionSliderTile extends StatelessWidget {
  const _DetectionSliderTile({
    required this.title,
    required this.description,
    required this.value,
    required this.min,
    required this.max,
    required this.valueLabel,
    required this.minLabel,
    required this.maxLabel,
    required this.onChanged,
    required this.onChangeEnd,
    this.infoContent,
    this.divisions,
  });

  final String title;
  final String description;
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final String valueLabel;
  final String minLabel;
  final String maxLabel;
  final String? infoContent;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onChangeEnd;

  @override
  Widget build(BuildContext context) {
    final mutedStyle = Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(child: Text(title, style: Theme.of(context).textTheme.titleSmall)),
                    if (infoContent != null) ...[
                      const SizedBox(width: 4),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          showInfoDialog(context: context, title: title, content: infoContent!);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(Icons.info_outline, size: 18, color: Colors.white70),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Text(valueLabel, style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
          const SizedBox(height: 4),
          Text(description, style: mutedStyle),
          const SizedBox(height: 14),
          Row(
            children: [
              SizedBox(width: 56, child: Text(minLabel, style: mutedStyle)),
              const SizedBox(width: 12),
              Expanded(
                child: GlassSlider(
                  value: value,
                  min: min,
                  max: max,
                  divisions: divisions,
                  onChanged: onChanged,
                  onChangeEnd: onChangeEnd,
                  activeColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.85),
                  inactiveColor: Colors.white.withValues(alpha: 0.14),
                  quality: GlassQuality.standard,
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 56,
                child: Text(maxLabel, style: mutedStyle, textAlign: TextAlign.right),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetectionToggleTile extends StatelessWidget {
  const _DetectionToggleTile({
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final mutedStyle = Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: Theme.of(context).textTheme.titleSmall)),
              CupertinoSwitch(value: value, onChanged: onChanged),
            ],
          ),
          const SizedBox(height: 8),
          Text(description, style: mutedStyle),
        ],
      ),
    );
  }
}
