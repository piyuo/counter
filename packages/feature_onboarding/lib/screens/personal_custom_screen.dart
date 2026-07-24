import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../widgets/onboarding_scaffold.dart';

class PersonalCustomScreen extends ConsumerStatefulWidget {
  const PersonalCustomScreen({super.key});

  @override
  ConsumerState<PersonalCustomScreen> createState() => _PersonalCustomServerScreenState();
}

class _PersonalCustomServerScreenState extends ConsumerState<PersonalCustomScreen> {
  late final TextEditingController _userTypedUrlController;

  String? _urlError;
  bool _isValidating = false;

  @override
  void initState() {
    super.initState();
    final appState = ref.read(core_domain.appProvider).asData?.value;
    assert(appState != null, 'AppState should be available when PersonalCustomServerScreen is initialized.');
    final existingUrl = appState?.personalCustomServer?.url ?? 'http://localhost:3000';
    _userTypedUrlController = TextEditingController(text: existingUrl);
    _userTypedUrlController.addListener(_onBackendUrlChanged);
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
      title: context.l.cta_screen_custom,

      onNextButtonPressed: _isValidating
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
              // no bearer token when onboarding, user can add it later in settings if needed
              await appController.selectPersonalCustomServer(serverUrl, '');
              ref.go(core_domain.OpenOnboardingServerSuccess(url: serverUrl));
            },

      builder: (context) => [
        Text(
          context.l.cta_screen_custom_help,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        onboardingSpacer(),

        TextField(
          controller: _userTypedUrlController,
          keyboardType: TextInputType.url,
          autocorrect: false,
          enableSuggestions: false,

          decoration: InputDecoration(
            hintText: 'http://localhost:3000',
            hintStyle: TextStyle(color: Colors.grey.shade400),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),

              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),

              borderSide: const BorderSide(color: Color.fromRGBO(114, 178, 238, 1), width: 2),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),

              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),

              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),

            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          ),
        ),

        if (_urlError != null)
          Align(
            alignment: Alignment.centerLeft,

            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),

              child: Text(_urlError!, style: const TextStyle(fontSize: 14, color: Colors.red)),
            ),
          ),

        if (_urlError != null)
          TextButton(
            onPressed: () {
              _userTypedUrlController.value = const TextEditingValue(
                text: 'http://localhost:3000',
                selection: TextSelection.collapsed(offset: 8),
              );
            },

            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),

            child: Text(
              context.l.personal_custom_screen_reset_action,
              style: TextStyle(fontSize: 14, color: Colors.blue),
            ),
          ),

        onboardingSpacer(),

        Text(
          context.l.personal_custom_screen_build_server.replaceAll('\\n', '\n'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        const SizedBox(height: 8),

        TextButton(
          onPressed: () {
            appkit.netOpenUrl('https://piyuo.com/en/docs/payload-format');
          },

          child: Text(context.l.personal_custom_screen_help_action),
        ),

        onboardingSpacer(),
      ],
    );
  }
}
