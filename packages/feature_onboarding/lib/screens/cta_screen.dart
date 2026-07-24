// Module: cta_screen.dart
// Description: Decision CTA screen
//
// Sections:
//   - CTAScreen widget
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../widgets/onboarding_scaffold.dart';

//todo: make sure DPA" (Data Processing Agreement), is in terms of service and privacy policy, and add a link to it in the UI. This is important for legal compliance and user trust."Piyuo Cloud only processes anonymized aggregate counts. We store device identifiers only for subscription validation. We do not store, view, or share raw video or biometric data."
// Technical Metadata: To ensure service reliability, Piyuo Cloud processes technical 'heartbeat' signals and error logs. This data is used solely for service monitoring and debugging and is not linked to any natural person's identity."
class CTAScreen extends ConsumerStatefulWidget {
  const CTAScreen({super.key});

  @override
  ConsumerState<CTAScreen> createState() => _CTAScreenState();
}

class _CTAScreenState extends ConsumerState<CTAScreen> {
  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      title: context.l.onboarding_cta_title,
      nextButtonAction: NextButtonAction.none,
      builder: (context) => [
        Text(
          context.l.cta_screen_title.replaceAll('\\n', '\n'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        const SizedBox(height: 15.0),

        onboardingPanel(
          Column(
            children: [
              if (core_domain.isFlagInvitationEnabled)
                _DecisionTile(
                  title: context.l.cta_screen_invitation,
                  body: context.l.cta_screen_invitation_help,
                  onTap: () => ref.go(const core_domain.OpenOnboardingInvitation()),
                ),
              if (core_domain.isFlagPiyuoCloudEnabled)
                _DecisionTile(
                  title: context.l.cta_screen_piyuo,
                  body: context.l.cta_screen_piyuo_help,
                  isPremium: true,
                  onTap: () => core_domain.isFlagSubscriptionEnabled
                      ? ref.go(const core_domain.OpenOnboardingPiyuoSubscription())
                      : ref.go(const core_domain.OpenOnboardingPiyuo()),
                ),
              _DecisionTile(
                title: context.l.cta_screen_custom,
                body: context.l.cta_screen_custom_help,
                isPremium: true,
                onTap: () => core_domain.isFlagSubscriptionEnabled
                    ? ref.go(const core_domain.OpenOnboardingServerSubscription())
                    : ref.go(const core_domain.OpenOnboardingServer()),
              ),
            ],
          ),
        ),

        onboardingSpacer(),

        Text(
          context.l.onboarding_cta_no_server.replaceAll('\\n', '\n'),
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        const SizedBox(height: 10.0),

        onboardingPanel(
          Column(
            children: [
              _DecisionTile(
                title: context.l.cta_screen_local,
                body: context.l.cta_screen_local_help,
                onTap: () => ref.go(const core_domain.OpenOnboardingLocal()),
              ),
            ],
          ),
        ),
        onboardingSpacer(),
        Text(context.l.cta_screen_footer, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _DecisionTile extends StatelessWidget {
  const _DecisionTile({required this.title, required this.body, required this.onTap, this.isPremium = false});

  final String title;
  final String body;
  final VoidCallback onTap;
  final bool isPremium;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(title, style: Theme.of(context).textTheme.labelLarge),
          if (isPremium && core_domain.isFlagSubscriptionEnabled) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: const Color(0xFFFAEEDA), borderRadius: BorderRadius.circular(99)),
              child: Text(
                context.l.cta_screen_premium,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: const Color(0xFF633806), fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(body, style: Theme.of(context).textTheme.bodySmall),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
      splashColor: Colors.blue,
    );
  }
}
