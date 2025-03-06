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
  /// the sliding panel controller
  PanelController panelController = PanelController();

  /// the state of the sliding panel
  SlidingPanelState _slidingPanelState = SlidingPanelState.closed;

  /// get the current state of the sliding panel
  SlidingPanelState get slidingPanelState => _slidingPanelState;

  /// is the sliding panel opened?
  bool isPanelOpened = false;

  /// the key for the sliding panel
  final GlobalKey<SlidingUpPanelState> panelKey = GlobalKey<SlidingUpPanelState>();

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
}
