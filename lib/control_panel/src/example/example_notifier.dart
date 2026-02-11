import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'example_notifier.g.dart';

@immutable
class ExampleState {
  final String text;

  const ExampleState({this.text = ''});

  ExampleState copyWith({String? text}) {
    return ExampleState(text: text ?? this.text);
  }
}

@riverpod
class ExampleNotifier extends _$ExampleNotifier {
  @override
  ExampleState build() {
    ref.onDispose(() {});
    return const ExampleState();
  }
}
