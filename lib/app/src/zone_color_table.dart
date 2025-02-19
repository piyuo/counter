import 'package:flutter/cupertino.dart';

/// color table for zone
const List<Color> zoneColorTable = [
  CupertinoColors.systemBlue,
  CupertinoColors.systemGreen,
  CupertinoColors.systemOrange,
  CupertinoColors.systemPurple,
  CupertinoColors.systemTeal,
  CupertinoColors.systemBrown,
  CupertinoColors.systemCyan,
  CupertinoColors.systemIndigo,
  CupertinoColors.systemMint,
  CupertinoColors.systemPink,
];

/// zone color is better to be different from each other, it will be easy read on the report
int globalZoneColorIndex = 0;

/// get next zone color
Color getNextZoneColor() {
  Color color = zoneColorTable[globalZoneColorIndex];
  globalZoneColorIndex = (globalZoneColorIndex + 1) % zoneColorTable.length;
  return color;
}

/// set next zone color index
void setNextZoneColorIndex(int index) {
  globalZoneColorIndex = index;
}
