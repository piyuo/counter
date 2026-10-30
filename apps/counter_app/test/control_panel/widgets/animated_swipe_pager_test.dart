// Animated swipe pager tests.
//
// Contents:
// - Drag, wheel, and trackpad paging
// - Page boundaries and item count changes

import 'package:counter_app/control_panel/widgets/animated_swipe_pager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _pager({int itemCount = 3, int initialPage = 0, ValueChanged<int>? onPageChanged}) {
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: SizedBox(
          width: 320,
          child: AnimatedSwipePager(
            itemCount: itemCount,
            initialPage: initialPage,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) => SizedBox(height: 120, child: Text('Page $index')),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('mouse drag follows the pointer and settles on the next page', (tester) async {
    final changedPages = <int>[];
    await tester.pumpWidget(_pager(onPageChanged: changedPages.add));

    final page = find.text('Page 0');
    final initialX = tester.getCenter(page).dx;
    final gesture = await tester.startGesture(tester.getCenter(page), kind: PointerDeviceKind.mouse);
    await gesture.moveBy(const Offset(-60, 0));
    await tester.pump();
    expect(tester.getCenter(page).dx, lessThan(initialX));

    await gesture.moveBy(const Offset(-240, 0));
    await gesture.up();
    await tester.pumpAndSettle();

    expect(find.text('Page 1'), findsOneWidget);
    expect(changedPages, [1]);
  });

  testWidgets('horizontal mouse scroll changes page', (tester) async {
    await tester.pumpWidget(_pager());
    await tester.sendEventToBinding(
      PointerScrollEvent(
        kind: PointerDeviceKind.mouse,
        position: tester.getCenter(find.text('Page 0')),
        scrollDelta: const Offset(-80, 0),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Page 1'), findsOneWidget);
  });

  testWidgets('trackpad pan follows movement and settles on the next page', (tester) async {
    await tester.pumpWidget(_pager());
    final page = find.text('Page 0');
    final center = tester.getCenter(page);
    final initialX = center.dx;
    await tester.sendEventToBinding(PointerPanZoomStartEvent(pointer: 12, position: center));
    await tester.sendEventToBinding(
      PointerPanZoomUpdateEvent(
        pointer: 12,
        position: center + const Offset(-60, 0),
        pan: const Offset(-60, 0),
        panDelta: const Offset(-60, 0),
      ),
    );
    await tester.pump();
    expect(tester.getCenter(page).dx, lessThan(initialX));

    await tester.sendEventToBinding(
      PointerPanZoomUpdateEvent(
        pointer: 12,
        position: center + const Offset(-300, 0),
        pan: const Offset(-300, 0),
        panDelta: const Offset(-240, 0),
      ),
    );
    await tester.sendEventToBinding(PointerPanZoomEndEvent(pointer: 12, position: center + const Offset(-300, 0)));
    await tester.pumpAndSettle();

    expect(find.text('Page 1'), findsOneWidget);
  });

  testWidgets('clamps the current page when item count shrinks', (tester) async {
    final changedPages = <int>[];
    var itemCount = 3;
    late StateSetter updateHarness;

    await tester.pumpWidget(
      StatefulBuilder(
        builder: (context, setState) {
          updateHarness = setState;
          return _pager(itemCount: itemCount, onPageChanged: changedPages.add);
        },
      ),
    );
    await tester.drag(find.text('Page 0'), const Offset(-300, 0));
    await tester.pumpAndSettle();
    await tester.drag(find.text('Page 1'), const Offset(-300, 0));
    await tester.pumpAndSettle();
    expect(find.text('Page 2'), findsOneWidget);

    updateHarness(() => itemCount = 2);
    await tester.pump();
    await tester.pump();

    expect(find.text('Page 1'), findsOneWidget);
    expect(changedPages.last, 1);
  });

  testWidgets('does not navigate beyond either page boundary', (tester) async {
    await tester.pumpWidget(_pager(initialPage: 0));
    await tester.drag(find.text('Page 0'), const Offset(300, 0));
    await tester.pumpAndSettle();
    expect(find.text('Page 0'), findsOneWidget);

    await tester.drag(find.text('Page 0'), const Offset(-300, 0));
    await tester.pumpAndSettle();
    await tester.drag(find.text('Page 1'), const Offset(-300, 0));
    await tester.pumpAndSettle();
    await tester.drag(find.text('Page 2'), const Offset(-300, 0));
    await tester.pumpAndSettle();
    expect(find.text('Page 2'), findsOneWidget);
  });
}
