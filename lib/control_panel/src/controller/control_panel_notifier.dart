import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'control_panel_state.dart';

part 'control_panel_notifier.g.dart';

@riverpod
class ControlPanelNotifier extends _$ControlPanelNotifier {
  @override
  ControlPanelState build() {
    ref.onDispose(() {});
    return const ControlPanelState();
  }
}
