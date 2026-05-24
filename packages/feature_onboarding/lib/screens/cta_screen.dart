// Module: cta_screen.dart
// Description: Decision CTA screen
//
// Sections:
//   - CTAScreen widget
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      title: 'Where should data go?',
      nextButtonAction: NextButtonAction.none,
      builder: (context) => [
        Text(
          'Piyuo Counter creates traffic summaries every 5 minutes. '
          'Choose how you want to store and access your data.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        const SizedBox(height: 15.0),

        onboardingPanel(
          Column(
            children: [
              if (core_domain.isFlagInvitationEnabled)
                _DecisionTile(
                  title: 'Use an invitation',
                  body: 'Join an existing organization using an invitation from your administrator.',
                  onTap: () => ref.go(const core_domain.OpenOnboardingInvitation()),
                ),
              if (core_domain.isFlagPiyuoCloudEnabled)
                _DecisionTile(
                  title: 'Use Piyuo Cloud',
                  body: 'Store traffic data in Piyuo Cloud with dashboards and business insights.',
                  isPremium: true,
                  onTap: () => core_domain.isFlagSubscriptionEnabled
                      ? ref.go(const core_domain.OpenOnboardingPiyuoSubscription())
                      : ref.go(const core_domain.OpenOnboardingPiyuo()),
                ),
              _DecisionTile(
                title: 'Use your own server',
                body: 'Send traffic data directly to your own backend or database.',
                isPremium: true,
                onTap: () => core_domain.isFlagSubscriptionEnabled
                    ? ref.go(const core_domain.OpenOnboardingServerSubscription())
                    : ref.go(const core_domain.OpenOnboardingServer()),
              ),
            ],
          ),
        ),

        onboardingSpacer(),

        Text('Prefer not to upload data?', textAlign: TextAlign.start, style: Theme.of(context).textTheme.bodyMedium),

        const SizedBox(height: 10.0),

        onboardingPanel(
          Column(
            children: [
              _DecisionTile(
                title: 'Local Device Only',
                body: 'Store traffic data locally on this device. Nothing is uploaded remotely.',
                onTap: () => ref.go(const core_domain.OpenOnboardingLocal()),
              ),
            ],
          ),
        ),
        onboardingSpacer(),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            onboardingTextButton('Privacy Policy', () {}),
            const Text('•'),
            onboardingTextButton('Terms of Service', () {}),
          ],
        ),
        Text(
          'By continuing, you agree to the Terms of Service and Privacy Policy.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.labelLarge),
            if (isPremium && core_domain.isFlagSubscriptionEnabled) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: const Color(0xFFFAEEDA), borderRadius: BorderRadius.circular(99)),
                child: Text(
                  'Premium',
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
      ),
    );
  }
}
