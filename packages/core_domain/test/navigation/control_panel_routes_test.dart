// TOC:
//  - ControlPanelRoutes path constant values

import 'package:core_domain/navigation/routes/control_panel_routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ControlPanelRoutes', () {
    test('root is "/"', () => expect(ControlPanelRoutes.root, '/'));
    test('start is "/start"', () => expect(ControlPanelRoutes.start, '/start'));
    test(
      'deviceNotSupported is "/device-not-supported"',
      () => expect(ControlPanelRoutes.deviceNotSupported, '/device-not-supported'),
    );

    test('all constants are distinct', () {
      final values = [ControlPanelRoutes.root, ControlPanelRoutes.start, ControlPanelRoutes.deviceNotSupported];
      expect(values.toSet().length, values.length);
    });
  });
}
