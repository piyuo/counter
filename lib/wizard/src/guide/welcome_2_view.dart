// ===============================================
// Module: welcome2_view.dart
// Description: Intro page 2 (how it works)
//
// Sections:
//   - Welcome2View widget
// ===============================================
import 'package:flutter/cupertino.dart';

class Welcome2View extends StatelessWidget {
  const Welcome2View({super.key});

  @override
  Widget build(BuildContext context) {
    final Color secondaryText = CupertinoColors.systemGrey.resolveFrom(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Works like a smart sensor',
            textAlign: TextAlign.center,
            style: TextStyle(color: CupertinoColors.activeGreen, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          Text(
            'Once started, Piyuo Counter runs continuously. It summarizes counts every 5 minutes and sends them automatically. Data is aligned to the clock: 00, 05, 10, 15 ... 24/7.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0, color: secondaryText),
          ),
          Text(
            'Perfect for foot-traffic analytics',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0, color: secondaryText),
          ),
          SizedBox(height: 240.0, child: Image.asset('assets/images/welcome2.png', fit: BoxFit.cover)),
        ],
      ),
    );
  }
}
