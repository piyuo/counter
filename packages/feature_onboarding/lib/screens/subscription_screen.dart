// ===============================================
// Module: subscription_screen.dart
// Description: Option 2 subscription screen
//
// Sections:
//   - SubscriptionScreen widget
//   - _FeatureRow widget
// ===============================================
import 'package:feature_onboarding/widgets/next_button_container.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:universal_platform/universal_platform.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  void _launchTerms() {
    // TODO: wire to terms URL.
  }

  void _launchPrivacy() {
    // TODO: wire to privacy URL.
  }

  void _restorePurchases() {
    // TODO: wire to restore purchases.
  }

  @override
  Widget build(BuildContext context) {
    final Color muted = CupertinoColors.systemGrey.resolveFrom(context);
    return feature_pip.PipScaffold(
      builder: (scrollController) {
        return NextButtonContainer(
          onNextPressed: () {},
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: UniversalPlatform.isMobile ? 90 : 80.0),
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.star_circle, size: 64.0, color: CupertinoColors.systemGreen.resolveFrom(context)),
                  const SizedBox(height: 12.0),
                  const Text(
                    'Founding Member Rate',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey2.resolveFrom(context),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: CupertinoColors.systemGrey4.resolveFrom(context)),
                    ),
                    child: Column(
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '\$9.99',
                                style: TextStyle(fontSize: 28.0, color: muted, decoration: TextDecoration.lineThrough),
                              ),
                              const TextSpan(text: ' '),
                              const TextSpan(
                                text: '\$4.99',
                                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: ' / month',
                                style: TextStyle(fontSize: 16.0, color: muted),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  const Text(
                    '50% off the standard \$9.99 rate, locked in forever',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13.0),
                  ),
                  const SizedBox(height: 20.0),
                  const _FeatureRow(text: 'Continuous 5-minute Data Sync'),
                  const _FeatureRow(text: 'Custom Endpoint & Piyuo Cloud CSV'),
                  const _FeatureRow(text: 'One active counting device'),
                  const _FeatureRow(text: 'Add more devices anytime as your business grows'),
                  const _FeatureRow(text: 'GDPR & CCPA compliant'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: _launchTerms,
                              child: const Text('Terms', style: TextStyle(fontSize: 12)),
                            ),
                            const Text(' • ', style: TextStyle(color: CupertinoColors.systemGrey)),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: _launchPrivacy,
                              child: const Text('Privacy', style: TextStyle(fontSize: 12)),
                            ),
                            const Text(' • ', style: TextStyle(color: CupertinoColors.systemGrey)),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: _restorePurchases,
                              child: const Text('Restore Purchase', style: TextStyle(fontSize: 12)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Subscription automatically renews monthly.\nCancel anytime in your App Store settings.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10, color: CupertinoColors.systemGrey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(CupertinoIcons.check_mark_circled_solid, size: 18.0, color: CupertinoColors.systemGreen),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 14.0, color: CupertinoColors.systemGrey.resolveFrom(context))),
          ),
        ],
      ),
    );
  }
}
