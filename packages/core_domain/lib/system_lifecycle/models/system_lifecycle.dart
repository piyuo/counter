import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_lifecycle.freezed.dart';

/// Represents the high-level operational state of the system hardware and core services.
@freezed
sealed class SystemLifecycle with _$SystemLifecycle {
  /// The system is in its chaotic boot phase.
  const factory SystemLifecycle.booting() = Booting;

  /// The system is actively performing hardware verification.
  const factory SystemLifecycle.checkingHardware() = CheckingHardware;

  /// The system is operating in a degraded state (no camera, stream only).
  const factory SystemLifecycle.liveStreamOnly() = LiveStreamOnly;

  /// The system is fully initialized and operational.
  const factory SystemLifecycle.systemReady() = SystemReady;

  /// The system has encountered a fatal error during lifecycle transitions.
  const factory SystemLifecycle.systemError(String message) = SystemError;
}
