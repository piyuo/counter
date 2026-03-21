// TOC:
//  - DummyRouteData: typed route for the root/dummy screen
//  - VisionRouteData: typed route for the vision screen
//
// Architecture note:
//  - Annotated with @TypedGoRoute for go_router_builder code generation.
//  - Run `dart run build_runner build` to regenerate monitor_route_data.g.dart.
//  - Path constants mirror MonitorRoutes to keep a single source of truth.

import 'package:feature_monitor/screens/dummy_screen.dart';
import 'package:feature_monitor/screens/vision_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'monitor_route_data.g.dart';

@TypedGoRoute<DummyRouteData>(path: '/')
class DummyRouteData extends GoRouteData with $DummyRouteData {
  const DummyRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const DummyScreen();
}

@TypedGoRoute<VisionRouteData>(path: '/vision')
class VisionRouteData extends GoRouteData with $VisionRouteData {
  const VisionRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const VisionScreen();
}
