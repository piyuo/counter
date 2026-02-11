import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_lifecycle.freezed.dart';

@freezed
sealed class AppLifecycle with _$AppLifecycle {
  const factory AppLifecycle.booting() = Booting;
  const factory AppLifecycle.checkingHardware() = CheckingHardware;
  const factory AppLifecycle.needsOnboarding() = NeedsOnboarding;
  const factory AppLifecycle.noCamera() = NoCamera;
  const factory AppLifecycle.ready() = Ready;
  const factory AppLifecycle.background() = Background;
  const factory AppLifecycle.suspended() = Suspended;
  const factory AppLifecycle.rebooting() = Rebooting;
  const factory AppLifecycle.error(String message) = Error;
}
