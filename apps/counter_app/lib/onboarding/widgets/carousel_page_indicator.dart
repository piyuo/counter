import 'package:flutter/material.dart';

/// A row of dot indicators for a carousel/page-view.
///
/// Renders [pageCount] dots and highlights the dot at [currentPageIndex].
/// Tapping a dot calls [onPageSelected] with the tapped index so the caller
/// can drive the carousel (e.g. `controller.animateToPage(index)`).
class CarouselPageIndicator extends StatelessWidget {
  const CarouselPageIndicator({
    super.key,
    required this.pageCount,
    required this.currentPageIndex,
    required this.onPageSelected,
  });

  /// Total number of pages / dots to display.
  final int pageCount;

  /// Index of the currently visible page.
  final int currentPageIndex;

  /// Called with the tapped page index when the user taps a dot.
  final void Function(int index) onPageSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        final bool isActive = currentPageIndex == index;
        return GestureDetector(
          onTap: () => onPageSelected(index),
          child: Container(
            width: 10.0,
            height: 10.0,
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // Active dot is nearly opaque; inactive dots are dimmed
              color: Colors.black.withValues(alpha: isActive ? 0.9 : 0.2),
            ),
          ),
        );
      }),
    );
  }
}
