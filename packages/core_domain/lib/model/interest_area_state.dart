import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';

/// One list of areas. Every change is live; there is no draft and no save/cancel.
/// [isEditing] only decides whether the editor UI (handles, gestures) is shown.
@immutable
class InterestAreaState {
  static const _unset = Object();

  const InterestAreaState({
    required this.areas,
    required this.isEditing,
    required this.selectedAreaId,
    required this.selectedPointIndex,
  });

  const InterestAreaState.initial()
    : areas = const [],
      isEditing = false,
      selectedAreaId = null,
      selectedPointIndex = null;

  const InterestAreaState.resetToInitial()
    : areas = const [],
      isEditing = true,
      selectedAreaId = null,
      selectedPointIndex = null;

  final List<core_domain.InterestArea> areas;
  final bool isEditing;
  final int? selectedAreaId;
  final int? selectedPointIndex;

  InterestAreaState copyWith({
    List<core_domain.InterestArea>? areas,
    bool? isEditing,
    Object? selectedAreaId = _unset,
    Object? selectedPointIndex = _unset,
  }) {
    return InterestAreaState(
      areas: areas ?? this.areas,
      isEditing: isEditing ?? this.isEditing,
      selectedAreaId: selectedAreaId == _unset ? this.selectedAreaId : selectedAreaId as int?,
      selectedPointIndex: selectedPointIndex == _unset ? this.selectedPointIndex : selectedPointIndex as int?,
    );
  }
}
