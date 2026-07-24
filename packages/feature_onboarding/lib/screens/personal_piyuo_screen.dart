import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_pip/feature_pip.dart' as pip;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../widgets/onboarding_scaffold.dart';

class PersonalPiyuoScreen extends ConsumerStatefulWidget {
  const PersonalPiyuoScreen({super.key});

  @override
  ConsumerState<PersonalPiyuoScreen> createState() => _PiyuoScreenState();
}

class _PiyuoScreenState extends ConsumerState<PersonalPiyuoScreen> {
  late final TextEditingController _cloudUrlController;

  @override
  void initState() {
    super.initState();
    final appState = ref.read(core_domain.appProvider).asData?.value;
    assert(appState != null, 'AppState should be available when PersonalCustomServerScreen is initialized.');
    assert(
      appState!.personalPiyuoServer != null,
      'Personal Piyuo Server should be available when PersonalCustomServerScreen is initialized.',
    );
    final existingUrl = appState!.personalPiyuoServer!.url;
    _cloudUrlController = TextEditingController();
    _cloudUrlController.text = existingUrl;
  }

  @override
  void dispose() {
    _cloudUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color cloudUrlColor = Colors.blue;

    return OnboardingScaffold(
      title: context.l.piyuo_server_screen_cloud_url_label,
      footBuilder: (context) => [
        onboardingSpacer(),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            const Text('•'),
            onboardingTextButton(context.l.dpa, () {
              appkit.netOpenUrl('https://piyuo.com/dpa');
            }),
          ],
        ),
      ],
      nextButtonAction: NextButtonAction.start,
      onNextButtonPressed: () async {
        final appController = ref.read(core_domain.appProvider.notifier);
        await appController.selectPersonalPiyuoServer();
        final appFlowController = ref.read(core_domain.appFlowProvider.notifier);
        appFlowController.dispatch(const core_domain.AppFlowEvent.startSession());
      },
      builder: (context) => [
        Text(
          context.l.piyuo_server_screen_url_help,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        onboardingSpacer(),
        Text(
          context.l.piyuo_server_screen_url_remember,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        onboardingSpacer(),

        TextField(
          controller: _cloudUrlController,
          readOnly: true,
          style: TextStyle(fontSize: 16, color: cloudUrlColor),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            suffixIcon: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () async {
                Clipboard.setData(ClipboardData(text: _cloudUrlController.text));
                await pip.showMessageDialog(context.l.piyuo_server_screen_copy_success);
              },
            ),
          ),
        ),

        onboardingSpacer(),

        onboardingSpacer(),

        Text(
          context.l.piyuo_server_screen_start,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
