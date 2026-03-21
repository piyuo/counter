import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class SettingsServerScreen extends ConsumerStatefulWidget {
  const SettingsServerScreen({super.key});

  @override
  ConsumerState<SettingsServerScreen> createState() => _SettingsServerScreenState();
}

class _SettingsServerScreenState extends ConsumerState<SettingsServerScreen> {
  static const List<int> _deliveryIntervalOptions = [5, 10, 15, 30, 60, 120, 240, 480, 720, 1440];

  late final TextEditingController _serverUrlController;
  late int _selectedCadenceMin;
  String? _urlError;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final appState = ref.read(core_domain.appProvider).asData?.value;
    final existingUrl = appState?.customServerUrl.isNotEmpty == true ? appState!.customServerUrl : 'https://';
    _selectedCadenceMin = appState?.uploadConfig.wallClockCadenceMin ?? 60;
    _serverUrlController = TextEditingController(text: existingUrl);
    _serverUrlController.addListener(_clearError);
  }

  String _deliveryIntervalLabel(int minutes) {
    return switch (minutes) {
      60 => '1 hour',
      120 => '2 hours',
      240 => '4 hours',
      480 => '8 hours',
      720 => '12 hours',
      1440 => '24 hours',
      _ => '$minutes minutes',
    };
  }

  @override
  void dispose() {
    _serverUrlController.removeListener(_clearError);
    _serverUrlController.dispose();
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
                  Text('Custom Server', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    'Set the server URL used for uploads.',
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
                    Text('Server URL', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 10),
                    GlassTextField(controller: _serverUrlController),
                    if (_urlError != null) ...[
                      const SizedBox(height: 8),
                      Text(_urlError!, style: const TextStyle(color: Colors.red, fontSize: 14)),
                    ],
                    const SizedBox(height: 16),
                    Text('Deliver Payload On Wall Clock', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<int>(
                      initialValue: _selectedCadenceMin,
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      items: [
                        for (final minutes in _deliveryIntervalOptions)
                          DropdownMenuItem<int>(value: minutes, child: Text(_deliveryIntervalLabel(minutes))),
                      ],
                      onChanged: _isSaving
                          ? null
                          : (value) {
                              if (value == null) return;
                              setState(() {
                                _selectedCadenceMin = value;
                              });
                            },
                    ),
                  ],
                ),
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
                          final serverUrl = _serverUrlController.text.trim();
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

                          await ref.read(core_domain.appProvider.notifier).setPersonalCustomDataServer(serverUrl);
                          await ref
                              .read(core_domain.appProvider.notifier)
                              .setDeliveryWallClockCadenceMin(_selectedCadenceMin);

                          if (!mounted) return;
                          Navigator.of(context).pop();
                        },
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                  child: Text(_isSaving ? 'Saving...' : 'Use Custom Server'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
