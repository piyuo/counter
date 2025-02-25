import 'package:flutter/cupertino.dart';

/// color table for zone
List<Color> zoneColorTable = [
  CupertinoColors.systemBlue.withValues(alpha: 0.85),
  CupertinoColors.systemGreen.withValues(alpha: 0.85),
  CupertinoColors.systemOrange.withValues(alpha: 0.85),
  CupertinoColors.systemPurple.withValues(alpha: 0.85),
  CupertinoColors.systemTeal.withValues(alpha: 0.85),
  CupertinoColors.systemBrown.withValues(alpha: 0.85),
  CupertinoColors.systemCyan.withValues(alpha: 0.85),
  CupertinoColors.systemIndigo.withValues(alpha: 0.85),
  CupertinoColors.systemMint.withValues(alpha: 0.85),
  CupertinoColors.systemPink.withValues(alpha: 0.85),
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
