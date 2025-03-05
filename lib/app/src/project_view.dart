import 'package:counter/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'model/project.dart';
import 'model/video.dart';
import 'project_provider.dart';
import 'video_view.dart';

/// Project view show multiple video sources from project
class ProjectView extends StatelessWidget {
  const ProjectView({
    this.onProjectChanged,
    this.noProjectScreen,
    this.isSideLayout = false,
    super.key,
  });

  /// screen to show when no project opened
  final Widget? noProjectScreen;

  /// called when project settings changed, videoSource not null mean change is from one of the video source
  final void Function(Project, Video?)? onProjectChanged;

  /// check if the layout is side layout
  final bool isSideLayout;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectProvider>(builder: (context, projectProvider, child) {
      buildNoProject() {
        return noProjectScreen ?? const SizedBox.shrink();
      }

      /// calculate the preview alignment based on the device orientation and screen width
      AlignmentGeometry getPreviewAlignment(BuildContext context, double maxWidth) {
        if (projectProvider.deviceOrientation == null) {
          if (isSideLayout) {
            return Alignment.center;
          }

          Orientation orientation = MediaQuery.of(context).orientation;
          if (orientation == Orientation.portrait) {
            return Alignment.topCenter;
          }
          return Alignment.centerRight;
        }

        // if project is camera video source , orientation is locked to portrait
        if (projectProvider.isLockToPortrait) {
          switch (projectProvider.deviceOrientation) {
            case DeviceOrientation.portraitUp:
              return Alignment.topCenter;
            case DeviceOrientation.landscapeLeft:
              return Alignment.topCenter;
            case DeviceOrientation.landscapeRight:
              return Alignment.topCenter;
            default:
              return Alignment.center;
          }
        }

        switch (projectProvider.deviceOrientation) {
          case DeviceOrientation.portraitUp:
            return Alignment.topCenter;
          case DeviceOrientation.landscapeLeft:
            return Alignment.centerRight;
          case DeviceOrientation.landscapeRight:
            return Alignment.centerRight;
          default:
            return Alignment.center;
        }
      }

      buildProjectOpened(Project project) {
        return OrientationBuilder(
          builder: (context, orientation) => LayoutBuilder(
            builder: (context, constraints) {
              // Choose the video view based on the state.
              Widget videoContent;
              if (projectProvider.isLoading) {
                videoContent = Center(
                    child: CupertinoActivityIndicator(
                  radius: 48,
                ));
              } else if (projectProvider.videoProviders.isEmpty) {
                videoContent = Center(child: Text(context.l.project_view_no_videos));
              } else if (projectProvider.fullscreenVideoProvider != null) {
                videoContent = VideoView(
                  previewAlignment: getPreviewAlignment(context, constraints.maxWidth),
                  videoProvider: projectProvider.fullscreenVideoProvider!,
                  filter: projectProvider.project!.filter,
                );
              } else if (projectProvider.videoProviders.length == 1) {
                videoContent = VideoView(
                  previewAlignment: getPreviewAlignment(context, constraints.maxWidth),
                  videoProvider: projectProvider.videoProviders.first,
                  filter: projectProvider.project!.filter,
                );
              } else {
                videoContent = AdaptiveCameraPreviewGrid(
                  animationDuration: const Duration(milliseconds: 500),
                  animationCurve: Curves.fastOutSlowIn,
                  previews: projectProvider.videoProviders.map((videoProvider) {
                    return CameraPreviewHolder(
                      id: videoProvider.video.videoId,
                      preview: VideoView(
                        videoProvider: videoProvider,
                        title: videoProvider.video.videoName, // only show title when there are multiple sources
                        filter: projectProvider.project!.filter,
                      ),
                      width: videoProvider.mediaWidth,
                      height: videoProvider.mediaHeight,
                    );
                  }).toList(),
                );
              }

              // AnimatedSwitcher always exists to smoothly transition between states.
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return EnhancedScaleTransition(
                    animation: animation,
                    child: child,
                  );
                },
                // Use a key that changes with state to trigger the transition.
                child: Container(
                  key: ValueKey(projectProvider.fullscreenVideoProvider != null ? 'fullscreen' : 'normal'),
                  child: videoContent,
                ),
              );
            },
          ),
        );
      }

