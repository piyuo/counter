import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/pip_state.dart';
import '../widgets/panel.dart';

part 'pip_notifier.g.dart';

abstract class PipController {
  void setCurrentRoute(String route);
  void resetScroll();
  void removeScrollController(String route);
  Future<void> slideUp(SlidingPanelState slidingPanelState);
}

@riverpod
class PipNotifier extends _$PipNotifier implements PipController {
  late final NavigatorObserver scrollObserver;

  /// the scroll controllers for each page
  final Map<String, ScrollController> _scrollControllers = {};

  PanelController panelController = PanelController();

  /// the key for the sliding panel
  final GlobalKey<SlidingUpPanelState> panelKey = GlobalKey<SlidingUpPanelState>();

  PipNotifier() {
    scrollObserver = ScrollObserver(this);
  }

  @override
  PipState build() {
    // add dispose callback to dispose scroll controllers
    ref.onDispose(() {
      for (final scrollController in _scrollControllers.values) {
        scrollController.dispose();
      }
      _scrollControllers.clear();
    });
    return PipState(scrollObserver: ScrollObserver(this));
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

  /// called by parent to notify their scroll position
  void onScroll(ScrollController scrollController) {
    if (panelKey.currentState != null) {
      panelKey.currentState!.onScroll(scrollController);
    }
  }

  /// called by parent to reset the scroll position
  void resetScroll() {
    if (panelKey.currentState != null) {
      panelKey.currentState!.resetScroll();
    }
  }

  /// get the scroll controller for a given route
  ScrollController getScrollController(String route) {
    if (_scrollControllers.containsKey(route)) {
      return _scrollControllers[route]!;
    }
    final scrollController = ScrollController();
    scrollController.addListener(() => onScroll(scrollController));
    _scrollControllers[route] = scrollController;
    return scrollController;
  }

  /// remove the scroll controller for a given route
  void removeScrollController(String route) {
    final scrollController = _scrollControllers[route];
    if (scrollController != null) {
      scrollController.dispose();
    }
    _scrollControllers.remove(route);
  }

  /// get the current route
  void setCurrentRoute(String route) {
    state = state.copyWith(currentRoute: route);
  }

  /// get the current route's scroll controller
  ScrollController? getScrollControllerByRoute(String route) {
    return _scrollControllers[route];
  }

  /// get the current route's scroll offset
  double getCurrentScrollOffset() {
    final scrollController = _scrollControllers[state.currentRoute];
    if (scrollController != null && scrollController.hasClients) {
      return scrollController.offset;
    }
    return 0.0;
  }
}

class ScrollObserver extends NavigatorObserver {
  ScrollObserver(this.pipController);

  PipController pipController;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final currentRouteName = route.settings.name;
    if (currentRouteName != null) {
      Future.microtask(() {
        pipController.setCurrentRoute(currentRouteName);
        pipController.resetScroll();
      });
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    final previousRouteName = previousRoute?.settings.name;
    final currentRouteName = route.settings.name;
    if (previousRouteName != null) {
      Future.microtask(() {
        pipController.setCurrentRoute(previousRouteName);
        if (currentRouteName != null) {
          pipController.removeScrollController(currentRouteName);
        }
        pipController.resetScroll();
      });
    }
  }
}
