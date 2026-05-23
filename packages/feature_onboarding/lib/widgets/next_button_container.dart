import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/widgets/feedback/glass_progress_indicator.dart';

/// A container widget that overlays a "Next" button at the bottom of the screen.
class NextButtonContainer extends StatelessWidget {
  const NextButtonContainer({
    super.key,
    required this.child,
    this.onNextPressed,
    this.isLoading = false,
    this.isNextOrStart = true,
  });

  /// The main content displayed behind the "Next" button.
  final Widget child;

  /// Callback invoked when the "Next" button is pressed.
  final void Function()? onNextPressed;

  /// When true, shows a loading indicator next to the button text and disables the button.
  final bool isLoading;

  final bool isNextOrStart;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main page content
        Padding(padding: EdgeInsetsGeometry.fromLTRB(16, 0, 16, 0), child: child),
        // "Next" button pinned to the bottom of the screen
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SafeArea(
            child: Padding(
              // Match the system background so the button bar blends with the page
              // Extra bottom padding on mobile to clear the home indicator / nav bar
              padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  elevation: 8,
                  //shadowColor: Colors.green.withValues(alpha: 0.6),
                  shadowColor: Colors.black,
                ),
                onPressed: isLoading ? null : onNextPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isNextOrStart ? 'Next' : 'Start',
                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    if (isLoading) ...[
                      SizedBox(width: 10),
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: GlassProgressIndicator.circular(strokeWidth: 2.5, color: Colors.white),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
