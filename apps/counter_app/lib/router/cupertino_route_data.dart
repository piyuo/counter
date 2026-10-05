import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

abstract class CupertinoRouteData extends GoRouteData {
  const CupertinoRouteData();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage<void>(
      key: state.pageKey,
      name: state.name,
      arguments: state.extra,
      child: build(context, state),
    );
  }
}
