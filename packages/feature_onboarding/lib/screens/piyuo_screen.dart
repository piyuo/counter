import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_onboarding/widgets/onboarding_scaffold.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:feature_pip/widgets/show_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class PiyuoScreen extends ConsumerStatefulWidget {
  const PiyuoScreen({super.key});

  @override
  ConsumerState<PiyuoScreen> createState() => _PiyuoScreenState();
}

class _PiyuoScreenState extends ConsumerState<PiyuoScreen> {
  late final TextEditingController _cloudUrlController;

  @override
  void initState() {
    super.initState();
    _cloudUrlController = TextEditingController();
    Future<void>(() async {
      final cloudUrl = await ref.read(core_domain.appProvider.notifier).ensurePiyuoCloudUrl();
      if (!mounted) return;
      _cloudUrlController.text = cloudUrl;
    });
  }

  @override
  void dispose() {
    _cloudUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color cloudLabelColor = Colors.white;
    final Color cloudUrlColor = Colors.blue;

    return OnboardingScaffold(
      isNextOrStart: false,
      onNextPressed: () async {
        final serverUrl = await ref.read(core_domain.appProvider.notifier).ensurePiyuoCloudUrl();
        _cloudUrlController.text = serverUrl;
        final appController = ref.read(core_domain.appProvider.notifier);
        await appController.setPersonalPiyuoDataServer(serverUrl);

        final appFlowController = ref.read(core_domain.appFlowProvider.notifier);
        appFlowController.dispatch(const core_domain.AppFlowEvent.startSession());
      },
      children: [
        feature_pip.PipPanel(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          child: Column(
            children: [
              Text('Congratulations!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 4),
              Text(
                'You have set up Piyuo Cloud as your data server.',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
              ),
            ],
          ),
        ),
        const Text('Your Piyuo Cloud URL', style: TextStyle(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 10),
        GlassTextField(
          controller: _cloudUrlController,
          readOnly: true,
          textStyle: TextStyle(fontSize: 16, color: cloudUrlColor),
          suffixIcon: Icon(Icons.copy, color: cloudLabelColor),
          onSuffixTap: () async {
            Clipboard.setData(ClipboardData(text: _cloudUrlController.text));
            await showMessageDialog('URL copied');
          },
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Text(
            "Please copy the URL and keep it safe. This is the only way to access your data on our cloud.\n\n"
            "For your data security and privacy, we will only send foot traffic data to our cloud, and you will access it use the url.\n\n"
            "Press next to start detecting and you can goto your url to check the result.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