      return projectProvider.isProjectOpened
          ? Container(
              color: const Color.fromARGB(255, 12, 12, 14),
              key: const ValueKey<int>(1),
              child: buildProjectOpened(projectProvider.project!),
            )
          : Container(
              key: const ValueKey<int>(0),
              child: buildNoProject(),
            );
    });
  }
}

class AdaptiveCameraPreviewGrid extends StatefulWidget {
  final List<CameraPreviewHolder> previews;
  final Duration animationDuration;
  final Curve animationCurve;

  const AdaptiveCameraPreviewGrid({
    super.key,
    required this.previews,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  AdaptiveCameraPreviewGridState createState() => AdaptiveCameraPreviewGridState();
}

class AdaptiveCameraPreviewGridState extends State<AdaptiveCameraPreviewGrid> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _buildStackedGrid(constraints);
      },
    );
  }

  Widget _buildStackedGrid(BoxConstraints constraints) {
    if (widget.previews.isEmpty) return const SizedBox.shrink();

    final screenAspectRatio = constraints.maxWidth / constraints.maxHeight;
    final grid = _calculateOptimalGrid(widget.previews.length, screenAspectRatio);
    final itemWidth = constraints.maxWidth / grid.columns;
    final itemHeight = constraints.maxHeight / grid.rows;

    return Stack(
      children: widget.previews.asMap().entries.map((entry) {
        final index = entry.key;
        final preview = entry.value;

        final row = index ~/ grid.columns;
        final column = index % grid.columns;
        final isLastRow = row == grid.rows - 1;
        final isLastRowSingleItem = isLastRow && grid.lastRowItemCount == 1;

        // Calculate left and width
        double left = column * itemWidth;
        double width = itemWidth;

        // If it's the last row and there's only one item, let it occupy the entire row
        if (isLastRow && isLastRowSingleItem) {
          left = 0;
          width = constraints.maxWidth;
        }

        final top = row * itemHeight;
        final height = itemHeight;

        return AnimatedPositioned(
          key: ValueKey(preview.id),
          duration: widget.animationDuration,
          curve: widget.animationCurve,
          left: left,
          top: top,
          width: width,
          height: height,
          child: AspectRatio(
            aspectRatio: preview.aspectRatio,
            child: preview.preview,
          ),
        );
      }).toList(),
    );
  }

  GridDimensions _calculateOptimalGrid(int previewCount, double screenAspectRatio) {
    int columns = 1;
    int rows = previewCount;

    double minWastedSpace = double.infinity;

    for (int possibleColumns = 1; possibleColumns <= previewCount; possibleColumns++) {
      int possibleRows = (previewCount / possibleColumns).ceil();
      double gridAspectRatio = possibleColumns / possibleRows;

      double wastedSpace = (screenAspectRatio - gridAspectRatio).abs();
      if (wastedSpace < minWastedSpace) {
        minWastedSpace = wastedSpace;
        columns = possibleColumns;
        rows = possibleRows;
      }
    }

    final lastRowItemCount = previewCount % columns == 0 ? columns : previewCount % columns;

    return GridDimensions(rows, columns, lastRowItemCount);
  }
}

class GridDimensions {
  final int rows;
  final int columns;
  final int lastRowItemCount;

  GridDimensions(this.rows, this.columns, this.lastRowItemCount);
}

class EnhancedScaleTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const EnhancedScaleTransition({
    required this.child,
    required this.animation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Create a more dramatic scaling animation.
    final scaleAnimation = Tween<double>(
      begin: 0.8, // Start with a smaller size.
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animation,
        // Use easeOutBack to create an elastic effect.
        curve: Curves.easeOutBack,
        // Adjust the animation duration as needed to match the elastic effect.
      ),
    );

    return ScaleTransition(
      scale: scaleAnimation,
      child: child,
    );
  }
}
