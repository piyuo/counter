import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/core_runtime.dart' as core_runtime;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_notifier.g.dart';

@Riverpod(keepAlive: true)
class DashboardNotifier extends _$DashboardNotifier implements core_domain.DashboardService {
  final core_domain.DashboardCache _cache = core_domain.DashboardCache();

  @override
  core_domain.DashboardState build() {
    final timer = Timer.periodic(const Duration(seconds: 1), (_) => _refresh());

    ref.onDispose(() {
      timer.cancel();
      _cache.dispose();
    });

    return _calculate();
  }

  // refresh update every second
  void _refresh() {
    state = _calculate();
  }

  core_domain.DashboardState _calculate() {
    final insightState = ref.read(core_domain.insightStateProvider);
    final appState = ref.read(core_domain.appProvider).asData?.value;
    final configuredAreas = ref.read(core_runtime.interestAreaProvider).areas;

    final areas = _cache.build(
      insightState: insightState,
      customAreas: configuredAreas,
      businessPeriods: appState?.businessPeriods ?? core_domain.BusinessPeriod.defaultSchedule,
      now: DateTime.now(),
    );
    return core_domain.DashboardState(areas: areas);
  }

  @override
  core_domain.DashboardCardData? findCard(int areaId, core_domain.DashboardMetric metric) {
    for (final area in state.areas) {
      if (area.areaId != areaId) continue;
      for (final card in area.cards) {
        if (card.metric == metric) return card;
      }
      return null;
    }
    return null;
  }
}
