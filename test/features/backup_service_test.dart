import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sarf/core/constants/app_constants.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/database/app_database.dart';
import 'package:sarf/features/settings/data/backup_service.dart';
import 'package:sarf/features/shared/data/repositories.dart';
import '../test_helpers.dart';

AppDatabase _memoryDb() => AppDatabase(NativeDatabase.memory());

void main() {
  late AppDatabase db;
  late BackupService backupService;
  late CommitmentRepository commitmentRepository;
  late SettingsRepository settingsRepository;

  late PaymentCardRepository paymentCardRepository;

  setUp(() {
    db = _memoryDb();
    commitmentRepository = CommitmentRepository(db);
    settingsRepository = SettingsRepository(db);
    paymentCardRepository = PaymentCardRepository(db);
    backupService = BackupService(
      commitmentRepository,
      TemplateRepository(db),
      settingsRepository,
      NotificationScheduleRepository(db),
      paymentCardRepository,
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('export produces valid JSON with metadata', () async {
    await commitmentRepository.upsert(testCommitment(name: 'Netflix'));
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
    expect(backup['schemaVersion'], AppConstants.schemaVersion);
    final data = backup['data'] as Map<String, dynamic>;
    expect((data['commitments'] as List), hasLength(1));
  });

  test('export includes paid amount field', () async {
    await commitmentRepository.upsert(
      testCommitment(
        id: 'usd-1',
        name: 'ChatGPT',
        amount: 20,
        currency: 'USD',
        reportingCurrency: 'SAR',
        paidReportingAmount: 78.42,
        paymentMethod: PaymentMethod.card,
        paymentSourceLabel: 'Al Rajhi Visa',
      ),
    );

    final backup = await backupService.exportBackup();
    final commitment = (backup['data']['commitments'] as List).single as Map<String, dynamic>;

    expect(commitment['paidReportingAmount'], 78.42);
    expect(commitment['paymentMethod'], 'card');
    expect(commitment['paymentSourceLabel'], 'Al Rajhi Visa');
  });

  test('import v4 backup maps estimatedReportingAmount to paid amount', () async {
    final v4Backup = jsonEncode({
      'appName': AppConstants.appName,
      'exportVersion': AppConstants.backupExportVersion,
      'schemaVersion': 4,
      'exportedAt': DateTime.utc(2026, 1, 1).toIso8601String(),
      'data': {
        'commitments': [
          {
            'id': 'v4-usd',
            'name': 'ChatGPT',
            'amount': 20,
            'currency': 'USD',
            'reportingCurrency': 'SAR',
            'estimatedReportingAmount': 75,
            'exchangeRate': 3.75,
            'paymentMethod': 'card',
            'billingCycle': 'monthly',
            'category': 'work',
            'nextDueDate': DateTime.utc(2026, 2, 1).toIso8601String(),
            'isPaused': false,
            'createdAt': DateTime.utc(2026, 1, 1).toIso8601String(),
            'updatedAt': DateTime.utc(2026, 1, 1).toIso8601String(),
          },
        ],
        'customTemplates': [],
        'settings': {'default_currency': 'SAR'},
        'notificationSchedules': [],
      },
    });

    final result = await backupService.restoreBackup(v4Backup);
    expect(result, BackupImportResult.success);

    final restored = await commitmentRepository.getCommitment('v4-usd');
    expect(restored?.paidReportingAmount, 75);
  });

  test('export and import payment cards', () async {
    await paymentCardRepository.upsert(
      testPaymentCard(id: 'card-export', last4: '1234'),
    );
    await commitmentRepository.upsert(
      testCommitment(id: 'linked', cardId: 'card-export'),
    );

    final backup = await backupService.exportBackup();
    final cards = backup['data']['paymentCards'] as List;
    expect(cards, hasLength(1));
    expect(cards.single['id'], 'card-export');

    await paymentCardRepository.replaceAll([]);
    await commitmentRepository.upsert(testCommitment(id: 'other', name: 'Other'));

    final result = await backupService.restoreBackup(backupService.encodeBackup(backup));
    expect(result, BackupImportResult.success);

    final restoredCards = await paymentCardRepository.getAllCards();
    expect(restoredCards, hasLength(1));
    expect(restoredCards.single.last4, '1234');

    final restoredCommitment = await commitmentRepository.getCommitment('linked');
    expect(restoredCommitment?.cardId, 'card-export');
  });

  test('old backup without payment cards still imports', () async {
    final legacyBackup = jsonEncode({
      'appName': AppConstants.appName,
      'exportVersion': AppConstants.backupExportVersion,
      'schemaVersion': 3,
      'exportedAt': DateTime.utc(2026, 1, 1).toIso8601String(),
      'data': {
        'commitments': [
          {
            'id': 'legacy-usd',
            'name': 'ChatGPT',
            'amount': 20,
            'currency': 'USD',
            'billingCycle': 'monthly',
            'category': 'work',
            'nextDueDate': DateTime.utc(2026, 2, 1).toIso8601String(),
            'isPaused': false,
            'createdAt': DateTime.utc(2026, 1, 1).toIso8601String(),
            'updatedAt': DateTime.utc(2026, 1, 1).toIso8601String(),
          },
        ],
        'customTemplates': [],
        'settings': {'default_currency': 'SAR'},
        'notificationSchedules': [],
      },
    });

    final result = await backupService.restoreBackup(legacyBackup);
    expect(result, BackupImportResult.success);

    final restored = await commitmentRepository.getCommitment('legacy-usd');
    expect(restored?.paidReportingAmount, 20);
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

  test('full restore replaces existing commitments', () async {
    await commitmentRepository.upsert(testCommitment(id: 'old', name: 'Netflix'));
    final backup = await backupService.exportBackup();
    final backupJson = backupService.encodeBackup(backup);

    await commitmentRepository.upsert(testCommitment(id: 'new', name: 'Spotify'));
    expect((await commitmentRepository.getAllCommitments()), hasLength(2));

    final result = await backupService.restoreBackup(backupJson);
    expect(result, BackupImportResult.success);

    final restored = await commitmentRepository.getAllCommitments();
    expect(restored, hasLength(1));
    expect(restored.single.id, 'old');
  });
}
