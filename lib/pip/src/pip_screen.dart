import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'pip_provider.dart';
import 'pip_sliding.dart';

/// the sliding layout
enum SlidingLayout { portrait, landscape, landscape90, landscape270 }

/// the width of the sliding panel
const double _slidingPanelWidth = 330;

/// the minimum height of the sliding panel
const double _slidingPanelMinHeight = 48;

/// the animation duration for sliding panel change position
const _animationDuration = Duration(milliseconds: 300);

/// Picture in Picture screen
class PipScreen extends StatelessWidget {
  const PipScreen({
    required this.builder,
    required this.sliding,
    this.deviceOrientation,
    this.sideLayoutWidthThreshold = 1024,
    super.key,
  });

  /// the main screen builder
  final Widget Function(bool isSideLayout) builder;

  /// the sliding screen
  final Widget sliding;

  /// the device orientation for mobile device
  final DeviceOrientation? deviceOrientation;

  /// the width threshold for using side layout
  final double sideLayoutWidthThreshold;

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding;
    return OrientationBuilder(
      builder: (context, orientation) => LayoutBuilder(
        builder: (context, constraints) => Consumer<PipProvider>(
          builder: (context, pipProvider, _) {
            bool isSideLayout = constraints.maxWidth > sideLayoutWidthThreshold;
            buildSideSliding() {
              return AnimatedPositioned(
                duration: _animationDuration,
                left: 0,
                width: _slidingPanelWidth,
                top: 28, // 28 is height for close/minimize button bar
                bottom: 0,
                child: sliding,
              );
            }

            buildPortraitSliding() {
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
                  child: sliding,
                ),
              );
            }

            buildLandscapeSliding() {
              const top = 10.0;
              return AnimatedPositioned(
                duration: _animationDuration,
                top: top + safePadding.top + 28, // 28 is height for close/minimize button bar
                height: constraints.maxHeight - top,
                left: 20 + safePadding.left,
                width: _slidingPanelWidth,
                child: PipSliding(
                  pipProvider: pipProvider,
                  width: _slidingPanelWidth,
                  minHeight: _slidingPanelMinHeight,
                  child: sliding,
                ),
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
                  child: sliding,
                ),
              );
            }

            buildSliding90() {
              final cWidth = constraints.maxWidth - 10;
              final top = constraints.maxHeight / 2 - (cWidth / 2);
              return AnimatedPositioned(
                duration: _animationDuration,
                left: cWidth / 2 - (_slidingPanelWidth / 2),
                // keep the sliding panel to the right
                top: top + (constraints.maxHeight / 2 - (_slidingPanelWidth / 2)) - safePadding.bottom,
                // keep the sliding panel to the left, not for now. to keep camera preview smoothly
                // - (constraints.maxHeight / 2 - (_slidingPanelWidth / 2)) + safePadding.top,
                height: cWidth,
                width: _slidingPanelWidth,
                child: Transform.rotate(
                    angle: 90 * (pi / 180),
                    child: PipSliding(
                      pipProvider: pipProvider,
                      width: _slidingPanelWidth,
                      minHeight: _slidingPanelMinHeight,
                      child: sliding,
                    )),
              );
            }

            buildSliding270() {
              final cWidth = constraints.maxWidth - 10;
              return AnimatedPositioned(
                duration: _animationDuration,
                left: cWidth / 2 - (_slidingPanelWidth / 2) + 10,
                top: constraints.maxHeight / 2 -
                    (cWidth / 2) +
                    (constraints.maxHeight / 2 - (_slidingPanelWidth / 2)) -
                    10 -
                    safePadding.bottom,
                height: cWidth,
                width: _slidingPanelWidth,
                child: Transform.rotate(
                    angle: 270 * (pi / 180),
                    child: PipSliding(
                      pipProvider: pipProvider,
                      width: _slidingPanelWidth,
                      minHeight: _slidingPanelMinHeight,
                      child: sliding,
                    )),
              );
            }

            determineSlidingLayout() {
              if (isSideLayout) {
                return buildSideSliding();
              }
              if (deviceOrientation != null) {
                switch (deviceOrientation) {
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
              return orientation == Orientation.landscape ? buildLandscapeSliding() : buildPortraitSliding();
            }

            return Material(
                color: CupertinoColors.systemBackground.resolveFrom(context),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: _animationDuration,
                      left: isSideLayout ? _slidingPanelWidth : 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: builder(isSideLayout),
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
