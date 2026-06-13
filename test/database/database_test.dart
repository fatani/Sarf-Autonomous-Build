import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sarf/core/constants/app_constants.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/database/app_database.dart';
import 'package:sarf/features/shared/data/repositories.dart';
import 'package:sarf/features/templates/data/template_seed.dart';
import '../test_helpers.dart';

AppDatabase _memoryDb() => AppDatabase(NativeDatabase.memory());

void main() {
  group('AppDatabase', () {
    test('schemaVersion is 4', () {
      final db = _memoryDb();
      addTearDown(db.close);
      expect(db.schemaVersion, AppConstants.schemaVersion);
    });

    test('creates all tables on first open', () async {
      final db = _memoryDb();
      addTearDown(db.close);
      final meta = await db.select(db.schemaMeta).get();
      expect(meta, isNotEmpty);
    });
  });

  group('CommitmentRepository', () {
    test('upsert and soft delete commitment', () async {
      final db = _memoryDb();
      addTearDown(db.close);
      final repository = CommitmentRepository(db);
      final commitment = testCommitment(name: 'Netflix');

      await repository.upsert(commitment);
      final loaded = await repository.getCommitment('c1');
      expect(loaded?.name, 'Netflix');

      await repository.softDelete('c1');
      final active = await repository.getActiveCommitments();
      expect(active, isEmpty);

      final all = await repository.watchCommitments(includeDeleted: true).first;
      expect(all.single.isDeleted, isTrue);
    });

    test('restore soft-deleted commitment', () async {
      final db = _memoryDb();
      addTearDown(db.close);
      final repository = CommitmentRepository(db);
      await repository.upsert(testCommitment(name: 'Netflix'));
      await repository.softDelete('c1');
      await repository.restore('c1');

      final active = await repository.getActiveCommitments();
      expect(active, hasLength(1));
    });

    test('persists SAR commitment with payment fields', () async {
      final db = _memoryDb();
      addTearDown(db.close);
      final repository = CommitmentRepository(db);
      final commitment = testCommitment(
        id: 'sar-1',
        name: 'Netflix',
        amount: 49.99,
        currency: 'SAR',
        paymentMethod: PaymentMethod.mada,
        paymentSourceLabel: 'Al Rajhi Mada',
      );

      await repository.upsert(commitment);
      final loaded = await repository.getCommitment('sar-1');

      expect(loaded?.amount, 49.99);
      expect(loaded?.currency, 'SAR');
      expect(loaded?.reportingCurrency, 'SAR');
      expect(loaded?.estimatedReportingAmount, 49.99);
      expect(loaded?.paymentMethod, PaymentMethod.mada);
      expect(loaded?.paymentSourceLabel, 'Al Rajhi Mada');
    });

    test('persists USD commitment with conversion fields', () async {
      final db = _memoryDb();
      addTearDown(db.close);
      final repository = CommitmentRepository(db);
      final commitment = testCommitment(
        id: 'usd-1',
        name: 'ChatGPT',
        amount: 20,
        currency: 'USD',
        reportingCurrency: 'SAR',
        estimatedReportingAmount: 75,
        exchangeRate: 3.75,
        paymentMethod: PaymentMethod.card,
        paymentSourceLabel: 'Al Rajhi Visa',
      );

      await repository.upsert(commitment);
      final loaded = await repository.getCommitment('usd-1');

      expect(loaded?.currency, 'USD');
      expect(loaded?.reportingCurrency, 'SAR');
      expect(loaded?.estimatedReportingAmount, 75);
      expect(loaded?.exchangeRate, 3.75);
      expect(loaded?.paymentSourceLabel, 'Al Rajhi Visa');
    });
  });

  group('TemplateRepository', () {
    test('seeds built-in templates', () async {
      final db = _memoryDb();
      addTearDown(db.close);
      final repository = TemplateRepository(db);
      await repository.upsertAll(TemplateSeedLibrary.builtInTemplates());

      final templates = await repository.getTemplates();
      expect(templates.length, AppConstants.builtInTemplateCount);
      expect(templates.any((t) => t.id == 'netflix'), isTrue);
      expect(templates.firstWhere((t) => t.id == 'netflix').defaultCurrency, 'USD');
    });
  });

  group('SettingsRepository', () {
    test('watchSettings reflects persisted values', () async {
      final db = _memoryDb();
      addTearDown(db.close);
      final repository = SettingsRepository(db);
      const settings = AppSettingsModel(
        localePreference: AppLocalePreference.ar,
        notificationsEnabled: false,
        defaultCurrency: 'USD',
      );

      await repository.saveSettings(settings);
      final watched = await repository.watchSettings().first;
      expect(watched.localePreference, AppLocalePreference.ar);
      expect(watched.notificationsEnabled, isFalse);
      expect(watched.defaultCurrency, 'USD');
    });

    test('loadSettings reads persisted values', () async {
      final db = _memoryDb();
      addTearDown(db.close);
      final repository = SettingsRepository(db);
      const settings = AppSettingsModel(
        localePreference: AppLocalePreference.en,
        notificationsEnabled: true,
        defaultCurrency: 'SAR',
      );

      await repository.saveSettings(settings);
      final loaded = await repository.loadSettings();
      expect(loaded.localePreference, AppLocalePreference.en);
      expect(loaded.defaultCurrency, 'SAR');
    });
  });
}
