import 'package:flutter/cupertino.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

Future<bool?> showMessageDialog(String message, {String? title, String label = 'OK'}) async {
  final context = appkit.globalContext;
  if (!context.mounted) return null;

  return GlassDialog.show<bool>(
    context: context,
    title: title,
    message: message,
    actions: [
      GlassDialogAction(
        label: label,
        isPrimary: true,
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
      ),
    ],
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

  return GlassDialog.show<bool>(
    context: context,
    title: title,
    message: message,
    actions: [
      GlassDialogAction(label: noLabel, onPressed: () => Navigator.of(context, rootNavigator: true).pop(false)),
      GlassDialogAction(
        label: yesLabel,
        isPrimary: true,
        isDestructive: isYesDestructive,
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
      ),
    ],
  );
}
