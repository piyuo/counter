// TOC:
//  - RootRouteData: typed route for '/' (boot/loading screen)
//  - StartRouteData: typed route for '/start'
//  - AboutRouteData: typed route for '/about'
//  - SettingsPiyuoRouteData: typed route for '/settings/piyuo'
//  - SettingsServerRouteData: typed route for '/settings/server'
//  - BuildInfoRouteData: typed route for '/build-info'
//  - DetectionRouteData: typed route for '/detection'
//  - DeliveryConfigRouteData: typed route for '/delivery-config'
//  - UploadLogsRouteData: typed route for '/upload-logs'
//  - UploadLogDetailRouteData: typed route for '/upload-logs/detail/:attemptedAtMs/:successFlag'
//  - RecentPayloadsRouteData: typed route for '/recent-payloads'
//  - RecentPayloadHourRouteData: typed route for '/recent-payloads/hour/:slotMs'
//  - RecentPayloadDetailRouteData: typed route for '/recent-payloads/payload/:payloadId'
//  - LanguageRouteData: typed route for '/language'
//  - LiveUrlRouteData: typed route for '/live-url'
//  - VideoSourcesRouteData: typed route for '/video-sources'
//  - NoCameraRouteData: typed route for '/live-stream-only'
//
// Architecture note:
//  - Annotated with @TypedGoRoute for go_router_builder code generation.
//  - Run `dart run build_runner build` to regenerate control_panel_route_data.g.dart.
//  - Paths are the single source of truth; ControlPanelRoutes only keeps root/start/liveStreamOnly.

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/app_shell/device_not_supported_screen.dart';
import 'package:feature_control_panel/screens/about_screen.dart';
import 'package:feature_control_panel/screens/build_info_screen.dart';
import 'package:feature_control_panel/screens/custom_server_screen.dart';
import 'package:feature_control_panel/screens/detection_screen.dart';
import 'package:feature_control_panel/screens/language_screen.dart';
import 'package:feature_control_panel/screens/loading_screen.dart';
import 'package:feature_control_panel/screens/payload_detail_screen.dart';
import 'package:feature_control_panel/screens/payloads_hour_screen.dart';
import 'package:feature_control_panel/screens/payloads_recent_screen.dart';
import 'package:feature_control_panel/screens/piyuo_server_screen.dart';
import 'package:feature_control_panel/screens/settings_screen.dart';
import 'package:feature_control_panel/screens/start_screen.dart';
import 'package:feature_control_panel/screens/target_screen.dart';
import 'package:feature_control_panel/screens/upload_detail_screen.dart';
import 'package:feature_control_panel/screens/upload_logs_screen.dart';
import 'package:feature_control_panel/screens/url_screen.dart';
import 'package:feature_control_panel/screens/video_sources_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/local_only_screen.dart';

part 'control_panel_route_data.g.dart';

@TypedGoRoute<LoadingRouteData>(path: '/')
class LoadingRouteData extends GoRouteData with $LoadingRouteData {
  const LoadingRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoadingScreen();
}

@TypedGoRoute<StartRouteData>(path: '/start')
class StartRouteData extends GoRouteData with $StartRouteData {
  const StartRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const StartScreen();
}

@TypedGoRoute<SettingsRouteData>(path: '/settings')
class SettingsRouteData extends GoRouteData with $SettingsRouteData {
  const SettingsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SettingsScreen();
}

@TypedGoRoute<SettingsPiyuoRouteData>(path: '/settings/piyuo')
class SettingsPiyuoRouteData extends GoRouteData with $SettingsPiyuoRouteData {
  const SettingsPiyuoRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const PiyuoServerScreen();
}

@TypedGoRoute<SettingsServerRouteData>(path: '/settings/server')
class SettingsServerRouteData extends GoRouteData with $SettingsServerRouteData {
  const SettingsServerRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const CustomServerScreen();
}

