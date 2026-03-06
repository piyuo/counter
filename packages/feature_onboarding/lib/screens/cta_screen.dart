// ===============================================
// Module: cta_screen.dart
// Description: Decision CTA screen
//
// Sections:
//   - CTAScreen widget
// ===============================================
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_onboarding/widgets/next_button_container.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'subscription_screen.dart';

//todo: make sure DPA" (Data Processing Agreement), is in terms of service and privacy policy, and add a link to it in the UI. This is important for legal compliance and user trust."Piyuo Cloud only processes anonymized aggregate counts. We store device identifiers only for subscription validation. We do not store, view, or share raw video or biometric data."
// Technical Metadata: To ensure service reliability, Piyuo Cloud processes technical 'heartbeat' signals and error logs. This data is used solely for service monitoring and debugging and is not linked to any natural person's identity."
class CTAScreen extends ConsumerStatefulWidget {
  const CTAScreen({super.key});

  @override
  ConsumerState<CTAScreen> createState() => _CTAScreenState();
}

class _CTAScreenState extends ConsumerState<CTAScreen> {
  _DecisionOption? _selection;

  @override
  Widget build(BuildContext context) {
    final Color borderColor = CupertinoColors.systemGrey4.resolveFrom(context);
    final Color selectedColor = CupertinoColors.activeBlue;
    return feature_pip.PipScaffold(
      themeData: const CupertinoThemeData(brightness: Brightness.light),
      builder: (scrollController) {
        return NextButtonContainer(
          onNextPressed: _selection == null
              ? null
              : () {
                  switch (_selection!) {
                    case _DecisionOption.invitation:
                      ref
                          .read(core_domain.navigationEventBusProvider)
                          .add(const core_domain.OpenOnboardingInvitation());
                      return;
                    case _DecisionOption.backend:
                      return;
                    case _DecisionOption.local:
                  }

                  Navigator.of(context).push(CupertinoPageRoute(builder: (_) => const SubscriptionScreen()));
                },
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.only(bottom: 120.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Where to send your data?',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: CupertinoColors.systemGreen, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                _DecisionCard(
                  subtitle: 'Option 1 (Invitation):',
                  title: 'Connect with an invitation',
                  body: 'Send data to the organization that invited you.',
                  isSelected: _selection == _DecisionOption.invitation,
                  borderColor: borderColor,
                  selectedColor: selectedColor,
                  onTap: () => setState(() => _selection = _DecisionOption.invitation),
                ),
                const SizedBox(height: 10.0),
                _DecisionCard(
                  subtitle: 'Option 2 (Backend):',
                  title: 'Connect to a backend',
                  body: 'Send data to Piyuo Cloud or your own server. Requires a subscription.',
                  isSelected: _selection == _DecisionOption.backend,
                  borderColor: borderColor,
                  selectedColor: selectedColor,
                  onTap: () => setState(() => _selection = _DecisionOption.backend),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Only summarized 5-minute metadata is sent.\nRaw video never leaves this device.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: CupertinoColors.systemGrey),
                  ),
                ),
                const SizedBox(height: 10.0),
                _DecisionCard(
                  subtitle: 'Testing:', // Changed from Option 3
                  title: 'Local Demo Mode', // Clearer purpose
                  body: 'Verify AI detection and camera angles. \nData is not saved and cannot be exported.',
                  isSelected: _selection == _DecisionOption.local,
                  borderColor: borderColor,
                  selectedColor: CupertinoColors.systemGrey, // Neutral color instead of Blue
                  onTap: () => setState(() => _selection = _DecisionOption.local),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

enum _DecisionOption { invitation, backend, local }

class _DecisionCard extends StatelessWidget {
  const _DecisionCard({
    required this.subtitle,
    required this.title,
    required this.body,
    required this.isSelected,
    required this.borderColor,
    required this.selectedColor,
    required this.onTap,
  });

  final String subtitle;
  final String title;
  final String body;
  final bool isSelected;
  final Color borderColor;
  final Color selectedColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color outline = isSelected ? selectedColor : borderColor;
    final Color fill = isSelected ? selectedColor.withValues(alpha: 0.08) : CupertinoColors.white;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: outline),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 26.0,
              height: 26.0,
              decoration: BoxDecoration(
                color: isSelected ? outline : CupertinoColors.white,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: outline, width: 2.0),
              ),
              child: isSelected
                  ? const Icon(CupertinoIcons.check_mark, size: 18.0, color: CupertinoColors.white)
                  : null,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subtitle, style: TextStyle(fontSize: 14.0, color: CupertinoColors.systemGrey)),
                  Text(
                    title,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: selectedColor),
                  ),
                  Text(body, style: TextStyle(fontSize: 14.0, height: 1.3, color: CupertinoColors.systemGrey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
