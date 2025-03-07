import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

/// the animation duration for sliding panel change position
const _animationDuration = Duration(milliseconds: 300);

/// Picture in Picture screen
class PipScreen extends StatelessWidget {
  const PipScreen({
    required this.builder,
    required this.slidingBuilder,
    this.deviceOrientationForPortrait,
    super.key,
  });

  /// the main screen builder
  final Widget Function(bool isSideLayout) builder;

  /// the sliding builder
  final Widget Function() slidingBuilder;

  /// the device orientation for locked portrait orientation
  final DeviceOrientation? deviceOrientationForPortrait;

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding;

    return OrientationBuilder(
      builder: (context, orientation) => LayoutBuilder(
        builder: (context, constraints) => Consumer<PipProvider>(
          builder: (context, pipProvider, _) {
            bool isSidebarLayout = constraints.maxWidth > _sidebarLayoutWidthThreshold;
            bool isCompactLayout = constraints.maxHeight < _compactHeightThreshold;

            /// the width of the sliding panel
            double slidingPanelWidth = isCompactLayout ? 330 : 360;
            double slidingPanelMinHeight = 52;

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
                  child: slidingBuilder(),
                ),
              );
            }

            // screen is not big, use sliding
            buildSlidingLayout() {
              // 28 is height for close/minimize button bar, 10 is padding
              double top = 28.0 + (isCompactLayout ? 0 : 10);
              return constraints.maxWidth > _slidingLayoutWidthThreshold
                  // fixed width
                  ? AnimatedPositioned(
                      duration: _animationDuration,
                      top: safePadding.top + top, // 28 is height for close/minimize button bar
                      height: constraints.maxHeight - top,
                      left: 30, // no safePadding.left need more space to show preview,
                      width: slidingPanelWidth,
                      child: PipSliding(
                        pipProvider: pipProvider,
                        width: slidingPanelWidth,
                        minHeight: slidingPanelMinHeight,
                        builder: slidingBuilder,
                      ),
                    )
                  // fill the screen width
                  : AnimatedPositioned(
                      duration: _animationDuration,
                      top: top,
                      height: constraints.maxHeight - top,
                      left: 0,
                      right: 0,
                      child: PipSliding(
                          pipProvider: pipProvider,
                          minHeight: slidingPanelMinHeight + safePadding.bottom,
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
                  minHeight: slidingPanelMinHeight + safePadding.bottom,
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
                      pipProvider: pipProvider,
                      width: slidingPanelWidth,
                      minHeight: slidingPanelMinHeight,
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
                      pipProvider: pipProvider,
                      width: slidingPanelWidth,
                      minHeight: slidingPanelMinHeight,
                      builder: slidingBuilder,
                    )),
              );
            }

            Widget determineSlidingLayout() {
              // screen is big enough, use sidebar layout
              if (isSidebarLayout) {
                return buildSidebarLayout();
              }

              // mobile device in locked portrait mode
              if (deviceOrientationForPortrait != null) {
                switch (deviceOrientationForPortrait) {
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
            }

            return Material(
                color: CupertinoColors.systemBackground.resolveFrom(context),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: _animationDuration,
                      left: isSidebarLayout ? slidingPanelWidth : 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: builder(isSidebarLayout),
                    ),
                    determineSlidingLayout()
                  ],
                ));
          },
        ),
      ),
    );
  }
}
