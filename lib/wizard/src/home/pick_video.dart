// ignore_for_file: unintended_html_in_doc_comment

import 'dart:async';

import 'package:image_picker/image_picker.dart';

/// macos need add this to DebugProfile.entitlements
/// <key>com.apple.security.files.user-selected.read-only</key>
///	<true/>

/// return picked video file path or null if user cancel
Future<String?> pickVideo() async {
  final picker = ImagePicker();
  XFile? picked = await picker.pickVideo(
    source: ImageSource.gallery,
  );
  if (picked == null) {
    return null;
  }
  return picked.path;
}
