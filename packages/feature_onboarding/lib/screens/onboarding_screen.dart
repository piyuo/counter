import 'package:carousel_slider/carousel_slider.dart';
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_onboarding/widgets/carousel_page_indicator.dart';
import 'package:feature_onboarding/widgets/onboarding_scaffold.dart';
import 'package:flutter/material.dart';
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
    return OnboardingScaffold(
      action: TextButton(
        onPressed: () {
          ref.go(const core_domain.OpenOnboardingCTA());
        },
        child: Text('Skip Intro'), //todo:add translation
      ),
      onNextPressed: () {
        if (_currentPageIndex == _pageCount - 1) {
          ref.go(const core_domain.OpenOnboardingCTA());
          return;
        }
        _carouselController.nextPage();
      },
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(248, 248, 255, 1),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10.0,
                spreadRadius: 0,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  // Mobile screens are narrower so text wraps onto more lines,
                  // requiring extra height compared to the wider macOS window.
                  height: UniversalPlatform.isMobile ? 460.0 : 390.0,
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
      ],
    );
  }
}
