import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sarf/core/crash/crash_log_service.dart';

void main() {
  late Directory tempDir;
  late CrashLogService service;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('sarf_crash_test');
    service = CrashLogService(logDirectory: tempDir);
  });

  tearDown(() async {
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('records and serializes crash log entries', () async {
    await service.recordError(
      Exception('test failure'),
      StackTrace.current,
      source: 'test',
    );

    final entries = await service.readEntries();
    expect(entries, hasLength(1));
    expect(entries.single.error, contains('test failure'));
    expect(entries.single.source, 'test');

    final exported = await service.exportAsText();
    expect(exported, contains('test failure'));
    expect(exported, contains('test'));
  });

  test('entries round-trip through JSON', () async {
    final entry = CrashLogEntry(
      timestamp: DateTime.utc(2026, 6, 13, 10),
      source: 'flutter',
      error: 'boom',
      stackTrace: 'line 1',
    );
    final json = jsonEncode(entry.toJson());
    final restored = CrashLogEntry.fromJson(jsonDecode(json) as Map<String, dynamic>);
    expect(restored.error, 'boom');
    expect(restored.stackTrace, 'line 1');
  });

  test('recordError does not throw when log write fails', () async {
    // Block the log file path with a directory so writeAsString fails on all platforms.
    final blockedLogPath = Directory(
      '${tempDir.path}${Platform.pathSeparator}sarf_crash_log.jsonl',
    );
    await blockedLogPath.create();
    final fragileService = CrashLogService(logDirectory: tempDir);

    await expectLater(
      fragileService.recordError('error', StackTrace.current),
      completes,
    );

    final entries = await fragileService.readEntries();
    expect(entries, isEmpty);
  });
}
