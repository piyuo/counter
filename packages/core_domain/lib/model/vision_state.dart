import 'package:freezed_annotation/freezed_annotation.dart';

part 'vision_state.freezed.dart';

@freezed
class VisionState with _$VisionState {
  const VisionState({this.startTime});

  /// The start time of the vision session. null if the session has not started.
  final DateTime? startTime;
}
