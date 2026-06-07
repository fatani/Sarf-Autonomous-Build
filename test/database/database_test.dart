import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sarf/core/constants/app_constants.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/database/app_database.dart';
import 'package:sarf/features/shared/data/repositories.dart';
import 'package:sarf/features/templates/data/template_seed.dart';

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
  group('AppDatabase', () {
    test('schemaVersion is 3', () {
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
      final commitment = _sampleCommitment();

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
      await repository.upsert(_sampleCommitment());
      await repository.softDelete('c1');
      await repository.restore('c1');

      final active = await repository.getActiveCommitments();
      expect(active, hasLength(1));
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
