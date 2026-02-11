import 'package:flutter/cupertino.dart';

@immutable
class ControlPanelState {
  // the background color of the control panel, this color mainly used in pip screen
  final Color backgroundColor;

  const ControlPanelState({this.backgroundColor = CupertinoColors.white});

  ControlPanelState copyWith({Color? backgroundColor}) {
    return ControlPanelState(backgroundColor: backgroundColor ?? this.backgroundColor);
  }
}
