import 'dart:convert';
import 'dart:io';

void main() async {
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final pubspecFile = File('${scriptDir.parent.path}/pubspec.yaml');

  if (!pubspecFile.existsSync()) {
    stderr.writeln('pubspec.yaml not found at ${pubspecFile.path}');
    exit(1);
  }

  final outdatedResult = await Process.run('dart', ['pub', 'outdated', '--json']);

  if (outdatedResult.exitCode != 0) {
    stderr.writeln('Failed to run dart pub outdated.');
    stderr.writeln(outdatedResult.stderr);
    exit(1);
  }

  final json = jsonDecode(outdatedResult.stdout);
  final latestVersions = <String, String>{};

  for (final pkg in json['packages']) {
    final name = pkg['package'];
    final latestField = pkg['latest'];
    final kind = pkg['kind'];
    if ((kind == 'direct' || kind == 'dev') && latestField is String) {
      latestVersions[name] = '^$latestField';
    } else if ((kind == 'direct' || kind == 'dev') && latestField is Map && latestField.containsKey('version')) {
      latestVersions[name] = '^${latestField['version']}';
    }
  }

  final lines = pubspecFile.readAsLinesSync();
  final newLines = <String>[];

  for (var line in lines) {
    final match = RegExp(r'^\s*(\w+):\s*[\^]?[0-9.]+.*$').firstMatch(line);
    if (match != null) {
      final name = match.group(1)!;
      if (latestVersions.containsKey(name)) {
        final newVersion = latestVersions[name]!;
        newLines.add('  $name: $newVersion');
        continue;
      }
    }
    newLines.add(line);
  }

  pubspecFile.writeAsStringSync(newLines.join('\n'));
  // ignore: avoid_print
  print('✅ pubspec.yaml updated with latest versions.');
}
