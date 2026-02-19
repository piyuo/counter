// TOC:
//  - ControlPanelRoutes path constant values

import 'package:core_domain/navigation/control_panel_routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ControlPanelRoutes', () {
    test('root is "/"', () => expect(ControlPanelRoutes.root, '/'));
    test('liveStreamOnly is "/live-stream-only"', () => expect(ControlPanelRoutes.liveStreamOnly, '/live-stream-only'));
    test('settings is "/settings"', () => expect(ControlPanelRoutes.settings, '/settings'));
    test('about is "/about"', () => expect(ControlPanelRoutes.about, '/about'));

    test('all constants are distinct', () {
      final values = [
        ControlPanelRoutes.root,
        ControlPanelRoutes.liveStreamOnly,
        ControlPanelRoutes.settings,
        ControlPanelRoutes.about,
      ];
      expect(values.toSet().length, values.length);
    });
  });
}
