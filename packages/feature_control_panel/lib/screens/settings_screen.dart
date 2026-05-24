import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/widgets/selection_checkbox.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(core_domain.appProvider).asData?.value;
    if (appState == null) {
      return const SizedBox.shrink();
    }
    final localization = appkit.Localization.of(context);
    final currentLocalDisplayLabel = localization.language;
    final selectedDetectionIndex = switch (appState.detectionType) {
      core_domain.DetectionVehicle() => 1,
      _ => 0,
    };

    return feature_pip.PipScaffold(
      builder: (scrollController) => SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
        child: Column(
          children: [
            feature_pip.PipHeader(
              icon: Icons.settings,
              title: context.l.settings_screen_title,
              subtitle: context.l.settings_screen_body,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(context.l.settings_screen_data_server_label),
              ),
            ),
            feature_pip.PipPanel(
              child: Column(
                children: [
                  if (core_domain.isFlagPiyuoCloudEnabled)
                    ListTile(
                      leading: _selectionCheckbox(
                        context,
                        selected: appState.dataServerSelection == core_domain.DataServerSelection.personalPiyuo,
                      ),
                      title: Text('Use Piyuo Cloud'),
                      subtitle: Text('Store traffic data in Piyuo Cloud with dashboards and business insights.'),
                      selected: appState.dataServerSelection == core_domain.DataServerSelection.personalPiyuo,
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        ref.push(const core_domain.OpenSettingsPiyuo());
                      },
                    ),
                  ListTile(
                    leading: _selectionCheckbox(
                      context,
                      selected: appState.dataServerSelection == core_domain.DataServerSelection.personalCustom,
                    ),
                    title: Text('Use your own server'),
                    subtitle: Text('Send traffic data directly to your own backend or database.'),
                    selected: appState.dataServerSelection == core_domain.DataServerSelection.personalCustom,
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      ref.push(const core_domain.OpenSettingsServer());
                    },
                  ),
                  ListTile(
                    leading: _selectionCheckbox(context, selected: appState.isLocalDeviceOnly),
                    title: Text('Local Device Only'),
                    subtitle: Text('Store traffic data locally on this device. Nothing is uploaded remotely.'),
                    selected: appState.isLocalDeviceOnly,
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      await ref.read(core_domain.appProvider.notifier).selectNoDataServer();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(alignment: AlignmentDirectional.centerStart, child: Text('Object Detection')),
            ),
            feature_pip.PipPanel(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.directions_walk),
                    title: Text('Detection Target'),
                    trailing: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          selectedDetectionIndex == 1
                              ? context.l.detection_type_screen_vehicle_title
                              : context.l.detection_type_screen_pedestrian_title,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                    onTap: () {
                      ref.push(const core_domain.OpenDetectionTypeSelection());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.tune),
                    title: Text('Tracking & Counting'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      ref.push(const core_domain.OpenDetectionParams());
                    },
                  ),
                  /*ListTile(
                    leading: const Icon(Icons.send_outlined),
                    title: Text(context.l.settings_screen_delivery_label),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      ref.push(const core_domain.OpenDeliveryConfig());
                    },
                  ),*/
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(alignment: AlignmentDirectional.centerStart, child: Text('Misc')),
            ),
            feature_pip.PipPanel(
              child: Column(
                children: [
                  if (core_domain.isFlagSubscriptionEnabled)
                    ListTile(
                      leading: const Icon(Icons.subscriptions_rounded),
                      title: Text(context.l.settings_screen_subscription_title),
                      subtitle: Text(context.l.settings_screen_subscription_body),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(context.l.wizard_screen_language),
                    subtitle: Text(currentLocalDisplayLabel),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      ref.push(const core_domain.OpenLanguage());
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final confirmed = await GlassDialog.show<bool>(
                      context: context,
                      title: context.l.settings_screen_reset_all_data_title,
                      message: context.l.settings_screen_reset_all_data_body,
                      actions: [
                        GlassDialogAction(
                          label: context.l.cancel,
                          onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
                        ),
                        GlassDialogAction(
                          label: context.l.detection_screen_reset,
                          isPrimary: true,
                          isDestructive: true,
                          onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
                        ),
                      ],
                    );
                    if (confirmed != true) return;
                    await ref.read(core_domain.resetAppProvider.notifier).reset();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.withValues(alpha: 0.7),
                    minimumSize: const Size.fromHeight(56),
                  ),
                  child: Text(context.l.detection_screen_reset, style: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectionCheckbox(BuildContext context, {required bool selected}) {
    return IgnorePointer(
      child: SelectionCheckbox(value: selected, onChanged: (_) {}),
    );
  }
}
