import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Base class for all scroll-related events dispatched through [scrollEventBusProvider].
sealed class ScrollEvent {
  const ScrollEvent();
}

/// Signals that the content of the active route should scroll back to the top.
///
/// Emitted by [PipNotifier] when the user scrolls to the very top while
/// the sliding panel is open.
class ScrollToTopEvent extends ScrollEvent {
  const ScrollToTopEvent();
}

/// A broadcast stream bus for dispatching [ScrollEvent]s across the widget tree.
///
/// Widgets can listen to this stream to react to scroll-driven events (e.g.
/// [ScrollToTopEvent]) without tight coupling to the scroll source.
final scrollEventBusProvider = Provider<StreamController<ScrollEvent>>((ref) {
  final controller = StreamController<ScrollEvent>.broadcast();
  ref.onDispose(controller.close);
  return controller;
});
