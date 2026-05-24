/// Defines the states of a sliding panel.
///
/// This enum represents the three possible states of a sliding panel:
/// - [SlidingPanelState.open]: The panel is fully open.
/// - [SlidingPanelState.halfOpen]: The panel is in a half-open state.
/// - [SlidingPanelState.closed]: The panel is fully closed.
enum SlidingPanelState { open, halfOpen, closed }

class PipState {
  const PipState({
    this.currentRoute = '',
    this.slidingPanelState = SlidingPanelState.closed,
    this.isPanelOpened = false,
    this.isSidebarLayout = false,
    this.isLockedOpen = false,
  });

  PipState copyWith({
    String? currentRoute,
    SlidingPanelState? slidingPanelState,
    bool? isPanelOpened,
    bool? isSidebarLayout,
    bool? isLockedOpen,
  }) {
    return PipState(
      currentRoute: currentRoute ?? this.currentRoute,
      slidingPanelState: slidingPanelState ?? this.slidingPanelState,
      isPanelOpened: isPanelOpened ?? this.isPanelOpened,
      isSidebarLayout: isSidebarLayout ?? this.isSidebarLayout,
      isLockedOpen: isLockedOpen ?? this.isLockedOpen,
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

  /// is the sliding panel locked to open state?
  /// when true, the panel stays fully open and cannot be slide down or closed
  /// this is used for the pip mode on mobile when the panel should always be open and not slidable
  /// usually used in onboarding when we need full screen pip.
  final bool isLockedOpen;
}
