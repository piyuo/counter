import 'package:counter/app/app.dart' as app;
import 'package:flutter/material.dart';
import 'package:vision/vision.dart' as vision;

import 'meta/annotation_meta.dart';
import 'meta/camera_meta.dart';
import 'meta/filter_meta.dart';
import 'meta/point_meta.dart';
import 'meta/project_meta.dart';
import 'meta/time_of_day_meta.dart';
import 'meta/video_meta.dart';
import 'meta/webcam_meta.dart';
import 'meta/zone_meta.dart';

/// Converts a app project to meta object that can be stored in the database.
ProjectMeta projectToMeta(app.Project project) {
  return ProjectMeta(
    projectId: project.projectId,
    projectName: project.projectName,
    videos: project.videos
        .map((video) => VideoMeta(
              videoId: video.videoId,
              mediaType: video.mediaType,
              videoName: video.videoName,
              path: video.path,
              camera: video.camera != null
                  ? CameraMeta(
                      name: video.camera!.name,
                      title: video.camera!.title,
                      isFront: video.camera!.isFrontCamera,
                    )
                  : null,
              webcam: video.webcam != null ? WebcamMeta(index: video.webcam!.index, name: video.webcam!.name) : null,
              confidence: video.confidenceThreshold,
              nms: video.nmsThreshold,
              match: video.matchThreshold,
              minLostSeconds: video.minLostSeconds,
              maxLostSeconds: video.maxLostSeconds,
              valid: video.validThreshold,
              tracking: video.trackingThreshold,
              model: video.model,
              objectClasses: video.objectClasses,
              zoom: video.zoom,
              zones: video.zones
                  .map((zone) => ZoneMeta(
                        zoneId: zone.zoneId,
                        showSummaryOnScreen: zone.showSummaryOnScreen,
                        zoneName: zone.name,
                        annotations: zone.tallyAnnotations
                            .map((annotation) => AnnotationMeta(
                                  type: annotation.type,
                                  enabled: annotation.enabled,
                                  title: annotation.title,
                                  prefix: annotation.prefix,
                                  suffix: annotation.suffix,
                                ))
                            .toList(),
                        points: zone.points.map((point) => PointMeta(x: point.dx, y: point.dy)).toList(),
                        pointIndex: zone.selectedPointIndex,
                        color: zone.color,
                        stagnant: zone.stagnantThreshold,
                        reentered: zone.reenteredThreshold,
                        crossedZones: zone.crossedZonesThreshold,
                        cooldown: zone.cooldownThreshold,
                        ignoreIfCounted: zone.ignoreIfCounted,
                      ))
                  .toList(),
            ))
        .toList(),
    filter: FilterMeta(
      filterType: project.filter.filterType,
      start: TimeOfDayMeta(hour: project.filter.start.hour, minute: project.filter.start.minute),
      end: TimeOfDayMeta(hour: project.filter.end.hour, minute: project.filter.end.minute),
    ),
    isShowCenterRedDotOnTarget: project.isShowCenterRedDotOnTarget,
    isShowGhostTarget: project.isShowGhostTarget,
  );
}

/// Converts a app project to meta object that can be stored in the database.
app.Project metaToProject(ProjectMeta meta) {
  final project = app.Project(
    projectId: meta.projectId,
    projectName: meta.projectName,
    videos: meta.videos
        .map(
          (video) => app.Video(
            videoId: video.videoId,
            mediaType: video.mediaType,
            videoName: video.videoName,
            path: video.path,
            camera: video.camera != null
                ? app.CameraDefine(
                    name: video.camera!.name,
                    title: video.camera!.title,
                    isFrontCamera: video.camera!.isFront,
                  )
                : null,
            webcam:
                video.webcam != null ? app.WebcamDefine(index: video.webcam!.index, name: video.webcam!.name) : null,
            confidenceThreshold: video.confidence,
            nmsThreshold: video.nms,
            matchThreshold: video.match,
            maxLostSeconds: video.maxLostSeconds,
            validThreshold: video.valid,
            trackingThreshold: video.tracking,
            model: video.model,
            objectClasses: List.from(video.objectClasses),
            zoom: video.zoom,
            zones: video.zones
                .map((zone) => vision.VideoZone(
                      zoneId: zone.zoneId,
                      showSummaryOnScreen: zone.showSummaryOnScreen,
                      name: zone.zoneName,
                      tallyAnnotations: zone.annotations
                          .map((annotation) => vision.TallyAnnotation(
                                type: annotation.type,
                                enabled: annotation.enabled,
                                title: annotation.title,
                                prefix: annotation.prefix,
                                suffix: annotation.suffix,
                              ))
                          .toList(),
                      points: zone.points.map((point) => Offset(point.x, point.y)).toList(),
                      selectedPointIndex: zone.pointIndex,
                      color: zone.color,
                      stagnantThreshold: zone.stagnant,
                      reenteredThreshold: zone.reentered,
                      crossedZonesThreshold: zone.crossedZones,
                      cooldownThreshold: zone.cooldown,
                      ignoreIfCounted: zone.ignoreIfCounted,
                    ))
                .toList(),
          ),
        )
        .toList(),
    filter: vision.Filter(
      meta.filter.filterType,
      start: TimeOfDay(hour: meta.filter.start.hour, minute: meta.filter.start.minute),
      end: TimeOfDay(hour: meta.filter.end.hour, minute: meta.filter.end.minute),
    ),
    isShowCenterRedDotOnTarget: meta.isShowCenterRedDotOnTarget,
    isShowGhostTarget: meta.isShowGhostTarget,
  );
  return project;
}
