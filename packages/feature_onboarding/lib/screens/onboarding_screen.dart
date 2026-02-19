// ===============================================
// Module: guide_screen.dart
// Description: Intro carousel for the wizard flow
//
// Sections:
//   - Imports
//   - GuideScreen widget
// ===============================================
import 'package:carousel_slider/carousel_slider.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';

import 'cta_screen.dart';
import 'welcome_1_view.dart';
import 'welcome_2_view.dart';
import 'welcome_3_view.dart';

final CarouselSliderController _controller = CarouselSliderController();

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const int _pageCount = 3;
  int _current = 0;

  List<Widget> _buildPages() => const [Welcome1View(), Welcome2View(), Welcome3View()];

  @override
  Widget build(BuildContext context) {
    return feature_pip.PipScaffold(
      backgroundColor: CupertinoColors.white,
      //titleWidget: Text('Hello Title', style: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context))),
      action: CupertinoButton(
        sizeStyle: CupertinoButtonSize.medium,
        onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute(builder: (_) => const CTAScreen()));
        },
        child: Text('Skip Intro'), //todo:add translation
      ),
      child: Container(
        color: CupertinoColors.white,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 480.0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) => setState(() => _current = index),
                ),
                carouselController: _controller,
                items: _buildPages(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_pageCount, (index) {
                  final bool isActive = _current == index;
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(index),
                    child: Container(
                      width: 10.0,
                      height: 10.0,
                      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CupertinoColors.black.withValues(alpha: isActive ? 0.9 : 0.2),
                      ),
                    ),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0, top: 16.0, left: 16.0, right: 16.0),
                child: SizedBox(
                  width: double.infinity, // Full width makes it unmissable
                  child: CupertinoButton.filled(
                    // FILLED is the key
                    onPressed: () {
                      if (_current == _pageCount - 1) {
                        Navigator.of(context).push(CupertinoPageRoute(builder: (_) => const CTAScreen()));
                        return;
                      }
                      _controller.nextPage();
                    },
                    child: Text('Next'), //todo:add translation
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
