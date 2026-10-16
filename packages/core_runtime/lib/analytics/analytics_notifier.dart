import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_notifier.g.dart';

@Riverpod(keepAlive: true)
class AnalyticsNotifier extends _$AnalyticsNotifier implements core_domain.AnalyticsService {
  @override
  core_domain.AnalyticsState build() {
    ref.onDispose(() {});

    return const core_domain.AnalyticsState();
  }

  @override
  Future<void> add(core_domain.Observation observation) async {
    // TODO: implement add observation
  }
}
