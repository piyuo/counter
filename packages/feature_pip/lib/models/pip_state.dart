import 'package:flutter/material.dart';

/// Defines the states of a sliding panel.
///
/// This enum represents the three possible states of a sliding panel:
/// - [SlidingPanelState.open]: The panel is fully open.
/// - [SlidingPanelState.halfOpen]: The panel is in a half-open state.
/// - [SlidingPanelState.closed]: The panel is fully closed.
enum SlidingPanelState { open, halfOpen, closed }

class PipState {
  const PipState({
    required this.scrollObserver,
    this.currentRoute = '',
    this.slidingPanelState = SlidingPanelState.closed,
    this.isPanelOpened = false,
    this.isSidebarLayout = false,
  });

  /// the scroll observer
  final NavigatorObserver scrollObserver;

  PipState copyWith({
    NavigatorObserver? scrollObserver,
    String? currentRoute,
    SlidingPanelState? slidingPanelState,
    bool? isPanelOpened,
    bool? isSidebarLayout,
  }) {
    return PipState(
      scrollObserver: scrollObserver ?? this.scrollObserver,
      currentRoute: currentRoute ?? this.currentRoute,
      slidingPanelState: slidingPanelState ?? this.slidingPanelState,
      isPanelOpened: isPanelOpened ?? this.isPanelOpened,
      isSidebarLayout: isSidebarLayout ?? this.isSidebarLayout,
    );
  }

  /// the current route
  final String currentRoute;

  // the state of the sliding panel
  final SlidingPanelState slidingPanelState;

  /// is the sliding panel opened?
  final bool isPanelOpened;

  /// is the sidebar layout?
  final bool isSidebarLayout;
}
