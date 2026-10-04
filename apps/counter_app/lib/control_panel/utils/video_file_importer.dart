// TOC:
// - ImportedVideoPickStatus: status for file pick/import flow
// - ImportedVideoPickResult: result payload for file pick/import flow
// - pickAndImportVideoFile: picks a video and copies it into app support storage
// - isManagedImportedVideoPath: identifies files managed by this feature
// - deleteManagedImportedVideo: deletes a previously imported managed file
// - deleteAllManagedImportedVideos: deletes all files in the imported videos directory

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

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

Future<ImportedVideoPickResult> pickAndImportVideoFile() async {
  final picker = ImagePicker();

  try {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile == null) {
      return const ImportedVideoPickResult.cancelled();
    }

    final importedPath = await _copyVideoIntoAppSupport(originalPath: pickedFile.path);
    return ImportedVideoPickResult.selected(importedPath);
  } catch (error) {
    if (error.toString().toLowerCase().contains('denied')) {
      debugPrint('Video picker permission denied: $error');
      return const ImportedVideoPickResult.permissionDenied();
    }
    rethrow;
  }
}

Future<String> _copyVideoIntoAppSupport({required String originalPath}) async {
  final appSupportDirectory = await getApplicationSupportDirectory();
  final importedVideosDirectory = Directory(path.join(appSupportDirectory.path, 'imported_videos'));

  if (!await importedVideosDirectory.exists()) {
    await importedVideosDirectory.create(recursive: true);
  }
  await deleteFilesInDir(importedVideosDirectory);

  final fileExtension = path.extension(originalPath);
  final fileId = const Uuid().v4();
  final importedFilePath = path.join(importedVideosDirectory.path, '$fileId$fileExtension');
  appkit.logInfo('[VideoFileImporter] Imported video to: $importedFilePath');

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

Future<void> deleteFilesInDir(Directory dir) async {
  try {
    if (!await dir.exists()) {
      return;
    }

    final entities = dir.listSync();
    for (final entity in entities) {
      if (entity is File) {
        try {
          await entity.delete();
        } catch (e) {
          // Ignore and continue with next file
        }
      }
    }
  } catch (e) {
    // Silently ignore directory-level errors
  }
}
