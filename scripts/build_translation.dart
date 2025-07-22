#!/usr/bin/env dart
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

/// Script to convert translations.csv to ARB files
///
/// Usage: dart csv_to_arb.dart [csv_file_path] [output_directory]
///
/// Default:
/// - csv_file_path: ../lib/src/l10n/translations.csv
/// - output_directory: ../lib/src/l10n/
void main(List<String> args) {
  String csvFilePath = args.isNotEmpty ? args[0] : '../lib/src/l10n/translations.csv';

  String outputDir = args.length > 1 ? args[1] : '../lib/src/l10n/';

  // Handle absolute vs relative paths
  File csvFile;
  Directory outputDirectory;

  if (csvFilePath.startsWith('/')) {
    // Absolute path
    csvFile = File(csvFilePath);
  } else {
    // Relative path - resolve from script directory
    final scriptDir = File(Platform.script.toFilePath()).parent;
    csvFile = File('${scriptDir.path}/$csvFilePath');
  }

  if (outputDir.startsWith('/')) {
    // Absolute path
    outputDirectory = Directory(outputDir);
  } else {
    // Relative path - resolve from script directory
    final scriptDir = File(Platform.script.toFilePath()).parent;
    outputDirectory = Directory('${scriptDir.path}/$outputDir');
  }

  if (!csvFile.existsSync()) {
    print('Error: CSV file not found: ${csvFile.path}');
    exit(1);
  }

  if (!outputDirectory.existsSync()) {
    print('Error: Output directory not found: ${outputDirectory.path}');
    exit(1);
  }

  try {
    convertCsvToArb(csvFile, outputDirectory);
    print('✅ Successfully converted CSV to ARB files!');
  } catch (e) {
    print('❌ Error converting CSV to ARB: $e');
    exit(1);
  }
}

void convertCsvToArb(File csvFile, Directory outputDir) {
  final lines = csvFile.readAsLinesSync();

  if (lines.isEmpty) {
    throw Exception('CSV file is empty');
  }

  // Parse header to get locale information
  final header = parseCSVLine(lines[0]);
  if (header.isEmpty || header[0].toLowerCase() != 'key') {
    throw Exception('Invalid CSV format. First column should be "Key"');
  }

  // Extract locale identifiers (remove "app_" prefix if present)
  final locales = <String>[];
  for (int i = 1; i < header.length; i++) {
    String locale = header[i];
    if (locale.startsWith('app_')) {
      locale = locale.substring(4); // Remove "app_" prefix
    }
    locales.add(locale);
  }

  // Initialize translation maps for each locale
  final translations = <String, Map<String, String>>{};
  for (final locale in locales) {
    translations[locale] = <String, String>{};
  }

  // Process each data row
  for (int rowIndex = 1; rowIndex < lines.length; rowIndex++) {
    final line = lines[rowIndex].trim();
    if (line.isEmpty) continue;

    final values = parseCSVLine(line);
    if (values.isEmpty) continue;

    final key = values[0];
    if (key.isEmpty) continue;

    // Add translations for each locale
    for (int i = 1; i < values.length && i <= locales.length; i++) {
      final locale = locales[i - 1];
      final translation = values[i];

      if (translation.isNotEmpty) {
        translations[locale]![key] = translation;
      }
    }
  }

  // Generate ARB files
  for (final locale in locales) {
    final arbData = translations[locale]!;
    if (arbData.isNotEmpty) {
      final arbFile = File('${outputDir.path}/app_$locale.arb');
      writeArbFile(arbFile, arbData);
      print('📝 Generated: ${arbFile.path} (${arbData.length} translations)');
    }
  }
}

List<String> parseCSVLine(String line) {
  final result = <String>[];
  final buffer = StringBuffer();
  bool inQuotes = false;
  bool hasContent = false;

  for (int i = 0; i < line.length; i++) {
    final char = line[i];

    if (char == '"') {
      if (inQuotes && i + 1 < line.length && line[i + 1] == '"') {
        // Escaped quote
        buffer.write('"');
        i++; // Skip next quote
      } else {
        // Toggle quote state
        inQuotes = !inQuotes;
      }
      hasContent = true;
    } else if (char == ',' && !inQuotes) {
      // End of field
      result.add(buffer.toString());
      buffer.clear();
      hasContent = false;
    } else {
      buffer.write(char);
      hasContent = true;
    }
  }

  // Add the last field
  if (hasContent || result.isNotEmpty) {
    result.add(buffer.toString());
  }

  return result;
}

void writeArbFile(File arbFile, Map<String, String> translations) {
  // Create a properly formatted JSON object
  final sortedKeys = translations.keys.toList()..sort();
  final jsonMap = <String, String>{};

  for (final key in sortedKeys) {
    jsonMap[key] = translations[key]!;
  }

  // Generate formatted JSON
  const encoder = JsonEncoder.withIndent('  ');
  final jsonString = encoder.convert(jsonMap);

  arbFile.writeAsStringSync('$jsonString\n');
}
