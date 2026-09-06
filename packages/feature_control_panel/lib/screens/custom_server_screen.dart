import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:shared_l10n/shared_l10n.dart';

class CustomServerScreen extends ConsumerStatefulWidget {
  const CustomServerScreen({super.key});

  @override
  ConsumerState<CustomServerScreen> createState() => _SettingsServerScreenState();
}

class _SettingsServerScreenState extends ConsumerState<CustomServerScreen> {
  //static const List<int> _deliveryIntervalOptions = [5, 10, 15, 30, 60, 120, 240, 480, 720, 1440];

  late final TextEditingController _serverUrlController;
  late final TextEditingController _bearerTokenController;
  //late int _selectedCadenceMin;
  String? _urlError;
  bool _isSaving = false;
  String _bearerTokenPlaceholder = '';

  @override
  void initState() {
    super.initState();
    final appState = ref.read(core_domain.appProvider).asData?.value;
    assert(appState != null, 'AppState should be available when SettingsPersonalCustomScreen is initialized.');

    final existingUrl = appState?.personalCustomServer?.url ?? 'http://localhost:3000';
    //_selectedCadenceMin = appState?.uploadConfig.wallClockCadenceMin ?? 60;
    _serverUrlController = TextEditingController(text: existingUrl);
    _bearerTokenController = TextEditingController();
    _serverUrlController.addListener(_clearError);
    unawaited(_initBearerTokenPlaceholder());
  }

  Future<void> _initBearerTokenPlaceholder() async {
    final bearerTokenLength = await ref.read(core_domain.appRuntimeProvider.notifier).personalCustomServerTokenLength();
    setState(() {
      _bearerTokenPlaceholder = '*' * bearerTokenLength;
    });
  }

  /*
  String _deliveryIntervalLabel(BuildContext context, int minutes) {
    final materialLocalizations = MaterialLocalizations.of(context);
    return switch (minutes) {
      60 || 120 || 240 || 480 || 720 || 1440 =>
        '${materialLocalizations.formatDecimal(minutes ~/ 60)} ${minutes == 60 ? context.l.settings_server_screen_hour_unit_singular : context.l.settings_server_screen_hour_unit_plural}',
      _ => '${materialLocalizations.formatDecimal(minutes)} ${context.l.settings_server_screen_minute_unit_plural}',
    };
  }
*/
  @override
  void dispose() {
    _serverUrlController.removeListener(_clearError);
    _serverUrlController.dispose();
    _bearerTokenController.dispose();
    super.dispose();
  }

  void _clearError() {
    if (_urlError == null) return;
    setState(() {
      _urlError = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return feature_pip.PipScaffold(
      builder: (scrollController) => SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
        child: Column(
          children: [
            feature_pip.PipPanel(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 14),
              child: Column(
                children: [
                  const Icon(Icons.dns_outlined, size: 64),
                  const SizedBox(height: 8),
                  Text(context.l.settings_screen_custom_title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    context.l.settings_screen_custom_subtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            feature_pip.PipPanel(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      context.l.custom_server_screen_server_url_label,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 10),
                    GlassTextField(controller: _serverUrlController),
                    if (_urlError != null) ...[
                      const SizedBox(height: 8),
                      Text(_urlError!, style: const TextStyle(color: Colors.red, fontSize: 14)),
                    ],
                    const SizedBox(height: 16),
                    // don't translate this label, it's a technical term
                    Text('Bearer Token (Optional)', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 10),
                    GlassTextField(controller: _bearerTokenController, placeholder: _bearerTokenPlaceholder),
                    /*const SizedBox(height: 16),
                    Text(
                      context.l.settings_server_screen_delivery_cadence_label,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<int>(
                      initialValue: _selectedCadenceMin,
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      items: [
                        for (final minutes in _deliveryIntervalOptions)
                          DropdownMenuItem<int>(value: minutes, child: Text(_deliveryIntervalLabel(context, minutes))),
                      ],
                      onChanged: _isSaving
                          ? null
                          : (value) {
                              if (value == null) return;
                              setState(() {
                                _selectedCadenceMin = value;
                              });
                            },
                    ),*/
                  ],
                ),
              ),
            ),
            feature_pip.PipPanel(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.help),
                    title: Text(context.l.personal_custom_screen_help_action),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      appkit.netOpenUrl('https://piyuo.com/en/docs/payload-format');
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
                  onPressed: _isSaving
                      ? null
                      : () async {
                          final router = GoRouter.of(context);
                          final serverUrl = _serverUrlController.text.trim();
                          final bearerToken = _bearerTokenController.text.trim();
                          setState(() {
                            _isSaving = true;
                            _urlError = null;
                          });

                          final error = await ref.read(core_domain.urlValidatorServiceProvider).validate(serverUrl);

                          if (!mounted) return;

                          if (error != null) {
                            setState(() {
                              _urlError = error;
                              _isSaving = false;
                            });
                            return;
                          }

                          final appController = ref.read(core_domain.appProvider.notifier);
                          await appController.selectPersonalCustomServer(serverUrl, bearerToken);
                          router.pop();
                        },
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                  child: Text(
                    _isSaving
                        ? context.l.custom_server_screen_bearer_saving_action
                        : context.l.settings_screen_custom_title,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
