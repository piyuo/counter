import 'package:flutter/cupertino.dart';

import 'panel.dart';
import 'pip_provider.dart';

/// the radius of the sliding panel
const BorderRadiusGeometry _slidingPanelRadius = BorderRadius.only(
  topLeft: Radius.circular(10.0),
  topRight: Radius.circular(10.0),
);

/// SlidingPanel show project settings or runtime information
class PipSliding extends StatelessWidget {
  const PipSliding({
    required this.builder,
    required this.pipProvider,
    required this.minHeight,
    this.isShowDragHeader = true,
    this.width,
    super.key,
  });

  /// the builder function
  final Widget Function(ScrollController sc) builder;

  /// the pip provider
  final PipProvider pipProvider;

  /// the width of the sliding panel
  final double? width;

  /// the minimum height of the sliding panel
  final double minHeight;

  /// whether to show the drag header
  final bool isShowDragHeader;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeLeft: true,
        removeBottom: true,
        removeRight: true,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SlidingUpPanel(
              color: CupertinoColors.transparent,
              defaultPanelState: pipProvider.isPanelOpened ? PanelState.open : PanelState.closed,
              snapPoint: 0.5,
              onPanelOpened: () {
                pipProvider.isPanelOpened = true;
              },
              onPanelClosed: () {
                pipProvider.isPanelOpened = false;
              },
              controller: pipProvider.panelController,
              minHeight: minHeight,
              maxHeight: constraints.maxHeight,
              borderRadius: _slidingPanelRadius,
              panelBuilder: (scrollController) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                      width: width,
                      child: ClipRRect(
                        borderRadius: _slidingPanelRadius,
                        child: isShowDragHeader
                            ? _DragHeader(child: builder(scrollController))
                            : builder(scrollController),
                      )),
                );
              },
              /*panel: Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                      width: width,
                      child: ClipRRect(
                        borderRadius: _slidingPanelRadius,
                        child: isShowDragHeader
                            ? _DragHeader(child: builder(ScrollController()))
                            : builder(ScrollController()),
                      )),
                ),*/
            );
          },
        ));
  }
}

/// the drag header
class _DragHeader extends StatelessWidget {
  const _DragHeader({
    required this.child,
  });

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
            )),
      ],
    );
  }
}
