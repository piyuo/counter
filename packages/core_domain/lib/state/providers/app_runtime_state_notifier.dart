import 'package:core_domain/state/models/app_runtime_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_runtime_state_notifier.g.dart';

abstract class AppRuntimeStateController {}

@Riverpod(keepAlive: true)
class AppRuntimeStateNotifier extends _$AppRuntimeStateNotifier implements AppRuntimeStateController {
  @override
  AppRuntimeState build() {
    return AppRuntimeState();
  }
}
