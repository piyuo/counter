import 'package:flutter/material.dart';

/// Shows a light-themed info dialog with white background and black text
/// regardless of the current app theme.
void showInfoDialog({required BuildContext context, required String title, required String content}) {
  final formattedContent = content.replaceAll(r'\n', '\n');

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
      content: SingleChildScrollView(
        child: Text(formattedContent, style: const TextStyle(color: Colors.black87, height: 1.5)),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
          onPressed: () => Navigator.pop(context),
          child: Text(
            MaterialLocalizations.of(context).okButtonLabel,
            style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}
