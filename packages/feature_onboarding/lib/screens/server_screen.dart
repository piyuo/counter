import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_onboarding/widgets/onboarding_scaffold.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class ServerScreen extends ConsumerStatefulWidget {
  const ServerScreen({super.key});

  @override
  ConsumerState<ServerScreen> createState() => _ServerScreenState();
}

class _ServerScreenState extends ConsumerState<ServerScreen> {
  static const List<int> _deliveryIntervalOptions = [5, 10, 15, 30, 60, 120, 240, 480, 720, 1440];

  late final TextEditingController _userTypedUrlController;
  late int _selectedCadenceMin;

  String? _urlError;
  bool _isValidating = false;

  @override
  void initState() {
    super.initState();
    final appState = ref.read(core_domain.appProvider).asData?.value;
    final existingUrl = appState?.customServerUrl.isNotEmpty == true ? appState!.customServerUrl : 'https://';
    _selectedCadenceMin = appState?.uploadConfig.wallClockCadenceMin ?? 60;
    _userTypedUrlController = TextEditingController(text: existingUrl);
    _userTypedUrlController.addListener(_onBackendUrlChanged);
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

  void _onBackendUrlChanged() {
    setState(() {
      _urlError = null;
    });
  }

  @override
  void dispose() {
    _userTypedUrlController.removeListener(_onBackendUrlChanged);
    _userTypedUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      onNextPressed: _isValidating
          ? null
          : () async {
              final serverUrl = _userTypedUrlController.text.trim();

              setState(() {
                _isValidating = true;
                _urlError = null;
              });

              final error = await ref.read(core_domain.urlValidatorServiceProvider).validate(serverUrl);

              if (!mounted) return;

              if (error != null) {
                setState(() {
                  _urlError = error;
                  _isValidating = false;
                });
                return;
              }

              setState(() => _isValidating = false);

              final appController = ref.read(core_domain.appProvider.notifier);
              await appController.setPersonalCustomDataServer(serverUrl);
              await appController.setDeliveryWallClockCadenceMin(_selectedCadenceMin);
              ref.go(core_domain.OpenOnboardingServerSummary(url: serverUrl));
            },
      children: [
        feature_pip.PipPanel(
          margin: EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          child: Column(
            children: [Text('Custom Server', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))],
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: Text("Type your own server url", style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
        GlassTextField(controller: _userTypedUrlController),

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: Text('Deliver payload on wall clock', style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
        DropdownButtonFormField<int>(
          initialValue: _selectedCadenceMin,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: [
            for (final minutes in _deliveryIntervalOptions)
              DropdownMenuItem<int>(value: minutes, child: Text(_deliveryIntervalLabel(minutes))),
          ],
          onChanged: _isValidating
              ? null
              : (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedCadenceMin = value;
                  });
                },
        ),

        if (_urlError != null)
          Align(
            alignment: AlignmentGeometry.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
              child: Text(_urlError!, style: const TextStyle(fontSize: 14, color: Colors.red)),
            ),
          ),
        if (_urlError != null)
          TextButton(
            onPressed: () {
              _userTypedUrlController.value = const TextEditingValue(
                text: 'https://',
                selection: TextSelection.collapsed(offset: 8),
              );
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Start over', style: TextStyle(fontSize: 14, color: Colors.blue)),
          ),

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Text(
            "we will send data to this url. if you want to know how to set up your backend, check our documentation.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Text("https://piyuo.com/docs/own-server", style: TextStyle(fontSize: 16, color: Colors.blue)),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Text(
            "It is ok, if you don't have your own server now, you can just set address here like http://localhost:3000 and start using the app, the app will post data (in json format) every 5 minutes, you can write a simple server to see what data posted.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
