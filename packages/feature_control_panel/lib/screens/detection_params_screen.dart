// TOC:
// - DetectionParamsScreen: glass-based editor for persisted detection/tracking params
// - _DetectionParamsScreenState: manages a local draft and persists on interaction end
// - _DetectionSliderTile: reusable slider row with title, description, and value label

import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:shared_l10n/shared_l10n.dart';

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
    final confirmed = await GlassDialog.show<bool>(
      context: context,
      title: context.l.detection_screen_reset,
      message: context.l.detection_screen_reset_content,
      actions: [
        GlassDialogAction(label: context.l.no, onPressed: () => Navigator.of(context, rootNavigator: true).pop(false)),
        GlassDialogAction(
          label: context.l.yes,
          isPrimary: true,
          isDestructive: true,
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
        ),
      ],
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
                    subtitle:
                        'Tune how the vision engine associates detections, retains lost tracks, assigns tracklet ids, and updates stay/disappear counts.',
                  ),
                  feature_pip.PipPanel(
                    child: Column(
                      children: [
                        _DetectionSliderTile(
                          title: 'High-Confidence Threshold',
                          description:
                              'Detection confidence needed to enter the first, high-confidence association pass.',
                          value: params.trackHighThresh,
                          min: 0,
                          max: 1,
                          divisions: 100,
                          valueLabel: _percentLabel(params.trackHighThresh),
                          minLabel: 'Loose',
                          maxLabel: 'Strict',
                          onChanged: (value) => _updateDraft((current) => current.copyWith(trackHighThresh: value)),
                          onChangeEnd: (_) => _persistDraft(),
                        ),
                        const Divider(height: 1),
                        _DetectionSliderTile(
                          title: 'New Track Threshold',
                          description:
                              'Detection confidence required to start a brand new track after matching finishes.',
                          value: params.newTrackThresh,
                          min: 0,
                          max: 1,
                          divisions: 100,
                          valueLabel: _percentLabel(params.newTrackThresh),
                          minLabel: 'Aggressive',
                          maxLabel: 'Conservative',
                          onChanged: (value) => _updateDraft((current) => current.copyWith(newTrackThresh: value)),
                          onChangeEnd: (_) => _persistDraft(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  feature_pip.PipPanel(
                    child: Column(
                      children: [
                        _DetectionSliderTile(
                          title: 'Track Buffer',
                          description: 'Base lost-track retention window in 30-FPS-equivalent frames before removal.',
                          value: params.trackBuffer.toDouble(),
                          min: 30,
                          max: 300,
                          divisions: 270,
                          valueLabel: '${params.trackBuffer} frames',
                          minLabel: 'Short',
                          maxLabel: 'Long',
                          onChanged: (value) => _updateDraft((current) => current.copyWith(trackBuffer: value.round())),
                          onChangeEnd: (_) => _persistDraft(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  feature_pip.PipPanel(
                    child: Column(
                      children: [
                        _DetectionSliderTile(
                          title: 'Minimum Presence Time',
                          description: 'Minimum elapsed time before assigning a user-visible tracklet id.',
                          value: params.trackletMinPresenceTimeSec,
                          min: 0,
                          max: 5,
                          divisions: 100,
                          valueLabel: _secondsLabel(params.trackletMinPresenceTimeSec),
                          minLabel: 'Faster',
                          maxLabel: 'Safer',
                          onChanged: (value) =>
                              _updateDraft((current) => current.copyWith(trackletMinPresenceTimeSec: value)),
                          onChangeEnd: (_) => _persistDraft(),
                        ),
                        const Divider(height: 1),
                        _DetectionSliderTile(
                          title: 'Stay Threshold',
                          description: 'Continuous in-area time required before a track contributes to the stay count.',
                          value: params.stayThresholdSeconds.toDouble(),
                          min: 0,
                          max: 60,
                          divisions: 60,
                          valueLabel: _integerSecondsLabel(params.stayThresholdSeconds),
                          minLabel: 'Instant',
                          maxLabel: 'Delayed',
                          onChanged: (value) =>
                              _updateDraft((current) => current.copyWith(stayThresholdSeconds: value.round())),
                          onChangeEnd: (_) => _persistDraft(),
                        ),
                        const Divider(height: 1),
                        _DetectionSliderTile(
                          title: 'Disappear Threshold',
                          description:
                              'Continuous out-of-area time required before a previous track contributes to the disappear count.',
                          value: params.disappearThresholdSeconds.toDouble(),
                          min: 0,
                          max: 30,
                          divisions: 30,
                          valueLabel: _integerSecondsLabel(params.disappearThresholdSeconds),
                          minLabel: 'Fast',
                          maxLabel: 'Slow',
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

String _secondsLabel(double value) => '${value.toStringAsFixed(1)} s';

String _integerSecondsLabel(int value) => '$value s';

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
              Expanded(child: Text(title, style: Theme.of(context).textTheme.titleSmall)),
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
