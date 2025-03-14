import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'logs.dart';

/// _lastException is last exception, it will used by error screen
dynamic _lastException;

/// lastException is last exception
dynamic get lastException => _lastException;

/// lastExceptionToString is last exception to string, it will used by error screen
String get lastExceptionToString => exceptionToString(_lastException);

/// lastException is last exception, it will used by error screen
/// ```dart
/// expect(lastExceptionMessage, 'hi');
/// ```
String? get lastExceptionMessage {
  if (_lastException == null) {
    return null;
  }
  try {
    if (_lastException is Exception) {
      return _lastException.message;
    }
    return _lastException.toString();
  } catch (_) {}
  return _lastException.runtimeType.toString();
}

/// _lastStackTrace is last stack trace, it will used by error screen
String _lastStackTrace = '';

/// lastStackTrace is last stack trace, it will used by error screen
String get lastStackTrace => _lastStackTrace;

/// printLastError print last error message and stack trace
String printLastError() => '$_lastException\n$_lastStackTrace';

/// safeJsonEncode return json of object, return object.toString() if can't encode json
String safeJsonEncode(Object object) {
  try {
    return jsonEncode(object);
  } catch (e) {
    debug(e.toString());
  }
  return toString(object);
}

/// debug only print message in development. code will be remove at release mode
/// ```dart
///  debug('something done');
/// ```
void debug(String message) {
  if (!kReleaseMode) {
    debugPrint(message);
  }
}

/// log normal but significant events , such as start up, shut down, or a configuration change.
/// ```dart
/// log('something done');
/// ```
void log(String message) {
//  if (!kReleaseMode) {}
  debugPrint(message);
  pushLog(message: message);
}

/// exceptionToString return string of exception
String exceptionToString(dynamic e) {
  if (e == null) {
    return '';
  }
  var message = '';
  try {
    message = e.toString();
  } catch (_) {
    message = e.runtimeType.toString();
  }
  return message;
}

/// error print error message to console and keep log
/// ```dart
/// try {
///   throw Exception('my error');
/// } catch (e, s) {
///   error( e, s);
/// }
/// ```
void error(dynamic e, StackTrace? stacktrace) {
  _lastException = e;
  var message = exceptionToString(e);
  var out = 'caught $message';
  _lastStackTrace = stacktrace == null ? '' : beautyStack(stacktrace);
  if (_lastStackTrace.isNotEmpty) {
    out += '\n$_lastStackTrace';
  }
  debugPrint(out);
  pushLog(
    message: message,
    stacktrace: _lastStackTrace,
  );
}

///beautyStack return simple format stack trace
/// ```dart
///	catch (e, s) {
///	String text = beautyStack(s);
///	expect(text.length > 0, true);
///	}
/// ```
String beautyStack(StackTrace stack) {
  final buffer = StringBuffer();
  List<String> lines = stack.toString().split('\n');
  for (var l in lines) {
    if (isLineUsable(l) && l.length > 6) {
      l = beautyLine(l);
      if (l != '') {
        buffer.writeln(l);
      }
    }
  }

  var result = buffer.toString();
  if (buffer.length > 0) {
    result = result.substring(0, buffer.length - 1);
  }
  return result;
}

///beautyLine return line that accept by google stack driver format
/// ```dart
///	beautyLine(l);
/// ```
@visibleForTesting
String beautyLine(String l) {
  return _beautyLine(l);
  //.replaceAll('file:///Users/cc/Dropbox/prj/fl/', '');
}

String _beautyLine(String l) {
  l = l
      .replaceAll('<anonymous closure>', '')
      .replaceAll(RegExp(r"\s+\b|\b\s"), ' '); // convert spaces to _ for stack driver format

  if (l.startsWith('#')) {
    var i = l.indexOf(' ');
    return 'at ${l.substring(i, l.length).trim()}';
  }
  var list = l.split('.dart');
  if (list.length == 2) {
    var file = '${list[0].trim().replaceAll(' ', '_')}.dart';
    var pos = list[1].trim().replaceAll(' ', '_');
    return 'at $file ($pos)';
  }
  return '';
}

/// isLineUsable check line to see if we need it for debug
@visibleForTesting
bool isLineUsable(String line) {
  List<String> containKeywords = [
    'asynchronous',
    '(dart:',
    'package:http/src/',
    'package:flutter/',
    'test_api',
    'flutter_test',
    'StackZone'
  ];
  for (var keyword in containKeywords) {
    if (line.contains(keyword)) {
      return false;
    }
  }
  List<String> startwithKeywords = [
    'package:stack_trace',
    'package:stream_channel',
    'dart:',
  ];
  for (var keyword in startwithKeywords) {
    if (line.startsWith(keyword)) {
      return false;
    }
  }

  return true;
}

/// toString encode object into string
/// ```dart
///  toString(state);
/// ```
String toString(dynamic value) {
  if (value != null) {
    var text = value.toString().replaceAll('\n', '');
    if (!text.contains('Instance of')) {
      return text;
    }
  }
  return '';
}

/*/// header return  user@application:
/// ```dart
/// print(header); // 'kevin@piyuo: hello world'
/// ```
@visibleForTesting
String get header {
  var user = '';
  try {
    final beamState = Beamer.of(context).currentBeamLocation.state as BeamState;
    final bookId = beamState.pathParameters['bookId'];

    final sessionProvider = app.SessionProvider.of(delta.globalContext);
    final session = sessionProvider.session;
    if (session != null) {
      user = '${session.userId}@';
    }
  } catch (_) {}

  var head = user;
  if (head.isNotEmpty) {
    head += ':';
  }
  return head;
}
 */