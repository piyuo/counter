// Model: AvailableCamera
// Description: A user-selectable camera source with a stable app-level identifier.
// Fields:
//   - videoSource: typed source identifier used by the app runtime
//   - displayName: human-readable label for UI lists

import 'package:core_domain/state/models/video_source.dart';

class AvailableCamera {
  const AvailableCamera({required this.videoSource, required this.displayName});

  final VideoSource videoSource;
  final String displayName;
}
