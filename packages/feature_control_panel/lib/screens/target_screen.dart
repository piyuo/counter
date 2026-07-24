// TOC:
// - DetectionTypeSelectionScreen: dedicated picker for detection target type
// - _DetectionTypeOption: a selectable detection type row definition

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/widgets/selection_checkbox.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_l10n/shared_l10n.dart';

class TargetScreen extends ConsumerWidget {
  const TargetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStateAsync = ref.watch(core_domain.appProvider);

    return feature_pip.PipScaffold(
      builder: (scrollController) {
        return appStateAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Failed to load app state. Please restart the app.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          data: (appState) {
            final currentDetection = appState.detectionType;
            final options = <_DetectionTypeOption>[
              _DetectionTypeOption(
                title: context.l.target_pedestrian,
                subtitle: context.l.target_pedestrian_help,
                icon: Icons.directions_walk,
                matches: (detection) => detection is core_domain.DetectionHuman,
                detection: const core_domain.DetectionType.human(),
              ),
              _DetectionTypeOption(
                title: context.l.target_vehicle,
                subtitle: context.l.target_vehicle_help,
                icon: Icons.directions_car,
                matches: (detection) => detection is core_domain.DetectionVehicle,
                detection: const core_domain.DetectionType.vehicle(),
              ),
            ];

            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
              child: Column(
                children: [
                  feature_pip.PipHeader(
                    icon: Icons.gps_fixed,
                    title: context.l.settings_screen_detection_target,
                    subtitle: context.l.target_screen_subtitle,
                  ),
                  feature_pip.PipPanel(
                    child: Column(
                      children: [
                        for (var index = 0; index < options.length; index++) ...[
                          _DetectionTypeTile(
                            option: options[index],
                            selected: options[index].matches(currentDetection),
                            onTap: () async {
                              await ref
                                  .read(core_domain.appProvider.notifier)
                                  .setDetectionType(options[index].detection);
                              if (context.mounted) {
                                Navigator.of(context).maybePop();
                              }
                            },
                          ),
                          if (index < options.length - 1) const Divider(height: 1),
                        ],
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

class _DetectionTypeOption {
  const _DetectionTypeOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.matches,
    required this.detection,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool Function(core_domain.DetectionType detection) matches;
  final core_domain.DetectionType detection;
}

class _DetectionTypeTile extends StatelessWidget {
  const _DetectionTypeTile({required this.option, required this.selected, required this.onTap});

  final _DetectionTypeOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleSmall;
    final subtitleStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey);

    return ListTile(
      leading: IgnorePointer(
        child: SelectionCheckbox(value: selected, onChanged: (_) {}),
      ),
      title: Text(option.title, style: titleStyle),
      subtitle: Text(option.subtitle, style: subtitleStyle),
      selected: selected,
      selectedTileColor: Colors.blue.withValues(alpha: 0.1),
      onTap: onTap,
    );
  }
}
