import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_onboarding/widgets/onboarding_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InvitationSummaryScreen extends ConsumerWidget {
  const InvitationSummaryScreen({required this.invitation, super.key});

  final core_domain.Invitation invitation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OnboardingScaffold(
      title: 'You are all set!',
      isNextOrStart: false,
      onNextPressed: () {
        final appFlowController = ref.read(core_domain.appFlowProvider.notifier);
        appFlowController.dispatch(const core_domain.AppFlowEvent.startSession());
      },
      children: [
        SelectableText(
          invitation.instruction,
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
