import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:provider/provider.dart';

import 'pip_provider.dart';
import 'pip_sliding.dart';

/// the scroll event handler
typedef ScrollCallback = void Function(ScrollController scrollController);

/// the sliding layout
enum SlidingLayout { portrait, landscape, landscape90, landscape270 }

/// the width threshold for sidebar layout
const double _sidebarLayoutWidthThreshold = 1350;

/// if the width of the screen is more than this value, use fixed sliding layout, if not use expanded
/// iphone pro max is 440
const double _slidingLayoutWidthThreshold = 500;

/// if the screen height is less than this value, use compact layout
const double _compactHeightThreshold = 600;

/// the min height for sliding panel
const double _slidingPanelMinHeight = 128;

/// the animation duration for sliding panel change position
const _animationDuration = Duration(milliseconds: 100);

/// Picture in Picture screen
class PipScreen extends StatelessWidget {
  const PipScreen({
    required this.builder,
    required this.slidingBuilder,
    required this.isLockToPortrait,
    super.key,
  });

  /// the main screen builder
  final Widget Function(bool isSideLayout) builder;

  /// the sliding builder
  final Widget Function(bool) slidingBuilder;

  /// is the device orientation locked to portrait
  final bool isLockToPortrait;

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding;

    return OrientationBuilder(
      builder: (context, orientation) => LayoutBuilder(
        builder: (context, constraints) => Consumer<PipProvider>(
          builder: (context, pipProvider, _) {
            pipProvider.isSidebarLayout = constraints.maxWidth > _sidebarLayoutWidthThreshold;
            bool isCompactLayout = constraints.maxHeight < _compactHeightThreshold;

            /// the width of the sliding panel
            double slidingPanelWidth = isCompactLayout ? 330 : 360;

            // screen is big enough, use sidebar layout
            buildSidebarLayout() {
              return AnimatedPositioned(
                duration: _animationDuration,
                left: 0,
                width: slidingPanelWidth,
                top: 28, // 28 is height for close/minimize button bar
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: CupertinoColors.black.withValues(alpha: 0.65),
                        offset: const Offset(0, 2),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: slidingBuilder(false),
                ),
              );
            }

            // screen is not big, use sliding
            buildSlidingLayout() {
              // 28 is height for close/minimize button bar, 10 is padding
              const top = 38.0;
              return constraints.maxWidth > _slidingLayoutWidthThreshold
                  // fixed width
                  ? AnimatedPositioned(
                      duration: _animationDuration,
                      top: safePadding.top + top,
                      height: constraints.maxHeight - top,
                      left: 30, // no safePadding.left need more space to show preview,
                      width: slidingPanelWidth,
                      child: PipSliding(
                        pipProvider: pipProvider,
                        width: slidingPanelWidth,
                        minHeight: _slidingPanelMinHeight + safePadding.bottom,
                        builder: slidingBuilder,
                      ),
                    )
                  // fill the screen width
                  : AnimatedPositioned(
                      duration: _animationDuration,
                      top: safePadding.top + top,
                      height: constraints.maxHeight - top,
                      left: 0,
                      right: 0,
                      child: PipSliding(
                          pipProvider: pipProvider,
                          minHeight: _slidingPanelMinHeight + safePadding.bottom,
                          builder: slidingBuilder),
                    );
            }

            buildSliding0() {
              const top = 70.0;
              return AnimatedPositioned(
                duration: _animationDuration,
                top: top,
                height: constraints.maxHeight - top,
                left: 0,
                right: 0,
                child: PipSliding(
                  pipProvider: pipProvider,
                  minHeight: _slidingPanelMinHeight + safePadding.bottom,
                  builder: slidingBuilder,
                ),
              );
            }

            buildSliding90() {
              final cWidth = constraints.maxWidth - 10;
              final top = constraints.maxHeight / 2 - (cWidth / 2);
              return AnimatedPositioned(
                duration: _animationDuration,
                left: cWidth / 2 - (slidingPanelWidth / 2),
                // keep the sliding panel to the right
                top: top + (constraints.maxHeight / 2 - (slidingPanelWidth / 2)) - safePadding.bottom,
                // keep the sliding panel to the left, not for now. to keep camera preview smoothly
                // - (constraints.maxHeight / 2 - (_slidingPanelWidth / 2)) + safePadding.top,
                height: cWidth,
                width: slidingPanelWidth,
                child: Transform.rotate(
                    angle: 90 * (pi / 180),
                    child: PipSliding(
                      transformRotation: 90,
                      pipProvider: pipProvider,
                      width: slidingPanelWidth,
                      minHeight: _slidingPanelMinHeight,
                      builder: slidingBuilder,
                    )),
              );
            }

            buildSliding270() {
              final cWidth = constraints.maxWidth - 10;
              return AnimatedPositioned(
                duration: _animationDuration,
                left: cWidth / 2 - (slidingPanelWidth / 2) + 10,
                top: constraints.maxHeight / 2 -
                    (cWidth / 2) +
                    (constraints.maxHeight / 2 - (slidingPanelWidth / 2)) -
                    10 -
                    safePadding.bottom,
                height: cWidth,
                width: slidingPanelWidth,
                child: Transform.rotate(
                    angle: 270 * (pi / 180),
                    child: PipSliding(
                      transformRotation: 270,
                      pipProvider: pipProvider,
                      width: slidingPanelWidth,
                      minHeight: _slidingPanelMinHeight,
                      builder: slidingBuilder,
                    )),
              );
            }

            return Stack(
              children: [
                AnimatedPositioned(
                  duration: _animationDuration,
                  left: pipProvider.isSidebarLayout ? slidingPanelWidth : 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: builder(pipProvider.isSidebarLayout),
                ),
                Consumer<vision.OrientationProvider>(builder: (context, orientationProvider, child) {
                  // screen is big enough, use sidebar layout
                  if (pipProvider.isSidebarLayout) {
                    return buildSidebarLayout();
                  }

                  // mobile device in locked portrait mode
                  if (isLockToPortrait) {
                    switch (orientationProvider.orientation) {
                      case DeviceOrientation.portraitUp:
                        return buildSliding0();
                      case DeviceOrientation.landscapeRight:
                        return buildSliding90();
                      case DeviceOrientation.landscapeLeft:
                        return buildSliding270();
                      default:
                        return buildSliding0();
                    }
                  }

                  // any other cases, use sliding layout
                  return buildSlidingLayout();
                })
              ],
            );
          },
        ),
      ),
    );
  }
}
