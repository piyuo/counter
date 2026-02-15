//
// Generated file. Do not edit.
//

// ignore_for_file: directives_ordering
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
//import 'package:mobile_scanner/mobile_scanner_web_plugin.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';
//import 'package:smart_auth/smart_auth_web.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  ImagePickerPlugin.registerWith(registrar);
  //MobileScannerWebPlugin.registerWith(registrar);
  SharedPreferencesPlugin.registerWith(registrar);
  //SmartAuthWeb.registerWith(registrar);
  registrar.registerMessageHandler();
}
