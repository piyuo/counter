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
import 'package:feature_onboarding/widgets/carousel_page_indicator.dart';
import 'package:feature_onboarding/widgets/next_button_container.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_platform/universal_platform.dart';

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
      themeData: const CupertinoThemeData(brightness: Brightness.light),
      action: CupertinoButton(
        sizeStyle: CupertinoButtonSize.medium,
        onPressed: () {
          ref.read(core_domain.navigationEventBusProvider).add(const core_domain.OpenOnboardingCTA());
        },
        child: Text('Skip Intro'), //todo:add translation
      ),
      builder: (scrollController) {
        return NextButtonContainer(
          onNextPressed: () {
            if (_currentPageIndex == _pageCount - 1) {
              ref.read(core_domain.navigationEventBusProvider).add(const core_domain.OpenOnboardingCTA());
              return;
            }
            _carouselController.nextPage();
          },
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.only(bottom: 120.0),
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    // Mobile screens are narrower so text wraps onto more lines,
                    // requiring extra height compared to the wider macOS window.
                    height: UniversalPlatform.isMobile ? 500.0 : 450.0,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) => setState(() => _currentPageIndex = index),
                  ),
                  carouselController: _carouselController,
                  items: _buildPages(),
                ),
                CarouselPageIndicator(
                  pageCount: _pageCount,
                  currentPageIndex: _currentPageIndex,
                  onPageSelected: (index) => _carouselController.animateToPage(index),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
