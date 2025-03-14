import 'package:flutter/material.dart';

final GlobalKey<_GlobalContextSupportState> _keyGlobalContextFinder = GlobalKey(debugLabel: 'global_context_support');

BuildContext get globalContext {
  assert(
    _debugInitialized,
    'Global Context Support Not Initialized ! \n'
    'ensure your app wrapped widget GlobalContextSupport()',
  );
  final state = _keyGlobalContextFinder.currentState;
  assert(() {
    if (state == null) {
      throw FlutterError('''we can not find GlobalContextSupportState in your app.

         do you declare GlobalContextSupport you app widget tree like this?

         GlobalContextSupport(
           child: MaterialApp(
             home: HomePage(),
           ),
         )

      ''');
    }
    return true;
  }());
  return state!.overlayState!.context;
}

bool _debugInitialized = false;

class GlobalContextSupport extends StatelessWidget {
  final Widget child;

  const GlobalContextSupport({
    super.key,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return _GlobalContextSupport(child: child);
  }
}

class _GlobalContextSupport extends StatefulWidget {
  final Widget child;

  _GlobalContextSupport({required this.child}) : super(key: _keyGlobalContextFinder);

  @override
  StatefulElement createElement() {
    _debugInitialized = true;
    return super.createElement();
  }

  @override
  _GlobalContextSupportState createState() => _GlobalContextSupportState();
}

class _GlobalContextSupportState extends State<_GlobalContextSupport> {
  @override
  Widget build(BuildContext context) {
    assert(() {
      if (context.findAncestorWidgetOfExactType<_GlobalContextSupport>() != null) {
        throw FlutterError('There is already an GlobalContextSupport in the Widget tree.');
      }
      return true;
    }());
    return widget.child;
  }

  OverlayState? get overlayState {
    NavigatorState? navigator;
    void visitor(Element element) {
      if (navigator != null) return;

      if (element.widget is Navigator) {
        navigator = (element as StatefulElement).state as NavigatorState?;
      } else {
        element.visitChildElements(visitor);
      }
    }

    context.visitChildElements(visitor);

    assert(navigator != null, '''It looks like you are not using Navigator in your app.

         do you wrapped you app widget like this?

         GlobalContextSupport(
           child: MaterialApp(
             home: HomePage(),
           ),
         )

      ''');
    return navigator?.overlay;
  }
}
