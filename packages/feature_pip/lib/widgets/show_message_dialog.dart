import 'package:flutter/cupertino.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;

Future<bool?> showMessageDialog(String message, {String? title, String label = 'OK'}) async {
  final context = appkit.globalContext;
  if (!context.mounted) return null;
  return showCupertinoDialog<bool>(
    context: context,
    builder: (context) => CupertinoTheme(
      data: CupertinoThemeData(brightness: Brightness.light),
      child: CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: Text(message, style: const TextStyle(fontSize: 16)),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
            child: Text(label),
          ),
        ],
      ),
    ),
  );
}

Future<bool?> showYesNoMessageDialog(
  String message, {
  String? title,
  String noLabel = 'No',
  String yesLabel = 'Yes',
  bool isYesDestructive = false,
}) async {
  final context = appkit.globalContext;
  if (!context.mounted) return null;
  return showCupertinoDialog<bool>(
    context: context,
    builder: (context) => CupertinoTheme(
      data: CupertinoThemeData(brightness: Brightness.light),
      child: CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: Text(message, style: const TextStyle(fontSize: 16)),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
            child: Text(noLabel),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            isDestructiveAction: isYesDestructive,
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
            child: Text(yesLabel),
          ),
        ],
      ),
    ),
  );
}
