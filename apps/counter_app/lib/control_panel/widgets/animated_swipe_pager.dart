// Animated swipe pager.
//
// Contents:
// - AnimatedSwipePager

import 'package:flutter/gestures.dart'
    show PointerScrollEvent, PointerSignalEvent;
import 'package:flutter/material.dart';

class AnimatedSwipePager extends StatefulWidget {
  const AnimatedSwipePager({
    required this.itemCount,
    required this.itemBuilder,
    this.initialPage = 0,
    this.onPageChanged,
    this.animationDuration = const Duration(milliseconds: 220),
    super.key,
  }) : assert(itemCount > 0),
       assert(initialPage >= 0);

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final int initialPage;
  final ValueChanged<int>? onPageChanged;
  final Duration animationDuration;

  @override
  State<AnimatedSwipePager> createState() => _AnimatedSwipePagerState();
}

class _AnimatedSwipePagerState extends State<AnimatedSwipePager>
    with SingleTickerProviderStateMixin {
  late int _selectedPage;
  double _dragOffset = 0;
  double _pageWidth = 1;
  double _settleStartOffset = 0;
  bool _isSettling = false;
  bool _isHorizontalDrag = false;
  double _horizontalScrollDistance = 0;
  late final AnimationController _settleController;

  @override
  void initState() {
    super.initState();
    _selectedPage = widget.initialPage.clamp(0, widget.itemCount - 1);
    _settleController =
        AnimationController(vsync: this, duration: widget.animationDuration)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed && mounted) {
              setState(() {
                _isSettling = false;
                _dragOffset = 0;
              });
            }
          });
  }

  @override
  void didUpdateWidget(covariant AnimatedSwipePager oldWidget) {
    super.didUpdateWidget(oldWidget);
    _settleController.duration = widget.animationDuration;
    final oldSelectedPage = _selectedPage;
    if (oldWidget.initialPage != widget.initialPage) {
      final requestedPage = widget.initialPage.clamp(0, widget.itemCount - 1);
      final pageDelta = requestedPage - _selectedPage;
      if (pageDelta != 0) {
        _selectedPage = requestedPage;
        _dragOffset = 0;
        _settleController.stop();
        _isSettling = pageDelta.abs() == 1;
        if (_isSettling) {
          _settleStartOffset = pageDelta > 0 ? _pageWidth : -_pageWidth;
          _settleController.forward(from: 0);
        }
      }
    } else if (oldWidget.itemCount != widget.itemCount) {
      _selectedPage = _selectedPage.clamp(0, widget.itemCount - 1);
    }
    if (_selectedPage != oldSelectedPage) {
      if (!_isSettling) {
        _dragOffset = 0;
        _settleController.stop();
      }
      final selectedPage = _selectedPage;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _selectedPage == selectedPage)
          widget.onPageChanged?.call(selectedPage);
      });
    }
  }

  @override
  void dispose() {
    _settleController.dispose();
    super.dispose();
  }

  void _prepareForDrag() {
    if (_isSettling) {
      _dragOffset = _settleStartOffset * (1 - _settleController.value);
      _settleController.stop();
    } else {
      _dragOffset = 0;
    }
    setState(() => _isSettling = false);
  }

  void _applyDragDelta(double delta) {
    final minOffset = _selectedPage < widget.itemCount - 1 ? -_pageWidth : 0.0;
    final maxOffset = _selectedPage > 0 ? _pageWidth : 0.0;
    setState(() {
      _dragOffset = (_dragOffset + delta).clamp(minOffset, maxOffset);
      _isHorizontalDrag = true;
    });
  }

  void _finishDrag() {
    _isHorizontalDrag = false;
    final crossedDistance = _dragOffset.abs() > _pageWidth * 0.25;
    var pageDelta = 0;
    if (crossedDistance) {
      pageDelta = _dragOffset < 0 ? 1 : -1;
      if (_selectedPage + pageDelta < 0 ||
          _selectedPage + pageDelta >= widget.itemCount) {
        pageDelta = 0;
      }
    }

    final startOffset = _dragOffset;
    if (pageDelta != 0) {
      _settleToPage(
        pageDelta,
        startOffset + (pageDelta > 0 ? _pageWidth : -_pageWidth),
      );
      return;
    }
    setState(() {
      _settleStartOffset = startOffset;
      _dragOffset = 0;
      _isSettling = true;
    });
    _settleController.forward(from: 0);
  }

  void _handlePointerSignal(PointerSignalEvent event) {
    if (event is! PointerScrollEvent) return;
    final delta = event.scrollDelta.dx;
    if (delta == 0) return;
    _horizontalScrollDistance += delta;
    if (_horizontalScrollDistance.abs() < 40) return;

    final pageDelta = _horizontalScrollDistance < 0 ? 1 : -1;
    _horizontalScrollDistance = 0;
    _settleToPage(pageDelta, pageDelta > 0 ? _pageWidth : -_pageWidth);
  }

  void _settleToPage(int pageDelta, double startOffset) {
    final nextPage = _selectedPage + pageDelta;
    if (nextPage < 0 || nextPage >= widget.itemCount) return;
    setState(() {
      _selectedPage = nextPage;
      _settleStartOffset = startOffset;
      _dragOffset = 0;
      _isSettling = true;
    });
    widget.onPageChanged?.call(nextPage);
    _settleController.forward(from: 0);
  }

  void _handleDragCancel() {
    if (_isHorizontalDrag) {
      _finishDrag();
      return;
    }
    if (_dragOffset == 0 || _isSettling) return;
    setState(() {
      _settleStartOffset = _dragOffset;
      _dragOffset = 0;
      _isSettling = true;
    });
    _settleController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      _pageWidth = constraints.maxWidth;
      final previousPage = _selectedPage - 1;
      final nextPage = _selectedPage + 1;
      final currentChild = widget.itemBuilder(context, _selectedPage);
      final previousChild = previousPage >= 0
          ? widget.itemBuilder(context, previousPage)
          : null;
      final nextChild = nextPage < widget.itemCount
          ? widget.itemBuilder(context, nextPage)
          : null;

      return Listener(
        behavior: HitTestBehavior.opaque,
        onPointerSignal: _handlePointerSignal,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragStart: (_) => _prepareForDrag(),
          onHorizontalDragUpdate: (details) =>
              _applyDragDelta(details.delta.dx),
          onHorizontalDragEnd: (_) => _finishDrag(),
          onHorizontalDragCancel: _handleDragCancel,
          child: AnimatedSize(
            duration: widget.animationDuration,
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: AnimatedBuilder(
              animation: _settleController,
              builder: (context, child) {
                final offset = _isSettling
                    ? _settleStartOffset * (1 - _settleController.value)
                    : _dragOffset;
                final adjacentChild = offset < 0 ? nextChild : previousChild;
                return SizedBox(
                  width: constraints.maxWidth,
                  child: ClipRect(
                    child: Stack(
                      alignment: Alignment.topLeft,
                      clipBehavior: Clip.hardEdge,
                      children: [
                        Transform.translate(
                          offset: Offset(offset, 0),
                          child: currentChild,
                        ),
                        if (offset != 0 && adjacentChild != null)
                          Transform.translate(
                            offset: Offset(
                              offset + (offset < 0 ? _pageWidth : -_pageWidth),
                              0,
                            ),
                            child: adjacentChild,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
