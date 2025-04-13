import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'panel.dart';

/// Defines the states of a sliding panel.
///
/// This enum represents the three possible states of a sliding panel:
/// - [SlidingPanelState.open]: The panel is fully open.
/// - [SlidingPanelState.halfOpen]: The panel is in a half-open state.
/// - [SlidingPanelState.closed]: The panel is fully closed.
enum SlidingPanelState { open, halfOpen, closed }

class PipProvider with ChangeNotifier {
  PipProvider() {
    scrollObserver = ScrollObserver(this);
  }

  /// the scroll controllers for each page
  final Map<String, ScrollController> _scrollControllers = {};

  /// the current route
  String _currentRoute = '';

  /// the scroll observer
  late ScrollObserver scrollObserver;

  /// the sliding panel controller
  PanelController panelController = PanelController();

  /// the state of the sliding panel
  SlidingPanelState _slidingPanelState = SlidingPanelState.closed;

  /// get the current state of the sliding panel
  SlidingPanelState get slidingPanelState => _slidingPanelState;

  /// is the sliding panel opened?
  bool isPanelOpened = false;

  @override
  dispose() {
    for (final scrollController in _scrollControllers.values) {
      scrollController.dispose();
    }
    _scrollControllers.clear();
    super.dispose();
  }

  /// set the sliding panel opened
  void setIsPanelOpened(bool value) {
    if (isPanelOpened == value) {
      return;
    }
    isPanelOpened = value;
    notifyListeners();
  }

  /// animate the sliding panel to the snap point
  void animatePanelToSnapPoint() {
    if (panelController.isAttached) {
      panelController.animatePanelToSnapPoint();
    }
  }

  /// the key for the sliding panel
  final GlobalKey<SlidingUpPanelState> panelKey = GlobalKey<SlidingUpPanelState>();

  /// get the pip provider from the context
  static PipProvider of(BuildContext context) {
    return Provider.of<PipProvider>(context, listen: false);
  }

  /// bring the sliding panel up or set to opened in side layout
  Future<void> init(Duration delayForOpenPanel, SlidingPanelState slidingPanelState) async {
    await Future.delayed(delayForOpenPanel);
    if (panelController.isAttached) {
      await setSlidingPanelState(slidingPanelState);
    }
    isPanelOpened = true;
  }

  /// full open the sliding panel
  Future<void> setSlidingPanelState(SlidingPanelState slidingPanelState) async {
    _slidingPanelState = slidingPanelState;
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
    _currentRoute = route;
  }

  /// get the current route's scroll controller
  ScrollController? getScrollControllerByRoute(String route) {
    return _scrollControllers[route];
  }

  /// get the current route's scroll offset
  double getCurrentScrollOffset() {
    final scrollController = _scrollControllers[_currentRoute];
    if (scrollController != null && scrollController.hasClients) {
      return scrollController.offset;
    }
    return 0.0;
  }
}

class ScrollObserver extends NavigatorObserver {
  ScrollObserver(this.pipProvider);

  /// the pip provider
  PipProvider pipProvider;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final currentRouteName = route.settings.name;
    if (currentRouteName != null) {
      pipProvider.setCurrentRoute(currentRouteName);
      pipProvider.resetScroll();
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final previousRouteName = previousRoute?.settings.name;
    final currentRouteName = route.settings.name;
    if (previousRouteName != null) {
      pipProvider.setCurrentRoute(previousRouteName);
      if (currentRouteName != null) {
        pipProvider.removeScrollController(currentRouteName);
      }
      pipProvider.resetScroll();
    }
    super.didPop(route, previousRoute);
  }
}
