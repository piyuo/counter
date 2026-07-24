import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_platform/universal_platform.dart';

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

/// the animation duration for sliding panel change position
const _animationDuration = Duration(milliseconds: 100);

/// the width for sliding panel in portrait mode
double _kSlidingPanelWidth = 380; // 420

/// the width for sliding panel in landscape mode
double _kSlidingPanelWidthInHorizontal = 360;

/// the min height for sliding panel
const double _slidingPanelMinHeightInHorizontal = 120;

const double _slidingPanelMinHeight = 140;

double _kSidebarPanelWidth = 460;

/// Picture in Picture screen
class PipScreen extends ConsumerWidget {
  const PipScreen({
    required this.builder,
    required this.slidingBuilder,
    required this.isVideoLockToHorizontal,
    this.deviceOrientation,
    super.key,
  });

  /// the main screen builder
  final Widget Function(bool isSideLayout) builder;

  /// the sliding builder
  final Widget Function(bool) slidingBuilder;

  final bool? isVideoLockToHorizontal;

  final DeviceOrientation? deviceOrientation;

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
              width: _kSidebarPanelWidth,
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
          buildSlidingLayout({required bool isHorizontal}) {
            // 28 is height for close/minimize button bar, 10 is padding
            final top =
                (UniversalPlatform.isMobile || (isLockedOpen && constraints.maxWidth < _slidingLayoutWidthThreshold))
                ? 0
                : 38.0;

            return constraints.maxWidth > _slidingLayoutWidthThreshold
                // fixed width
                ? AnimatedPositioned(
                    duration: _animationDuration,
                    top: safePadding.top + top,
                    height: constraints.maxHeight - top,
                    left: 42, // safe padding left to avoid dynamic island
                    width: isHorizontal ? _kSlidingPanelWidthInHorizontal : _kSlidingPanelWidth,
                    child: PipSliding(
                      isLockedOpen: isLockedOpen,
                      width: isHorizontal ? _kSlidingPanelWidthInHorizontal : _kSlidingPanelWidth,
                      minHeight: isHorizontal
                          ? _slidingPanelMinHeightInHorizontal
                          : _slidingPanelMinHeight + safePadding.bottom,
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
                left: isSidebarLayout ? _kSidebarPanelWidth : 0,
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

                  if (isLockedOpen) {
                    // some screen like onboarding, need lock to portrait
                    return buildSlidingLayout(isHorizontal: false);
                  }

                  if (isVideoLockToHorizontal == true) {
                    return buildSlidingLayout(isHorizontal: true);
                  }
                  if (isVideoLockToHorizontal == false) {
                    return buildSlidingLayout(isHorizontal: false);
                  }

                  if (deviceOrientation == DeviceOrientation.landscapeLeft) {
                    return buildSliding270();
                  } else if (deviceOrientation == DeviceOrientation.landscapeRight) {
                    return buildSliding90();
                  }

                  return buildSlidingLayout(isHorizontal: false);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

/*
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
          }*/