@TypedGoRoute<SettingsLocalRouteData>(path: '/settings/local')
class SettingsLocalRouteData extends GoRouteData with $SettingsLocalRouteData {
  const SettingsLocalRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LocalOnlyScreen();
}

@TypedGoRoute<AboutRouteData>(path: '/about')
class AboutRouteData extends GoRouteData with $AboutRouteData {
  const AboutRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const AboutScreen();
}

@TypedGoRoute<BuildInfoRouteData>(path: '/build-info')
class BuildInfoRouteData extends GoRouteData with $BuildInfoRouteData {
  const BuildInfoRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const BuildInfoScreen();
}

@TypedGoRoute<DetectionRouteData>(path: '/detection')
class DetectionRouteData extends GoRouteData with $DetectionRouteData {
  const DetectionRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const DetectionParamsScreen();
}

@TypedGoRoute<TargetRouteData>(path: '/target')
class TargetRouteData extends GoRouteData with $TargetRouteData {
  const TargetRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const TargetScreen();
}

@TypedGoRoute<UploadLogsRouteData>(path: '/upload-logs')
class UploadLogsRouteData extends GoRouteData with $UploadLogsRouteData {
  const UploadLogsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const UploadLogsScreen();
}

@TypedGoRoute<UploadLogDetailRouteData>(path: '/upload-logs/detail/:attemptedAtMs/:successFlag')
class UploadLogDetailRouteData extends GoRouteData with $UploadLogDetailRouteData {
  const UploadLogDetailRouteData({required this.attemptedAtMs, required this.successFlag});

  final int attemptedAtMs;
  final int successFlag;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final log = state.extra is core_domain.UploadLog ? state.extra as core_domain.UploadLog : null;
    return UploadDetailScreen(attemptedAtMs: attemptedAtMs, success: successFlag == 1, log: log);
  }
}

@TypedGoRoute<RecentPayloadsRouteData>(path: '/recent-payloads')
class RecentPayloadsRouteData extends GoRouteData with $RecentPayloadsRouteData {
  const RecentPayloadsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const PayloadsRecentScreen();
}

@TypedGoRoute<RecentPayloadHourRouteData>(path: '/recent-payloads/hour/:slotMs')
class RecentPayloadHourRouteData extends GoRouteData with $RecentPayloadHourRouteData {
  const RecentPayloadHourRouteData({required this.slotMs});

  final int slotMs;

  @override
  Widget build(BuildContext context, GoRouterState state) => PayloadsHourScreen(slotMs: slotMs);
}

@TypedGoRoute<RecentPayloadDetailRouteData>(path: '/recent-payloads/payload/:payloadId')
class RecentPayloadDetailRouteData extends GoRouteData with $RecentPayloadDetailRouteData {
  const RecentPayloadDetailRouteData({required this.payloadId});

  final String payloadId;

  @override
  Widget build(BuildContext context, GoRouterState state) => PayloadDetailScreen(payloadId: payloadId);
}

@TypedGoRoute<LanguageRouteData>(path: '/language')
class LanguageRouteData extends GoRouteData with $LanguageRouteData {
  const LanguageRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LanguageScreen();
}

@TypedGoRoute<LiveUrlRouteData>(path: '/live-url')
class LiveUrlRouteData extends GoRouteData with $LiveUrlRouteData {
  const LiveUrlRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const UrlScreen();
}

@TypedGoRoute<VideoSourcesRouteData>(path: '/video-sources')
class VideoSourcesRouteData extends GoRouteData with $VideoSourcesRouteData {
  const VideoSourcesRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const VideoSourcesScreen();
}

@TypedGoRoute<DeviceNotSupportedRouteData>(path: '/device-not-supported')
class DeviceNotSupportedRouteData extends GoRouteData with $DeviceNotSupportedRouteData {
  const DeviceNotSupportedRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) => const DeviceNotSupportedScreen();
}
