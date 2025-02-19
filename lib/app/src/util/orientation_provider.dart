import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// Provide orientation detection when the device is locked to portrait mode.
class OrientationProvider with ChangeNotifier {
  OrientationProvider({required this.onOrientationChanged});

  /// The subscription of the accelerometer sensor
  StreamSubscription? _subscription;

  /// The rotation degree of the device
  int rotationDegree = 0;

  /// The orientation of the device
  DeviceOrientation orientation = DeviceOrientation.portraitUp;

  /// onOrientationChanged called when device orientation changed.
  final void Function(DeviceOrientation orientation) onOrientationChanged;

  /// start orientation detection.
  Future<void> start() async {
    _subscription = accelerometerEventStream().listen(
      (AccelerometerEvent event) {
        // update orientation
        const double threshold = 3.0;
        DeviceOrientation newOrientation = DeviceOrientation.portraitUp;
        if (event.y.abs() > event.x.abs() && event.y.abs() > threshold) {
          if (event.y > 0) {
            newOrientation = DeviceOrientation.portraitUp;
          } else {
            newOrientation = DeviceOrientation.portraitDown;
          }
        } else if (event.x.abs() > threshold) {
          if (event.x > 0) {
            newOrientation = DeviceOrientation.landscapeRight;
          } else {
            newOrientation = DeviceOrientation.landscapeLeft;
          }
        }
        if (newOrientation != orientation) {
          orientation = newOrientation;
          onOrientationChanged(orientation);
        }

        // update rotation degree
        rotationDegree = _adjustRotation((-atan2(event.x, event.y) * (180 / pi)).toInt());
      },
      onError: (e) {},
      cancelOnError: false,
    );
  }

  /// make the rotation degree close to 0, 90, 180, 270
  int _adjustRotation(int rotation) {
    if (rotation < 0) {
      rotation += 360;
    }
    if (rotation > 355 || rotation < 5) {
      return 0;
    } else if (rotation > 85 && rotation < 95) {
      return 90;
    } else if (rotation > 175 && rotation < 185) {
      return 180;
    } else if (rotation > 265 && rotation < 275) {
      return 270;
    }
    return rotation;
  }

  /// Stop the orientation detection
  Future<void> stop() async {
    await _subscription?.cancel();
    _subscription = null;
  }
}
