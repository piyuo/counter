// Model: Detection (sealed union)
// Description: Records what was detected. JSON-serialisable; persisted in AppState.
// Variants:
//   - Detection.unspecified() — default before any detection
//   - Detection.human()       — a human was detected
//   - Detection.vehicle()     — a vehicle was detected

import 'package:freezed_annotation/freezed_annotation.dart';

part 'detection_type.freezed.dart';
part 'detection_type.g.dart';

@freezed
sealed class DetectionType with _$DetectionType {
  const DetectionType._();

  const factory DetectionType.human() = DetectionHuman;
  const factory DetectionType.vehicle() = DetectionVehicle;

  factory DetectionType.fromJson(Map<String, dynamic> json) => _$DetectionTypeFromJson(json);
}
