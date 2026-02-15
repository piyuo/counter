// ignore_for_file: unintended_html_in_doc_comment
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/// macos need add this to DebugProfile.entitlements
/// <key>com.apple.security.files.user-selected.read-only</key>
///	<true/>

/// return picked video file path or null if user cancel
Future<String?> pickVideo() async {
  final picker = ImagePicker();
  try {
    XFile? picked = await picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (picked == null) {
      return null;
    }
    return picked.path;
  } catch (e) {
    if (e.toString().contains('denied')) {
      debugPrint('Permission denied: $e');
      return 'denied';
    }
    rethrow;
  }
}

/// save file to app directory, this make sure the file is accessible in the app sandbox.
/// beware that it is caller's responsibility to delete the file when it is no longer needed.
Future<String> saveFileToAppDirectory(String originalPath, String projectId, int videoId) async {
  final appDir = await getApplicationSupportDirectory();
  final projectDir = Directory('${appDir.path}/$projectId');

  // Create the project subdirectory if it doesn't exist.
  if (!await projectDir.exists()) {
    await projectDir.create(recursive: true);
  }

  // Get the original file extension (includes the dot, e.g., ".mp4").
  final ext = path.extension(originalPath);

  // Build the new path using the new videoId and original extension.
  final filePath = '$projectId/$videoId$ext';
  final fileFullPath = '${appDir.path}/$filePath';
  final file = File(fileFullPath);

  // If a file already exists at the destination, delete it.
  if (await file.exists()) {
    await file.delete();
  }

  final sourceFile = File(originalPath);
  await sourceFile.copy(fileFullPath);
  return filePath;
}

// delete file that return by saveFileToAppDirectory
Future<void> deleteFileFromAppDirectory(String path) async {
  final file = File(path);
  if (await file.exists()) {
    await file.delete();
  }
}
