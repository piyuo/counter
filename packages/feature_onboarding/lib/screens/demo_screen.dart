import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_onboarding/widgets/onboarding_scaffold.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DemoScreen extends ConsumerWidget {
  const DemoScreen({this.token, super.key});

  final String? token;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OnboardingScaffold(
      isNextOrStart: false,
      onNextPressed: () async {
        final appController = ref.read(core_domain.appProvider.notifier);
        await appController.setNoDataServer();

        final appFlowController = ref.read(core_domain.appFlowProvider.notifier);
        appFlowController.dispatch(const core_domain.AppFlowEvent.startSession());
      },
      children: [
        feature_pip.PipPanel(
          margin: EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          child: Column(
            children: [Text('You are all set!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))],
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: Text(
            "Your device is now set up to use the demo mode. In this mode, we won't send data to any server, but you can still explore the app and see how it works. Feel free to click around and check out the features!",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
