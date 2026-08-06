import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/widgets/selection_checkbox.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    final isPedestrian = switch (appState.detectionType) {
      core_domain.DetectionVehicle() => false,
      _ => true,
    };

    return feature_pip.PipScaffold(
      builder: (scrollController) => SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
        child: Column(
          children: [
            feature_pip.PipHeader(icon: Icons.settings, title: context.l.start_screen_settings),
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
                      title: Text(context.l.settings_screen_piyuo_title),
                      subtitle: Text(context.l.settings_screen_piyuo_subtitle, style: TextStyle(fontSize: 12)),
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
                    title: Text(context.l.settings_screen_custom_title),
                    subtitle: Text(context.l.settings_screen_custom_subtitle, style: TextStyle(fontSize: 12)),
                    selected: appState.dataServerSelection == core_domain.DataServerSelection.personalCustom,
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      ref.push(const core_domain.OpenSettingsServer());
                    },
                  ),
                  ListTile(
                    leading: _selectionCheckbox(context, selected: appState.isLocalDeviceOnly),
                    title: Text(context.l.settings_screen_local_title),
                    subtitle: Text(context.l.settings_screen_local_subtitle, style: TextStyle(fontSize: 12)),
                    selected: appState.isLocalDeviceOnly,
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      ref.push(const core_domain.OpenSettingsLocal());
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(context.l.settings_screen_object_detection),
              ),
            ),
            feature_pip.PipPanel(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(isPedestrian ? Icons.directions_walk : Icons.directions_car),
                    title: Text(context.l.settings_screen_detection_target),
                    subtitle: Text(
                      isPedestrian ? context.l.target_pedestrian : context.l.target_vehicle,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade300),
                    ),
                    trailing: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [SizedBox(width: 10), Icon(Icons.arrow_forward_ios)],
                    ),
                    onTap: () {
                      ref.push(const core_domain.OpenTarget());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.tune),
                    title: Text(context.l.detection_screen_title),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      ref.push(const core_domain.OpenDetection());
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(context.l.settings_screen_misc_label),
              ),
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
                    title: Text(context.l.settings_screen_language_title),
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
                    final confirmed = await appkit.showConfirm(
                      title: context.l.settings_screen_reset_all_data_title,
                      message: context.l.settings_screen_reset_all_data_body,
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
