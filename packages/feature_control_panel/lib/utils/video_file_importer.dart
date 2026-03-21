// TOC:
// - ImportedVideoPickStatus: status for file pick/import flow
// - ImportedVideoPickResult: result payload for file pick/import flow
// - pickAndImportVideoFile: picks a video and copies it into app support storage
// - isManagedImportedVideoPath: identifies files managed by this feature
// - deleteManagedImportedVideo: deletes a previously imported managed file

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

enum ImportedVideoPickStatus { selected, cancelled, permissionDenied }

class ImportedVideoPickResult {
  const ImportedVideoPickResult._({required this.status, this.importedFilePath});

  const ImportedVideoPickResult.selected(String importedFilePath)
    : this._(status: ImportedVideoPickStatus.selected, importedFilePath: importedFilePath);

  const ImportedVideoPickResult.cancelled() : this._(status: ImportedVideoPickStatus.cancelled);

  const ImportedVideoPickResult.permissionDenied() : this._(status: ImportedVideoPickStatus.permissionDenied);

  final ImportedVideoPickStatus status;
  final String? importedFilePath;
}

Future<ImportedVideoPickResult> pickAndImportVideoFile({required String projectId, required int videoId}) async {
  final picker = ImagePicker();

  try {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile == null) {
      return const ImportedVideoPickResult.cancelled();
    }

    final importedPath = await _copyVideoIntoAppSupport(
      originalPath: pickedFile.path,
      projectId: projectId,
      videoId: videoId,
    );
    return ImportedVideoPickResult.selected(importedPath);
  } catch (error) {
    if (error.toString().toLowerCase().contains('denied')) {
      debugPrint('Video picker permission denied: $error');
      return const ImportedVideoPickResult.permissionDenied();
    }
    rethrow;
  }
}

Future<String> _copyVideoIntoAppSupport({
  required String originalPath,
  required String projectId,
  required int videoId,
}) async {
  final appSupportDirectory = await getApplicationSupportDirectory();
  final importedVideosDirectory = Directory(path.join(appSupportDirectory.path, 'imported_videos', projectId));

  if (!await importedVideosDirectory.exists()) {
    await importedVideosDirectory.create(recursive: true);
  }

  final fileExtension = path.extension(originalPath);
  final importedFilePath = path.join(importedVideosDirectory.path, '$videoId$fileExtension');

  final importedFile = File(importedFilePath);
  if (await importedFile.exists()) {
    await importedFile.delete();
  }

  await File(originalPath).copy(importedFilePath);
  return importedFilePath;
}

Future<bool> isManagedImportedVideoPath(String filePath) async {
  final appSupportDirectory = await getApplicationSupportDirectory();
  final managedRoot = path.join(appSupportDirectory.path, 'imported_videos');
  return path.isWithin(managedRoot, filePath) || path.equals(managedRoot, filePath);
}

Future<void> deleteManagedImportedVideo(String filePath) async {
  if (!await isManagedImportedVideoPath(filePath)) {
    return;
  }

  final file = File(filePath);
  if (await file.exists()) {
    await file.delete();
  }
}
