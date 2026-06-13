import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// Local-only crash log storage. No data leaves the device.
class CrashLogService {
  CrashLogService({this._logDirectory});

  final Directory? _logDirectory;
  static const _logFileName = 'sarf_crash_log.jsonl';
  static const _maxEntries = 100;

  Future<File> _logFile() async {
    final directory = _logDirectory ?? await getApplicationDocumentsDirectory();
    return File('${directory.path}${Platform.pathSeparator}$_logFileName');
  }

  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    String source = 'unknown',
  }) async {
    final entry = CrashLogEntry(
      timestamp: DateTime.now().toUtc(),
      source: source,
      error: error.toString(),
      stackTrace: stackTrace?.toString(),
    );
    await _appendEntry(entry);
  }

  Future<void> _appendEntry(CrashLogEntry entry) async {
    try {
      final file = await _logFile();
      final lines = <String>[];
      if (await file.exists()) {
        lines.addAll(await file.readAsLines());
      }
      lines.add(jsonEncode(entry.toJson()));
      final trimmed = lines.length > _maxEntries
          ? lines.sublist(lines.length - _maxEntries)
          : lines;
      await file.writeAsString('${trimmed.join('\n')}\n');
    } catch (_) {
      // Logging must never crash the app.
    }
  }

  Future<List<CrashLogEntry>> readEntries() async {
    final file = await _logFile();
    if (!await file.exists()) {
      return [];
    }
    final entries = <CrashLogEntry>[];
    for (final line in await file.readAsLines()) {
      if (line.trim().isEmpty) {
        continue;
      }
      try {
        entries.add(CrashLogEntry.fromJson(jsonDecode(line) as Map<String, dynamic>));
      } catch (_) {
        continue;
      }
    }
    return entries;
  }

  Future<String> exportAsText() async {
    final entries = await readEntries();
    if (entries.isEmpty) {
      return '';
    }
    final buffer = StringBuffer();
    for (final entry in entries) {
      buffer.writeln('--- ${entry.timestamp.toIso8601String()} (${entry.source}) ---');
      buffer.writeln(entry.error);
      if (entry.stackTrace != null && entry.stackTrace!.isNotEmpty) {
        buffer.writeln(entry.stackTrace);
      }
      buffer.writeln();
    }
    return buffer.toString().trim();
  }

  Future<void> clear() async {
    final file = await _logFile();
    if (await file.exists()) {
      await file.delete();
    }
  }
}

class CrashLogEntry {
  const CrashLogEntry({
    required this.timestamp,
    required this.source,
    required this.error,
    this.stackTrace,
  });

  final DateTime timestamp;
  final String source;
  final String error;
  final String? stackTrace;

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp.toIso8601String(),
        'source': source,
        'error': error,
        if (stackTrace != null) 'stackTrace': stackTrace,
      };

  factory CrashLogEntry.fromJson(Map<String, dynamic> json) {
    return CrashLogEntry(
      timestamp: DateTime.parse(json['timestamp'] as String),
      source: json['source'] as String,
      error: json['error'] as String,
      stackTrace: json['stackTrace'] as String?,
    );
  }
}

void installGlobalErrorHandlers(CrashLogService crashLogService) {
  final previousFlutterHandler = FlutterError.onError;
  FlutterError.onError = (details) {
    crashLogService.recordError(
      details.exception,
      details.stack,
      source: 'flutter',
    );
    previousFlutterHandler?.call(details);
    if (kDebugMode) {
      FlutterError.presentError(details);
    }
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    crashLogService.recordError(error, stack, source: 'platform');
    return true;
  };
}
