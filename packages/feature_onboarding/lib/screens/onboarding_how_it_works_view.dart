// ===============================================
// Module: onboarding_how_it_works_view.dart
// Description: Intro page 2 (how it works)
//
// Sections:
//   - OnboardingHowItWorksView widget
// ===============================================
import 'package:flutter/material.dart';

class OnboardingHowItWorksView extends StatelessWidget {
  const OnboardingHowItWorksView({super.key});

  @override
  Widget build(BuildContext context) {
    final Color secondaryText = Colors.blueGrey;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Works like a smart sensor',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          Text(
            'Once started, Piyuo Counter runs continuously. It summarizes counts every 5 minutes and sends them automatically. Data is aligned to the clock: 00, 05, 10, 15 ... 24/7.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, color: secondaryText),
          ),
          Text(
            'Perfect for foot-traffic analytics',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, color: secondaryText),
          ),
          const SizedBox(height: 10.0),
          SizedBox(height: 220.0, child: Image.asset('assets/images/welcome2.png', fit: BoxFit.cover)),
        ],
      ),
    );
  }
}
