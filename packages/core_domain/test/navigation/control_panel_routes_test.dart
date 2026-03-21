// TOC:
//  - ControlPanelRoutes path constant values

import 'package:core_domain/navigation/routes/control_panel_routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ControlPanelRoutes', () {
    test('root is "/"', () => expect(ControlPanelRoutes.root, '/'));
    test('start is "/start"', () => expect(ControlPanelRoutes.start, '/start'));
    test('liveStreamOnly is "/live-stream-only"', () => expect(ControlPanelRoutes.liveStreamOnly, '/live-stream-only'));

    test('all constants are distinct', () {
      final values = [ControlPanelRoutes.root, ControlPanelRoutes.start, ControlPanelRoutes.liveStreamOnly];
      expect(values.toSet().length, values.length);
    });
  });
}
