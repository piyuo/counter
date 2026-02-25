import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/pip_state.dart';
import '../widgets/panel.dart';
import 'scroll_event_bus.dart';

part 'pip_notifier.g.dart';

/// Contract for controlling PIP (Picture-in-Picture) scroll and panel behavior.
///
/// Implemented by [PipNotifier]. Exposed as an interface so callers depend on
/// the abstraction rather than the concrete Riverpod notifier.
abstract class PipController {
  /// The saved scroll offset of the currently active route.
  double get scrollOffset;

  /// Removes the stored scroll position for [path],
  /// so the route scrolls back to the top on next visit.
  void clearScrollPosition(String path);

  /// Opens the sliding panel to [slidingPanelState].
  /// In sidebar layout this is a no-op on the panel but still marks it as opened.
  Future<void> slideUp(SlidingPanelState slidingPanelState);
}

@riverpod
class PipNotifier extends _$PipNotifier implements PipController {
  /// Map to store scroll positions for each route
  Map<String, double> scrollPositions = {};

  /// the current scroll position of the active route
  double currentScrollPosition = 0;

  /// Controller for the sliding panel
  PanelController panelController = PanelController();

  /// the key for the sliding panel
  final GlobalKey<SlidingUpPanelState> panelKey = GlobalKey<SlidingUpPanelState>();

  @override
  PipState build() {
    ref.onDispose(() {});
    return PipState();
  }

  /// bring the sliding panel up or set to opened in side layout
  @override
  Future<void> slideUp(SlidingPanelState slidingPanelState) async {
    if (panelController.isAttached) {
      await setSlidingPanelState(slidingPanelState);
    }
    state = state.copyWith(isPanelOpened: true);
  }

  /// full open the sliding panel
  Future<void> setSlidingPanelState(SlidingPanelState slidingPanelState) async {
    if (state.isSidebarLayout) {
      return;
    }
    state = state.copyWith(slidingPanelState: slidingPanelState);
    if (panelController.isAttached) {
      switch (slidingPanelState) {
        case SlidingPanelState.open:
          await panelController.animatePanelToPosition(1);
          break;
        case SlidingPanelState.halfOpen:
          await panelController.animatePanelToPosition(0.5);
          break;
        case SlidingPanelState.closed:
          await panelController.animatePanelToPosition(0);
          break;
      }
    }
  }

  /// set the sliding panel opened
  void setIsPanelOpened(bool value) {
    if (state.isPanelOpened == value) {
      return;
    }
    state = state.copyWith(isPanelOpened: value);
  }

  /// set the sidebar layout
  void setIsSidebarLayout(bool value) {
    if (state.isSidebarLayout == value) {
      return;
    }
    state = state.copyWith(isSidebarLayout: value);
  }

  /// animate the sliding panel to the snap point
  void animatePanelToSnapPoint() {
    if (panelController.isAttached) {
      panelController.animatePanelToSnapPoint();
    }
  }

  /// Removes the stored scroll position for the given route path,
  /// so the route starts from the top on next visit.
  @override
  void clearScrollPosition(String path) {
    scrollPositions.remove(path);
  }

  /// Records the scroll position for [routePath] and notifies the sliding panel
  /// to emit a scroll-to-top event when the user scrolls to the very top.
  void onScrollNotification(String routePath, ScrollNotification notification) {
    scrollPositions[routePath] = notification.metrics.pixels;
    currentScrollPosition = notification.metrics.pixels;

    if (panelKey.currentState != null) {
      final sendScrollToTopEvent = panelKey.currentState!.onScroll();
      if (sendScrollToTopEvent) {
        // send scroll to top event to the content
        ref.read(scrollEventBusProvider).add(const ScrollToTopEvent());
      }
    }
  }

  /// Restores the scroll position for [newPath] from the saved positions map.
  /// Called whenever the active route changes.
  void onRouteChanged(String newPath) {
    currentScrollPosition = scrollPositions[newPath] ?? 0;
  }

  /// The saved scroll offset of the currently active route.
  @override
  double get scrollOffset => currentScrollPosition;
}
