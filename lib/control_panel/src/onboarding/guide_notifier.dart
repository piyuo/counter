import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'guide_notifier.g.dart';

@immutable
class GuideState {
  final String text;

  const GuideState({this.text = ''});

  GuideState copyWith({String? text}) {
    return GuideState(text: text ?? this.text);
  }
}

@riverpod
class GuideNotifier extends _$GuideNotifier {
  @override
  GuideState build() {
    ref.onDispose(() {});
    return const GuideState();
  }
}
