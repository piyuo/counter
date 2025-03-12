import 'package:flutter/cupertino.dart';

/// color table for zone
List<Color> zoneColorTable = [
  CupertinoColors.systemBlue.withValues(alpha: 0.5),
  CupertinoColors.systemGreen.withValues(alpha: 0.5),
  CupertinoColors.systemOrange.withValues(alpha: 0.5),
  CupertinoColors.systemPurple.withValues(alpha: 0.5),
  CupertinoColors.systemTeal.withValues(alpha: 0.5),
  CupertinoColors.systemBrown.withValues(alpha: 0.5),
  CupertinoColors.systemCyan.withValues(alpha: 0.5),
  CupertinoColors.systemIndigo.withValues(alpha: 0.5),
  CupertinoColors.systemMint.withValues(alpha: 0.5),
  CupertinoColors.systemPink.withValues(alpha: 0.5),
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
