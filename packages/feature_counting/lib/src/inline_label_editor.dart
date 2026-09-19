// inline_label_editor.dart
//
// Owns its TextEditingController and FocusNode, so the parent no longer
// needs the Future.microtask dispose workarounds. Losing focus (tapping
// elsewhere) or submitting commits exactly once.

import 'package:flutter/material.dart';

class InlineLabelEditor extends StatefulWidget {
  const InlineLabelEditor({required this.color, required this.initialText, required this.onCommit, super.key});

  final Color color;
  final String initialText;

  /// Called once with the trimmed text.
  final ValueChanged<String> onCommit;

  @override
  State<InlineLabelEditor> createState() => _InlineLabelEditorState();
}

class _InlineLabelEditorState extends State<InlineLabelEditor> {
  late final TextEditingController _controller = TextEditingController(text: widget.initialText);
  late final FocusNode _focusNode = FocusNode()..addListener(_onFocusChange);
  bool _committed = false;

  @override
  void dispose() {
    _focusNode
      ..removeListener(_onFocusChange)
      ..dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    // Tapping outside drops focus; treat as save-and-close, like a spreadsheet cell.
    if (!_focusNode.hasFocus) _commit();
  }

  void _commit() {
    if (_committed) return;
    _committed = true;
    // The parent removes this widget in response, so disposal happens on the
    // next build, never inside the FocusNode's own notifyListeners.
    widget.onCommit(_controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: widget.color.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(6)),
      alignment: Alignment.center,
      // TextField requires a Material ancestor; this overlay sits outside the app's Scaffold/Material tree.
      child: Material(
        type: MaterialType.transparency,
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          autofocus: true,
          textAlign: TextAlign.center,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _commit(),
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
        ),
      ),
    );
  }
}
