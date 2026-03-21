import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/pip_notifier.dart';
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

/// the min height for sliding panel
const double _slidingPanelMinHeight = 128;

/// the animation duration for sliding panel change position
const _animationDuration = Duration(milliseconds: 100);

double _kSlidingPanelWidth = 400;

/// Picture in Picture screen
class PipScreen extends ConsumerWidget {
  const PipScreen({required this.builder, required this.slidingBuilder, required this.isLockToPortrait, super.key});

  /// the main screen builder
  final Widget Function(bool isSideLayout) builder;

  /// the sliding builder
  final Widget Function(bool) slidingBuilder;

  /// is the device orientation locked to portrait
  final bool isLockToPortrait;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final safePadding = MediaQuery.of(context).padding;
    final isLockedOpen = ref.watch(pipProvider).isLockedOpen;

    return OrientationBuilder(
      builder: (context, orientation) => LayoutBuilder(
        builder: (context, constraints) {
          final isSidebarLayout = constraints.maxWidth > _sidebarLayoutWidthThreshold;
          // screen is big enough, use sidebar layout
          buildSidebarLayout() {
            return AnimatedPositioned(
              duration: _animationDuration,
              left: 0,
              width: _kSlidingPanelWidth,
              top: 0,
              bottom: 0,
              child: Container(
                // near-black base — solid anchor so white text always reads
                decoration: BoxDecoration(
                  color: const Color(0xFF080B14),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.65), offset: const Offset(0, 2), blurRadius: 10),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  children: [
                    // light blob 1 — deep violet, top-left corner
                    Positioned(
                      top: -120,
                      left: -80,
                      child: Container(
                        width: 360,
                        height: 360,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(colors: [Color(0xBB5600CC), Color(0x005600CC)]),
                        ),
                      ),
                    ),
                    // light blob 2 — indigo-blue, middle-right
                    Positioned(
                      top: 280,
                      right: -70,
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(colors: [Color(0x993B6FFF), Color(0x003B6FFF)]),
                        ),
                      ),
                    ),
                    // light blob 3 — teal-cyan, bottom-left
                    Positioned(
                      bottom: -90,
                      left: -30,
                      child: Container(
                        width: 260,
                        height: 260,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(colors: [Color(0x7700C8B0), Color(0x0000C8B0)]),
                        ),
                      ),
                    ),
                    // content on top of the blobs
                    Padding(
                      padding: const EdgeInsets.only(top: 22),
                      child: Padding(padding: const EdgeInsets.all(16.0), child: slidingBuilder(false)),
                    ),
                  ],
                ),
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
                    width: _kSlidingPanelWidth,
                    child: PipSliding(
                      isLockedOpen: isLockedOpen,
                      width: _kSlidingPanelWidth,
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
                      isLockedOpen: isLockedOpen,
                      minHeight: _slidingPanelMinHeight + safePadding.bottom,
                      builder: slidingBuilder,
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
                isLockedOpen: isLockedOpen,
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
              left: cWidth / 2 - (_kSlidingPanelWidth / 2),
              // keep the sliding panel to the right
              top: top + (constraints.maxHeight / 2 - (_kSlidingPanelWidth / 2)) - safePadding.bottom,
              // keep the sliding panel to the left, not for now. to keep camera preview smoothly
              // - (constraints.maxHeight / 2 - (_slidingPanelWidth / 2)) + safePadding.top,
              height: cWidth,
              width: _kSlidingPanelWidth,
              child: Transform.rotate(
                angle: 90 * (pi / 180),
                child: PipSliding(
                  isLockedOpen: isLockedOpen,
                  transformRotation: 90,
                  width: _kSlidingPanelWidth,
                  minHeight: _slidingPanelMinHeight,
                  builder: slidingBuilder,
                ),
              ),
            );
          }

          // ignore: unused_element
          buildSliding270() {
            final cWidth = constraints.maxWidth - 10;
            return AnimatedPositioned(
              duration: _animationDuration,
              left: cWidth / 2 - (_kSlidingPanelWidth / 2) + 10,
              top:
                  constraints.maxHeight / 2 -
                  (cWidth / 2) +
                  (constraints.maxHeight / 2 - (_kSlidingPanelWidth / 2)) -
                  10 -
                  safePadding.bottom,
              height: cWidth,
              width: _kSlidingPanelWidth,
              child: Transform.rotate(
                angle: 270 * (pi / 180),
                child: PipSliding(
                  isLockedOpen: isLockedOpen,
                  transformRotation: 270,
                  width: _kSlidingPanelWidth,
                  minHeight: _slidingPanelMinHeight,
                  builder: slidingBuilder,
                ),
              ),
            );
          }

          return Stack(
            children: [
              AnimatedPositioned(
                duration: _animationDuration,
                left: isSidebarLayout ? _kSlidingPanelWidth : 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: builder(isSidebarLayout),
              ),

              Builder(
                builder: (context) {
                  if (isSidebarLayout) {
                    return buildSidebarLayout();
                  }

                  if (isLockToPortrait) {
                    switch (orientation) {
                      case Orientation.portrait:
                        return buildSliding0();
                      case Orientation.landscape:
                        // for locked portrait, we treat landscape as 90 degree rotation, so we show the sliding panel in landscape right position
                        return buildSliding90();
                    }
                  }

                  return buildSlidingLayout();
                },
              ),
              /*Consumer<vision.OrientationProvider>(builder: (context, orientationProvider, child) {
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
                })*/
            ],
          );
        },
      ),
    );
  }
}
