import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sarf/core/constants/app_constants.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/database/app_database.dart';
import 'package:sarf/features/settings/data/backup_service.dart';
import 'package:sarf/features/shared/data/repositories.dart';

AppDatabase _memoryDb() => AppDatabase(NativeDatabase.memory());

CommitmentModel _sampleCommitment({String id = 'c1'}) {
  final now = DateTime.utc(2026, 1, 1);
  return CommitmentModel(
    id: id,
    name: 'Netflix',
    amount: 49,
    currency: 'SAR',
    billingCycle: BillingCycle.monthly,
    category: CommitmentCategory.entertainment,
    nextDueDate: DateTime.utc(2026, 1, 15),
    reminderDaysBefore: 3,
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  late AppDatabase db;
  late BackupService backupService;
  late CommitmentRepository commitmentRepository;
  late SettingsRepository settingsRepository;

  setUp(() {
    db = _memoryDb();
    commitmentRepository = CommitmentRepository(db);
    settingsRepository = SettingsRepository(db);
    backupService = BackupService(
      commitmentRepository,
      TemplateRepository(db),
      settingsRepository,
      NotificationScheduleRepository(db),
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('export produces valid JSON with metadata', () async {
    await commitmentRepository.upsert(_sampleCommitment());
    await settingsRepository.saveSettings(
      const AppSettingsModel(
        localePreference: AppLocalePreference.en,
        notificationsEnabled: true,
        defaultCurrency: 'SAR',
      ),
    );

    final backup = await backupService.exportBackup();
    final json = backupService.encodeBackup(backup);

    expect(() => jsonDecode(json), returnsNormally);
    expect(backup['appName'], AppConstants.appName);
    expect(backup['exportVersion'], AppConstants.backupExportVersion);
    expect(backup['schemaVersion'], AppConstants.schemaVersion);
    expect(backup['exportedAt'], isNotEmpty);
    final data = backup['data'] as Map<String, dynamic>;
    expect((data['commitments'] as List), hasLength(1));
  });

  test('import rejects invalid app name', () async {
    final invalid = jsonEncode({
      'appName': 'OtherApp',
      'exportVersion': AppConstants.backupExportVersion,
      'schemaVersion': AppConstants.schemaVersion,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'data': {
        'commitments': [],
        'customTemplates': [],
        'settings': {},
        'notificationSchedules': [],
      },
    });

    final result = await backupService.restoreBackup(invalid);
    expect(result, BackupImportResult.invalidAppName);
  });

  test('import rejects invalid format', () async {
    final result = await backupService.restoreBackup('not json');
    expect(result, BackupImportResult.invalidFormat);
  });

  test('full restore replaces existing commitments', () async {
    await commitmentRepository.upsert(_sampleCommitment(id: 'old'));
    final backup = await backupService.exportBackup();
    final backupJson = backupService.encodeBackup(backup);

    await commitmentRepository.upsert(_sampleCommitment(id: 'new').copyWith(name: 'Spotify'));
    expect((await commitmentRepository.getAllCommitments()), hasLength(2));

    final result = await backupService.restoreBackup(backupJson);
    expect(result, BackupImportResult.success);

    final restored = await commitmentRepository.getAllCommitments();
    expect(restored, hasLength(1));
    expect(restored.single.id, 'old');
    expect(restored.single.name, 'Netflix');
  });

  test('restore keeps onboarding completed when backup omits key', () async {
    await settingsRepository.setOnboardingCompleted(true);

    final backupWithoutOnboarding = jsonEncode({
      'appName': AppConstants.appName,
      'exportVersion': AppConstants.backupExportVersion,
      'schemaVersion': AppConstants.schemaVersion,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'data': {
        'commitments': [],
        'customTemplates': [],
        'settings': {'locale': 'en'},
        'notificationSchedules': [],
      },
    });

    final result = await backupService.restoreBackup(backupWithoutOnboarding);
    expect(result, BackupImportResult.success);
    expect(await settingsRepository.isOnboardingCompleted(), isTrue);
  });

  test('restore keeps onboarding completed when backup has false', () async {
    await settingsRepository.setOnboardingCompleted(true);

    final backupWithFalse = jsonEncode({
      'appName': AppConstants.appName,
      'exportVersion': AppConstants.backupExportVersion,
      'schemaVersion': AppConstants.schemaVersion,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'data': {
        'commitments': [],
        'customTemplates': [],
        'settings': {'onboarding_completed': 'false'},
        'notificationSchedules': [],
      },
    });

    final result = await backupService.restoreBackup(backupWithFalse);
    expect(result, BackupImportResult.success);
    expect(await settingsRepository.isOnboardingCompleted(), isTrue);
  });
}
