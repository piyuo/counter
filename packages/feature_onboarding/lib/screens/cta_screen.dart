// Module: cta_screen.dart
// Description: Decision CTA screen
//
// Sections:
//   - CTAScreen widget
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_onboarding/widgets/onboarding_scaffold.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//todo: make sure DPA" (Data Processing Agreement), is in terms of service and privacy policy, and add a link to it in the UI. This is important for legal compliance and user trust."Piyuo Cloud only processes anonymized aggregate counts. We store device identifiers only for subscription validation. We do not store, view, or share raw video or biometric data."
// Technical Metadata: To ensure service reliability, Piyuo Cloud processes technical 'heartbeat' signals and error logs. This data is used solely for service monitoring and debugging and is not linked to any natural person's identity."
class CTAScreen extends ConsumerStatefulWidget {
  const CTAScreen({super.key});

  @override
  ConsumerState<CTAScreen> createState() => _CTAScreenState();
}

enum SetupBy { invitation, piyuoCloud, customServer, demo }

class _CTAScreenState extends ConsumerState<CTAScreen> {
  SetupBy? _setupBy;

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      onNextPressed: _setupBy == null
          ? null
          : () {
              switch (_setupBy!) {
                case SetupBy.invitation:
                  ref.push(const core_domain.OpenOnboardingInvitation());
                  return;
                case SetupBy.piyuoCloud:
                  ref.push(const core_domain.OpenOnboardingPiyuo());
                  return;
                case SetupBy.customServer:
                  ref.push(const core_domain.OpenOnboardingServer());
                  return;
                case SetupBy.demo:
                  ref.push(const core_domain.OpenOnboardingDemo());
                  return;
              }
            },
      children: [
        feature_pip.PipPanel(
          margin: EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          child: Column(
            children: [
              Text('Where should results go?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 4),
              Text(
                'Choose where your counting results should be sent.',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15.0),
        _DecisionCard(
          title: 'Use an invitation',
          body: 'Send results to the organization that invited you.',
          icon: Icons.mail_outline,
          isSelected: _setupBy == SetupBy.invitation,
          textColor: Colors.white,
          onTap: () => setState(() => _setupBy = SetupBy.invitation),
        ),
        const SizedBox(height: 10.0),
        _DecisionCard(
          title: 'Use Piyuo Cloud',
          body: 'Send results to our cloud service.',
          icon: Icons.cloud_outlined,
          isSelected: _setupBy == SetupBy.piyuoCloud,
          textColor: Colors.white,
          onTap: () => setState(() => _setupBy = SetupBy.piyuoCloud),
        ),
        const SizedBox(height: 10.0),
        _DecisionCard(
          title: 'Use your own server',
          body: 'We will help you set up a local server.',
          icon: Icons.dns_outlined,
          isSelected: _setupBy == SetupBy.customServer,
          textColor: Colors.white,
          onTap: () => setState(() => _setupBy = SetupBy.customServer),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
          child: Text(
            "Don't want to connect?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
          ),
        ),
        const SizedBox(height: 10.0),
        _DecisionCard(
          title: 'Demo mode',
          body: 'Test counting only. Data is not saved or exported.',
          icon: Icons.play_circle_outline,
          isSelected: _setupBy == SetupBy.demo,
          textColor: Colors.white.withValues(alpha: 0.8),
          onTap: () => setState(() => _setupBy = SetupBy.demo),
        ),
      ],
    );
  }
}

class _DecisionCard extends StatelessWidget {
  const _DecisionCard({
    required this.title,
    required this.body,
    this.icon,
    required this.isSelected,
    required this.textColor,
    required this.onTap,
  });

  final String title;
  final String body;
  final IconData? icon;
  final bool isSelected;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color fill = isSelected ? Colors.black.withValues(alpha: .6) : Colors.black.withValues(alpha: 0.5);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: isSelected ? Colors.white : Colors.grey.shade700, width: 2),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 22.0,
                          height: 22.0,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.green : Colors.black.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(color: Colors.white, width: 2.0),
                          ),
                          child: isSelected ? const Icon(Icons.check, size: 20.0, color: Colors.white) : null,
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: textColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(body, style: TextStyle(fontSize: 14.0, height: 1.3, color: Colors.grey.shade300)),
                  ],
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 12.0),
                Container(
                  width: 68.0,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Center(child: Icon(icon, size: 34.0, color: textColor)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
