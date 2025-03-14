import 'dart:async';

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
        title: const Text('Oops, something went wrong'),
        content: const Text('An unexpected error occurred. Would you like to submit a email report?"'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('OK'),
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
