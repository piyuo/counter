import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_onboarding/widgets/onboarding_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServerSummaryScreen extends ConsumerWidget {
  const ServerSummaryScreen({required this.url, super.key});

  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OnboardingScaffold(
      title: 'Congratulations!',
      isNextOrStart: false,
      onNextPressed: () {
        final appFlowController = ref.read(core_domain.appFlowProvider.notifier);
        appFlowController.dispatch(const core_domain.AppFlowEvent.startSession());
      },
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: Text(
            "From now on, we will send foot traffic data to this URL every 5 minutes. ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SelectableText(
            url,
            style: const TextStyle(fontSize: 14, color: Colors.blue, overflow: TextOverflow.ellipsis),
          ),
        ),
        if (url.contains('https://piyuo.com/'))
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: Text(
              "Please copy the url and keep it safe. you can always use this url to check your foot traffic data on our cloud. if you want to stop using our cloud service, just let us know and we will delete all your data on our server.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            "In next step, we will start detection and send data to this url every 5 minutes. ",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
