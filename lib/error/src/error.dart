import 'dart:async';

import 'package:counter/l10n/l10n.dart';
import 'package:counter/log/log.dart' as log;
import 'package:flutter/cupertino.dart';

import 'error_email.dart';
import 'global_context_support.dart';

var showCatchedAlert = false;

/// watch global exception
/// ```dart
/// errorHandler.watch(suspect);
/// ```
void watch(Function suspect) {
  final originalOnError = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails details) async {
    await catched(
      details.exception,
      details.stack,
    );
    originalOnError?.call(details);
  };

  runZonedGuarded<Future<void>>(
    () async => suspect(),
    (Object e, StackTrace stack) async => await catched(
      e,
      stack,
    ),
  );
}

@visibleForTesting
Future<void> catched(dynamic e, StackTrace? stack) async {
  log.error(e, stack);
  if (e is AssertionError) {
    //don't do anything, assertion only happen in development
    return;
  }

  if (showCatchedAlert) {
    // error already show
    return;
  }
  showCatchedAlert = true;
  try {
    showCupertinoDialog(
      context: globalContext,
      builder: (context) => CupertinoAlertDialog(
        title: Text(context.l.error_oops, style: TextStyle(fontSize: 20.0)),
        content: Text(context.l.error_content, style: TextStyle(fontSize: 16.0)),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(context.l.cancel, style: TextStyle(color: CupertinoColors.label.resolveFrom(context))),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text(context.l.error_report),
            onPressed: () {
              final em = ErrorEmail();
              em.launchMailTo();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  } catch (ex) {
    debugPrint(ex.toString()); //don't show error if something wrong in alert
  } finally {
    showCatchedAlert = false;
  }
}
