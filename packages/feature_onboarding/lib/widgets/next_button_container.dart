import 'package:flutter/cupertino.dart';
import 'package:universal_platform/universal_platform.dart';

/// A container widget that overlays a "Next" button at the bottom of the screen.
///
/// Wraps [child] in a [Stack] and positions a full-width [CupertinoButton.filled]
/// at the bottom, respecting safe areas and adjusting bottom padding for mobile
/// vs desktop platforms.
class NextButtonContainer extends StatelessWidget {
  const NextButtonContainer({super.key, required this.child, required this.onNextPressed});

  /// The main content displayed behind the "Next" button.
  final Widget child;

  /// Callback invoked when the "Next" button is pressed.
  final void Function() onNextPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main page content
        child,
        // "Next" button pinned to the bottom of the screen
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SafeArea(
            child: Container(
              // Match the system background so the button bar blends with the page
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Extra bottom padding on mobile to clear the home indicator / nav bar
              padding: EdgeInsets.fromLTRB(32, 16, 32, UniversalPlatform.isMobile ? 96 : 64),
              child: CupertinoButton.filled(
                onPressed: onNextPressed,
                child: Text('Next'), //todo:add translation
              ),
            ),
          ),
        ),
      ],
    );
  }
}
