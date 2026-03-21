// TOC:
// - DeliveryConfigScreen: glass-based editor for persisted telemetry delivery settings
// - _DeliveryConfigScreenState: manages a local draft and persists on interaction end
// - _DeliverySliderTile: reusable slider row with title, description, and value label

import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class UploadConfigScreen extends ConsumerStatefulWidget {
  const UploadConfigScreen({super.key});

  @override
  ConsumerState<UploadConfigScreen> createState() => _UploadConfigScreenState();
}

class _UploadConfigScreenState extends ConsumerState<UploadConfigScreen> {
  core_domain.UploadConfig? _draft;

  Future<void> _persist(core_domain.UploadConfig config) async {
    await ref.read(core_domain.appProvider.notifier).applyServerConfigOverrides(deliveryConfig: config);
  }

  void _updateDraft(core_domain.UploadConfig Function(core_domain.UploadConfig current) update) {
    final current = _draft ?? ref.read(core_domain.appProvider).asData?.value.uploadConfig;
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
      title: 'Reset delivery settings?',
      message: 'This restores upload cadence, batching, and timeout to defaults.',
      actions: [
        GlassDialogAction(label: 'No', onPressed: () => Navigator.of(context, rootNavigator: true).pop(false)),
        GlassDialogAction(
          label: 'Yes',
          isPrimary: true,
          isDestructive: true,
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
        ),
      ],
    );
    if (confirmed != true) return;

    const defaults = core_domain.UploadConfig();
    setState(() {
      _draft = defaults;
    });
    await _persist(defaults);
  }

  @override
  Widget build(BuildContext context) {
    final appStateAsync = ref.watch(core_domain.appProvider);

    return feature_pip.PipScaffold(
      action: feature_pip.PipActionButton(label: 'Reset', onPressed: () => _resetToDefaults(context)),
      builder: (scrollController) {
        return appStateAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Failed to load delivery settings.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          data: (appState) {
            final config = _draft ?? appState.uploadConfig;

            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
              child: Column(
                children: [
                  feature_pip.PipHeader(
                    icon: Icons.send_outlined,
                    title: 'Delivery Settings',
                    subtitle: 'configure delivery settings for telemetry uploads',
                  ),
                  feature_pip.PipPanel(
                    child: Column(
                      children: [
                        _DeliverySliderTile(
                          title: 'Wall-Clock Upload Cadence',
                          description: 'How often pending telemetry is uploaded on minute-aligned boundaries.',
                          value: config.wallClockCadenceMin.toDouble(),
                          min: 5,
                          max: 180,
                          divisions: 175,
                          valueLabel: _minutesLabel(config.wallClockCadenceMin),
                          minLabel: 'Frequent',
                          maxLabel: 'Sparse',
                          onChanged: (value) =>
                              _updateDraft((current) => current.copyWith(wallClockCadenceMin: value.round())),
                          onChangeEnd: (_) => _persistDraft(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  feature_pip.PipPanel(
                    child: Column(
                      children: [
                        _DeliverySliderTile(
                          title: 'Maximum Batch Size',
                          description: 'Max number of payload records sent in one HTTP request.',
                          value: config.maxBatchSize.toDouble(),
                          min: 50,
                          max: 1000,
                          divisions: 95,
                          valueLabel: _countLabel(config.maxBatchSize),
                          minLabel: 'Small',
                          maxLabel: 'Large',
                          onChanged: (value) =>
                              _updateDraft((current) => current.copyWith(maxBatchSize: value.round())),
                          onChangeEnd: (_) => _persistDraft(),
                        ),
                        const Divider(height: 1),
                        _DeliverySliderTile(
                          title: 'Request Timeout',
                          description: 'HTTP timeout per upload request.',
                          value: config.timeoutSec.toDouble(),
                          min: 5,
                          max: 120,
                          divisions: 115,
                          valueLabel: _secondsLabel(config.timeoutSec),
                          minLabel: 'Fast fail',
                          maxLabel: 'Wait longer',
                          onChanged: (value) => _updateDraft((current) => current.copyWith(timeoutSec: value.round())),
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

String _minutesLabel(int value) => '$value min';

String _secondsLabel(int value) => '$value s';

String _countLabel(int value) => value.toString();

class _DeliverySliderTile extends StatelessWidget {
  const _DeliverySliderTile({
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
              SizedBox(width: 64, child: Text(minLabel, style: mutedStyle)),
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
                width: 64,
                child: Text(maxLabel, style: mutedStyle, textAlign: TextAlign.right),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
