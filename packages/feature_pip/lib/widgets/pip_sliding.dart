import 'package:flutter/cupertino.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:universal_platform/universal_platform.dart';

import '../providers/pip_notifier.dart';
import 'panel.dart';

/// the radius of the sliding panel
const BorderRadiusGeometry _slidingPanelRadius = BorderRadius.only(
  topLeft: Radius.circular(10.0),
  topRight: Radius.circular(10.0),
);

class PipSliding extends ConsumerWidget {
  const PipSliding({
    required this.builder,
    required this.minHeight,
    this.transformRotation = 0,
    this.isShowDragHeader = true,
    this.isLockedOpen = false,
    this.width,
    super.key,
  });

  /// the builder function
  final Widget Function(bool) builder;

  /// the width of the sliding panel
  final double? width;

  /// the minimum height of the sliding panel
  final double minHeight;

  /// whether to show the drag header
  final bool isShowDragHeader;

  /// when true, the panel stays fully open and cannot be slid down
  final bool isLockedOpen;

  /// if outside use the transform widget, the rotation of the sliding panel
  final int transformRotation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultLocale = Intl.defaultLocale != null
        ? appkit.localeParseString(Intl.defaultLocale!)
        : appkit.localeSystem;
    final isRTL = Bidi.isRtlLanguage(defaultLocale.toString());

    final pipState = ref.watch(pipProvider);
    final pipController = ref.read(pipProvider.notifier);

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeLeft: true,
      removeBottom: true,
      removeRight: true,
      child: LayoutBuilder(
        builder: (context, constraints) {
          buildContent() {
            return Align(
              alignment: isRTL ? Alignment.topRight : Alignment.topLeft,
              child: SizedBox(
                width: width,
                child: ClipRRect(
                  borderRadius: _slidingPanelRadius,
                  child: !isLockedOpen && isShowDragHeader
                      ? _DragHeader(child: builder(pipState.isPanelOpened))
                      : builder(pipState.isPanelOpened),
                ),
              ),
            );
          }

          return SlidingUpPanel(
            key: pipController.panelKey,
            transformRotation: transformRotation,
            getCurrentScrollOffset: () => pipController.scrollOffset,
            color: CupertinoColors.transparent,
            defaultPanelState: pipState.isPanelOpened ? PanelState.open : PanelState.closed,
            snapPoint: 0.4,
            isLockedOpen: isLockedOpen,
            onPanelOpened: () {
              pipController.setIsPanelOpened(true);
            },
            onPanelClosed: () {
              pipController.setIsPanelOpened(false);
            },
            onPanelSlide: (value) {
              if (value == 0) {
                pipController.setIsPanelOpened(false);
              } else {
                pipController.setIsPanelOpened(true);
              }
            },
            controller: pipController.panelController,
            minHeight: minHeight,
            maxHeight: constraints.maxHeight,
            borderRadius: _slidingPanelRadius,
            panel: UniversalPlatform.isDesktop ? buildContent() : null,
            panelBuilder: UniversalPlatform.isDesktop ? null : buildContent,
          );
        },
      ),
    );
  }
}

/// the drag header
class _DragHeader extends StatelessWidget {
  const _DragHeader({required this.child});

  /// the child widget
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          top: 5,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(bottom: 3),
              decoration: BoxDecoration(
                color: CupertinoColors.opaqueSeparator,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
