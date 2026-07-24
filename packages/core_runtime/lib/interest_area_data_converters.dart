// Extension: InterestAreaDataConverters
// Description: Bidirectional conversion between domain InterestAreaData and flutter_vision's InterestArea.
//   Allows the app to persist interest areas as JSON-serializable domain models while
//   working with the vision package's native types at runtime.
// Usage:
//   - interestAreaData.toInterestArea() → convert domain model to vision type
//   - interestArea.toInterestAreaData()  → convert vision type to domain model

import 'package:core_domain/core_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart';

/// Extension methods for converting InterestAreaData to/from flutter_vision's InterestArea.
extension InterestAreaDataConverters on InterestAreaData {
  /// Converts this domain model to a flutter_vision InterestArea instance.
  InterestArea toInterestArea() {
    return InterestArea(
      id: id,
      name: name,
      color: Color(color),
      points: points.map((p) => Offset(p.dx, p.dy)).toList(),
      enabled: enabled,
    );
  }
}

/// Extension methods for converting InterestArea to InterestAreaData.
extension InterestAreaConverters on InterestArea {
  /// Converts this flutter_vision InterestArea to a domain model.
  InterestAreaData toInterestAreaData() {
    return InterestAreaData(
      id: id,
      name: name,
      color: color.toARGB32(),
      points: points.map((p) => PointData(dx: p.dx, dy: p.dy)).toList(),
      enabled: enabled,
    );
  }
}
