import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/core_runtime.dart' as core_runtime;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;

class InterestAreasScreen extends ConsumerWidget {
  const InterestAreasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(core_domain.appProvider).asData?.value;
    if (appState == null) {
      return const SizedBox.shrink();
    }
    final areaState = ref.watch(core_runtime.interestAreaProvider);
    final canAddArea = areaState.areas.length < core_runtime.InterestAreaNotifier.maxEditingAreas;
    final canRemoveArea = areaState.selectedAreaId != null;
    final canAddPoint = areaState.selectedAreaId != null;
    final canRemovePoint = areaState.selectedPointIndex != null;

    return PopScope(
      onPopInvokedWithResult: (bool didPop, result) async {
        final areaState = ref.read(core_runtime.interestAreaProvider);
        if (!areaState.isEditing) {
          return;
        }
        final areas = ref.read(core_runtime.interestAreaProvider.notifier).finishEditing();
        final appController = ref.read(core_domain.appProvider.notifier);
        unawaited(appController.saveInterestAreaDatas(areas));

        // If pop hasn't happened yet, manually trigger it
        if (!didPop && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: feature_pip.PipScaffold(
        title: context.l.main_screen_interest_areas,
        builder: (scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(context.l.interest_areas_screen_help),
              ),
              feature_pip.PipPanel(
                child: Column(
                  children: [
                    // Add new interest area
                    ListTile(
                      enabled: canAddArea,
                      leading: Icon(Icons.add),
                      title: Text(context.l.interest_areas_screen_add_area),
                      subtitle: Text(context.l.interest_areas_screen_add_area_tip),
                      trailing: const SizedBox.shrink(),
                      onTap: () {
                        final visionState = ref.read(vision.visionProvider);
                        final videoWidth = visionState.videoWidth;
                        final videoHeight = visionState.videoHeight;
                        final areaNotifier = ref.read(core_runtime.interestAreaProvider.notifier);
                        areaNotifier.newArea(videoWidth, videoHeight);
                      },
                    ),
                    // remove interest area
                    ListTile(
                      enabled: canRemoveArea,
                      leading: Icon(Icons.remove),
                      title: Text(context.l.interest_areas_screen_remove_area),
                      subtitle: Text(context.l.interest_areas_screen_remove_area_tip),
                      trailing: const SizedBox.shrink(),
                      onTap: !canRemoveArea
                          ? null
                          : () {
                              ref.read(core_runtime.interestAreaProvider.notifier).removeSelectedArea();
                            },
                    ),
                  ],
                ),
              ),
              feature_pip.PipPanel(
                child: Column(
                  children: [
                    ListTile(
                      enabled: canAddPoint,
                      leading: Icon(Icons.add_circle_outline),
                      title: Text(context.l.interest_areas_screen_add_point),
                      subtitle: Text(context.l.interest_areas_screen_add_point_tip),
                      trailing: const SizedBox.shrink(),
                      onTap: !canAddPoint
                          ? null
                          : () {
                              ref.read(core_runtime.interestAreaProvider.notifier).addPointToArea();
                            },
                    ),
                    ListTile(
                      enabled: canRemovePoint,
                      leading: Icon(Icons.remove_circle_outline),
                      title: Text(context.l.interest_areas_screen_remove_point),
                      subtitle: Text(context.l.interest_areas_screen_remove_point_tip),
                      trailing: const SizedBox.shrink(),
                      onTap: !canRemovePoint
                          ? null
                          : () {
                              ref.read(core_runtime.interestAreaProvider.notifier).removeSelectedPoint();
                            },
                    ),
                  ],
                ),
              ),
              feature_pip.PipPanel(
                child: Column(
                  children: [
                    ListTile(
                      enabled: canAddPoint,
                      leading: Icon(Icons.restore),
                      title: Text(context.l.interest_areas_screen_reset),
                      subtitle: Text(context.l.interest_areas_screen_reset_tip),
                      trailing: const SizedBox.shrink(),
                      onTap: () async {
                        final confirmed = await appkit.showConfirm(
                          title: context.l.interest_areas_screen_reset,
                          message: context.l.interest_areas_screen_reset_confirm,
                        );
                        if (confirmed != true) return;
                        ref.read(core_runtime.interestAreaProvider.notifier).reset();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
