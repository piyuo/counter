// ===============================================
// Module: welcome3_view.dart
// Description: Intro page 3 (privacy & trust)
//
// Sections:
//   - Welcome3View widget
// ===============================================
import 'package:flutter/cupertino.dart';

class Welcome3View extends StatelessWidget {
  const Welcome3View({super.key});

  @override
  Widget build(BuildContext context) {
    final Color secondaryText = CupertinoColors.systemGrey.resolveFrom(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Built for privacy',
            textAlign: TextAlign.center,
            style: TextStyle(color: CupertinoColors.activeGreen, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12.0),
          Text(
            'Only aggregated counts are sent. No images, no video, no tracking data ever leave the device. No faces. No identities. No privacy law headaches.\n\n'
            'GDPR & CCPA Compliant by Design',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, color: secondaryText),
          ),
          SizedBox(height: 240, child: Image.asset('assets/images/welcome3.png', fit: BoxFit.cover)),
        ],
      ),
    );
  }
}
