import 'package:flutter/cupertino.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:provider/provider.dart';

import 'video_provider.dart';

/// video view for each video source
class VideoView extends StatelessWidget {
  const VideoView({required this.videoProvider, this.previewAlignment = Alignment.center, this.title, super.key});

  /// the video source provider
  final VideoProvider videoProvider;

  /// The alignment geometry for the preview.
  final AlignmentGeometry previewAlignment;

  /// the title of the video source
  final String? title;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<VideoProvider>.value(value: videoProvider)],
      child: Consumer<VideoProvider>(
        builder: (context, videoProvider, child) {
          return Stack(
            children: [
              vision.Preview(),
              if (title != null)
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  //add round corner
                  decoration: BoxDecoration(
                    color: CupertinoColors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(title!),
                ),
            ],
          );
        },
      ),
    );
  }
}

/// A data model representing a camera preview. It holds the preview widget and its dimensions.
@immutable
class CameraPreviewHolder {
  /// Unique identifier for the camera preview.
  final int id;

  /// The preview widget displayed to the user.
  final Widget preview;

  /// The width of the preview in pixels.
  final int width;

  /// The height of the preview in pixels.
  final int height;

  const CameraPreviewHolder({required this.id, required this.preview, required this.width, required this.height});

  /// Returns the aspect ratio (width ÷ height) for this preview.
  double get aspectRatio => width / height;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is CameraPreviewHolder && runtimeType == other.runtimeType && id == other.id);

  @override
  int get hashCode => id.hashCode;
}
