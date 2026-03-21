import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/providers/reset_notifier.dart';
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
    final localization = appkit.Localization.of(context);
    final currentLocalDisplayLabel = localization.language;
    final dataServer =
        ref.watch(core_domain.appProvider).asData?.value.dataServer ?? const core_domain.DataServer.unspecified();
    final selectedSetupOption = _selectedSetupOption(dataServer);
    return feature_pip.PipScaffold(
      builder: (scrollController) => SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
        child: Column(
          children: [
            feature_pip.PipHeader(icon: Icons.settings, title: 'Settings', subtitle: context.l.settings_screen_desc),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(alignment: AlignmentDirectional.centerStart, child: Text('Data Server')),
            ),
            feature_pip.PipPanel(
              child: Column(
                children: [
                  ListTile(
                    leading: _selectionCheckbox(
                      context,
                      selected: selectedSetupOption == _SettingsSetupOption.piyuoCloud,
                    ),
                    title: const Text('Use Piyuo Cloud'),
                    subtitle: const Text('Send results to our cloud service.'),
                    selected: selectedSetupOption == _SettingsSetupOption.piyuoCloud,
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      ref.push(const core_domain.OpenSettingsPiyuo());
                    },
                  ),
                  ListTile(
                    leading: _selectionCheckbox(
                      context,
                      selected: selectedSetupOption == _SettingsSetupOption.customServer,
                    ),
                    title: const Text('Use your own server'),
                    subtitle: const Text('We will help set up a local server.'),
                    selected: selectedSetupOption == _SettingsSetupOption.customServer,
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      ref.push(const core_domain.OpenSettingsServer());
                    },
                  ),
                  ListTile(
                    leading: _selectionCheckbox(context, selected: selectedSetupOption == _SettingsSetupOption.demo),
                    title: const Text('Demo mode'),
                    subtitle: const Text('Test only. Data is not exported.'),
                    selected: selectedSetupOption == _SettingsSetupOption.demo,
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      await ref.read(core_domain.appProvider.notifier).setNoDataServer();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(alignment: AlignmentDirectional.centerStart, child: Text('Parameters')),
            ),
            feature_pip.PipPanel(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('Detection'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      ref.push(const core_domain.OpenDetectionParams());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.send_outlined),
                    title: Text('Delivery'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      ref.push(const core_domain.OpenDeliveryConfig());
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            feature_pip.PipPanel(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.subscriptions_rounded),
                    title: Text("Subscription"),
                    subtitle: Text("Manage your subscription and billing details."),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text(context.l.wizard_screen_language),
                    subtitle: Text(currentLocalDisplayLabel),
                    trailing: Icon(Icons.arrow_forward_ios),
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
                      title: 'Reset all data?',
                      message: 'This will erase all data and start from the beginning. This action cannot be undone.',
                      actions: [
                        GlassDialogAction(
                          label: 'Cancel',
                          onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
                        ),
                        GlassDialogAction(
                          label: 'Reset',
                          isPrimary: true,
                          isDestructive: true,
                          onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
                        ),
                      ],
                    );
                    if (confirmed != true) return;
                    await ref.read(resetProvider.notifier).reset();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.withValues(alpha: 0.7),
                    minimumSize: const Size.fromHeight(56),
                  ),
                  child: const Text('Reset', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _SettingsSetupOption? _selectedSetupOption(core_domain.DataServer dataServer) {
    return switch (dataServer) {
      core_domain.PersonalDataServer() when dataServer.isPiyuo => _SettingsSetupOption.piyuoCloud,
      core_domain.PersonalDataServer() => _SettingsSetupOption.customServer,
      core_domain.NoDataServer() => _SettingsSetupOption.demo,
      _ => null,
    };
  }

  Widget _selectionCheckbox(BuildContext context, {required bool selected}) {
    return IgnorePointer(
      child: SelectionCheckbox(value: selected, onChanged: (_) {}),
    );
  }
}

enum _SettingsSetupOption { piyuoCloud, customServer, demo }
