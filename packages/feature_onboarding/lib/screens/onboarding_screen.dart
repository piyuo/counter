// ===============================================
// Module: guide_screen.dart
// Description: Intro carousel for the wizard flow
//
// Sections:
//   - Imports
//   - GuideScreen widget
// ===============================================
import 'package:carousel_slider/carousel_slider.dart';
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'onboarding_how_it_works_view.dart';
import 'onboarding_intro_view.dart';
import 'onboarding_privacy_view.dart';

const int _pageCount = 3;

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  /// Carousel controller to programmatically change pages
  final CarouselSliderController _carouselController = CarouselSliderController();

  /// Track the current page index for indicators and button logic
  int _currentPageIndex = 0;

  List<Widget> _buildPages() => const [OnboardingIntroView(), OnboardingHowItWorksView(), OnboardingPrivacyView()];

  @override
  Widget build(BuildContext context) {
    return feature_pip.PipScaffold(
      backgroundColor: CupertinoColors.white,
      //titleWidget: Text('Hello Title', style: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context))),
      action: CupertinoButton(
        sizeStyle: CupertinoButtonSize.medium,
        onPressed: () {
          ref.read(core_domain.navigationEventBusProvider).add(const core_domain.OpenOnboardingCTA());
        },
        child: Text('Skip Intro'), //todo:add translation
      ),
      child: Container(
        color: CupertinoColors.white,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: ScrollController(),
              padding: const EdgeInsets.only(bottom: 120.0),
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 450.0,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) => setState(() => _currentPageIndex = index),
                    ),
                    carouselController: _carouselController,
                    items: _buildPages(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pageCount, (index) {
                      final bool isActive = _currentPageIndex == index;
                      return GestureDetector(
                        onTap: () => _carouselController.animateToPage(index),
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
                ],
              ),
            ),
            Positioned(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
              child: SafeArea(
                top: false,
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    onPressed: () {
                      if (_currentPageIndex == _pageCount - 1) {
                        ref.read(core_domain.navigationEventBusProvider).add(const core_domain.OpenOnboardingCTA());
                        return;
                      }
                      _carouselController.nextPage();
                    },
                    child: Text('Next'), //todo:add translation
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
