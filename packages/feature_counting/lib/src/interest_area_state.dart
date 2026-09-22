import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';

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

  final List<core_domain.InterestArea> activeAreas;
  final List<core_domain.InterestArea> editingAreas;
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
    List<core_domain.InterestArea>? activeAreas,
    List<core_domain.InterestArea>? editingAreas,
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
