import 'package:freezed_annotation/freezed_annotation.dart';

part 'lifecycle.freezed.dart';

@freezed
sealed class Lifecycle with _$Lifecycle {
  const factory Lifecycle.booting() = Booting;
  const factory Lifecycle.checkingHardware() = CheckingHardware;
  const factory Lifecycle.needsOnboarding() = NeedsOnboarding;
  const factory Lifecycle.noCamera() = NoCamera;
  const factory Lifecycle.ready() = Ready;
  const factory Lifecycle.background() = Background;
  const factory Lifecycle.suspended() = Suspended;
  const factory Lifecycle.rebooting() = Rebooting;
  const factory Lifecycle.error(String message) = Error;
}
