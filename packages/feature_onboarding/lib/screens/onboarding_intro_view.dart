// ===============================================
// Module: onboarding_intro_view.dart
// Description: Intro page 1 (what the app does)
//
// Sections:
//   - OnboardingIntroView widget
// ===============================================
import 'package:flutter/material.dart';

class OnboardingIntroView extends StatelessWidget {
  const OnboardingIntroView({super.key});

  @override
  Widget build(BuildContext context) {
    final Color secondaryText = Colors.blueGrey;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Welcome to ',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                ),
                TextSpan(
                  text: 'Piyuo Counter',
                  style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10.0),
          Text(
            'Count pedestrians and vehicles using on-device camera and AI in real time.\n'
            'Privacy-first. No cloud video.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, color: secondaryText),
          ),
          const SizedBox(height: 10.0),
          SizedBox(height: 240, child: Image.asset('assets/images/welcome1.png', fit: BoxFit.cover)),
        ],
      ),
    );
  }
}
