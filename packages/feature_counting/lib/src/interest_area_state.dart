import 'package:flutter/material.dart';

import 'interest_area.dart';

@immutable
class InterestAreaState {
  static const _unset = Object();

  const InterestAreaState({
    required this.activeAreas,
    required this.editingAreas,
    required this.isEditing,
    required this.selectedAreaId,
    required this.selectedPointIndex,
  });

  final List<InterestArea> activeAreas;
  final List<InterestArea> editingAreas;
  final bool isEditing;
  final int? selectedAreaId;
  final int? selectedPointIndex;

  const InterestAreaState.initial()
      : activeAreas = const [],
        editingAreas = const [],
        isEditing = false,
        selectedAreaId = null,
        selectedPointIndex = null;

  InterestAreaState copyWith({
    List<InterestArea>? activeAreas,
    List<InterestArea>? editingAreas,
    bool? isEditing,
    Object? selectedAreaId = _unset,
    Object? selectedPointIndex = _unset,
  }) {
    return InterestAreaState(
      activeAreas: activeAreas ?? this.activeAreas,
      editingAreas: editingAreas ?? this.editingAreas,
      isEditing: isEditing ?? this.isEditing,
      selectedAreaId: selectedAreaId == _unset ? this.selectedAreaId : selectedAreaId as int?,
      selectedPointIndex: selectedPointIndex == _unset ? this.selectedPointIndex : selectedPointIndex as int?,
    );
  }
}
