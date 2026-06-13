import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sarf/core/constants/app_constants.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/database/app_database.dart';
import 'package:sarf/features/shared/data/repositories.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

void _createLegacyV1Schema(sqlite.Database db) {
  db.execute('''
CREATE TABLE IF NOT EXISTS "commitments" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "name" TEXT NOT NULL,
  "amount" REAL NOT NULL,
  "currency" TEXT NOT NULL,
  "billing_cycle" TEXT NOT NULL,
  "category" TEXT NOT NULL,
  "next_due_date" INTEGER NOT NULL,
  "reminder_days_before" INTEGER,
  "notes" TEXT,
  "template_id" TEXT,
  "is_paused" INTEGER NOT NULL DEFAULT 0 CHECK ("is_paused" IN (0, 1)),
  "deleted_at" INTEGER,
  "created_at" INTEGER NOT NULL,
  "updated_at" INTEGER NOT NULL
);
''');
  db.execute('''
CREATE TABLE IF NOT EXISTS "service_templates" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "name_en" TEXT NOT NULL,
  "name_ar" TEXT NOT NULL,
  "category" TEXT NOT NULL,
  "default_amount" REAL,
  "default_billing_cycle" TEXT NOT NULL,
  "icon_name" TEXT NOT NULL DEFAULT 'receipt_long',
  "is_built_in" INTEGER NOT NULL DEFAULT 1 CHECK ("is_built_in" IN (0, 1))
);
''');
  db.execute('''
CREATE TABLE IF NOT EXISTS "app_settings" (
  "key" TEXT NOT NULL PRIMARY KEY,
  "value" TEXT NOT NULL
);
''');
  db.execute('''
CREATE TABLE IF NOT EXISTS "schema_meta" (
  "version" INTEGER NOT NULL PRIMARY KEY,
  "migrated_at" INTEGER NOT NULL
);
''');
  db.execute(
    "INSERT INTO schema_meta (version, migrated_at) VALUES (1, '${DateTime.utc(2025, 1, 1).toIso8601String()}')",
  );
  db.execute(
    "INSERT INTO commitments (id, name, amount, currency, billing_cycle, category, next_due_date, created_at, updated_at) "
    "VALUES ('legacy-1', 'Legacy Rent', 2500, 'SAR', 'monthly', 'rent', '${DateTime.utc(2026, 3, 1).toIso8601String()}', "
    "'${DateTime.utc(2025, 6, 1).toIso8601String()}', '${DateTime.utc(2025, 6, 1).toIso8601String()}')",
  );
  db.execute('PRAGMA user_version = 1');
}

void _createLegacyV3Schema(sqlite.Database db) {
  db.execute('''
CREATE TABLE IF NOT EXISTS "commitments" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "name" TEXT NOT NULL,
  "amount" REAL NOT NULL,
  "currency" TEXT NOT NULL,
  "billing_cycle" TEXT NOT NULL,
  "category" TEXT NOT NULL,
  "next_due_date" INTEGER NOT NULL,
  "reminder_days_before" INTEGER,
  "notes" TEXT,
  "template_id" TEXT,
  "is_paused" INTEGER NOT NULL DEFAULT 0 CHECK ("is_paused" IN (0, 1)),
  "deleted_at" INTEGER,
  "created_at" INTEGER NOT NULL,
  "updated_at" INTEGER NOT NULL
);
''');
  db.execute('''
CREATE TABLE IF NOT EXISTS "service_templates" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "name_en" TEXT NOT NULL,
  "name_ar" TEXT NOT NULL,
  "category" TEXT NOT NULL,
  "default_amount" REAL,
  "default_billing_cycle" TEXT NOT NULL,
  "icon_name" TEXT NOT NULL DEFAULT 'receipt_long',
  "is_built_in" INTEGER NOT NULL DEFAULT 1 CHECK ("is_built_in" IN (0, 1))
);
''');
  db.execute('''
CREATE TABLE IF NOT EXISTS "notification_schedules" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "commitment_id" TEXT NOT NULL,
  "scheduled_at" INTEGER NOT NULL,
  "notification_id" INTEGER NOT NULL,
  "status" TEXT NOT NULL DEFAULT 'scheduled'
);
''');
  db.execute('''
CREATE TABLE IF NOT EXISTS "schema_meta" (
  "version" INTEGER NOT NULL PRIMARY KEY,
  "migrated_at" INTEGER NOT NULL
);
''');
  db.execute(
    "INSERT INTO schema_meta (version, migrated_at) VALUES (3, '${DateTime.utc(2026, 1, 1).toIso8601String()}')",
  );
  db.execute(
    "INSERT INTO commitments (id, name, amount, currency, billing_cycle, category, next_due_date, created_at, updated_at) "
    "VALUES ('usd-legacy', 'ChatGPT', 20, 'USD', 'monthly', 'work', '${DateTime.utc(2026, 3, 1).toIso8601String()}', "
    "'${DateTime.utc(2025, 6, 1).toIso8601String()}', '${DateTime.utc(2025, 6, 1).toIso8601String()}')",
  );
  db.execute('PRAGMA user_version = 3');
}

void _createLegacyV4Schema(sqlite.Database db) {
  db.execute('''
CREATE TABLE IF NOT EXISTS "commitments" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "name" TEXT NOT NULL,
  "amount" REAL NOT NULL,
  "currency" TEXT NOT NULL,
  "billing_cycle" TEXT NOT NULL,
  "category" TEXT NOT NULL,
  "next_due_date" INTEGER NOT NULL,
  "reminder_days_before" INTEGER,
  "notes" TEXT,
  "template_id" TEXT,
  "is_paused" INTEGER NOT NULL DEFAULT 0 CHECK ("is_paused" IN (0, 1)),
  "deleted_at" INTEGER,
  "created_at" INTEGER NOT NULL,
  "updated_at" INTEGER NOT NULL,
  "reporting_currency" TEXT NOT NULL DEFAULT 'SAR',
  "estimated_reporting_amount" REAL NOT NULL DEFAULT 0,
  "exchange_rate" REAL,
  "payment_method" TEXT NOT NULL DEFAULT 'card',
  "payment_source_label" TEXT
);
''');
  db.execute('''
CREATE TABLE IF NOT EXISTS "service_templates" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "name_en" TEXT NOT NULL,
  "name_ar" TEXT NOT NULL,
  "category" TEXT NOT NULL,
  "default_amount" REAL,
  "default_billing_cycle" TEXT NOT NULL,
  "icon_name" TEXT NOT NULL DEFAULT 'receipt_long',
  "is_built_in" INTEGER NOT NULL DEFAULT 1 CHECK ("is_built_in" IN (0, 1)),
  "default_currency" TEXT
);
''');
  db.execute('''
CREATE TABLE IF NOT EXISTS "notification_schedules" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "commitment_id" TEXT NOT NULL,
  "scheduled_at" INTEGER NOT NULL,
  "notification_id" INTEGER NOT NULL,
  "status" TEXT NOT NULL DEFAULT 'scheduled'
);
''');
  db.execute('''
CREATE TABLE IF NOT EXISTS "schema_meta" (
  "version" INTEGER NOT NULL PRIMARY KEY,
  "migrated_at" INTEGER NOT NULL
);
''');
  db.execute(
    "INSERT INTO schema_meta (version, migrated_at) VALUES (4, '${DateTime.utc(2026, 3, 1).toIso8601String()}')",
  );
  db.execute(
    "INSERT INTO commitments (id, name, amount, currency, billing_cycle, category, next_due_date, created_at, updated_at, "
    "reporting_currency, estimated_reporting_amount, exchange_rate, payment_method) "
    "VALUES ('usd-v4', 'ChatGPT', 20, 'USD', 'monthly', 'work', '${DateTime.utc(2026, 3, 1).toIso8601String()}', "
    "'${DateTime.utc(2025, 6, 1).toIso8601String()}', '${DateTime.utc(2025, 6, 1).toIso8601String()}', "
    "'SAR', 75, 3.75, 'card')",
  );
  db.execute('PRAGMA user_version = 4');
}

void _createLegacyV5Schema(sqlite.Database db) {
  db.execute('''
CREATE TABLE IF NOT EXISTS "commitments" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "name" TEXT NOT NULL,
  "amount" REAL NOT NULL,
  "currency" TEXT NOT NULL,
  "billing_cycle" TEXT NOT NULL,
  "category" TEXT NOT NULL,
  "next_due_date" INTEGER NOT NULL,
  "reminder_days_before" INTEGER,
  "notes" TEXT,
  "template_id" TEXT,
  "is_paused" INTEGER NOT NULL DEFAULT 0 CHECK ("is_paused" IN (0, 1)),
  "deleted_at" INTEGER,
  "created_at" INTEGER NOT NULL,
  "updated_at" INTEGER NOT NULL,
  "reporting_currency" TEXT NOT NULL DEFAULT 'SAR',
  "paid_reporting_amount" REAL NOT NULL DEFAULT 0,
  "exchange_rate" REAL,
  "payment_method" TEXT NOT NULL DEFAULT 'card',
  "payment_source_label" TEXT
);
''');
  db.execute('''
CREATE TABLE IF NOT EXISTS "service_templates" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "name_en" TEXT NOT NULL,
  "name_ar" TEXT NOT NULL,
  "category" TEXT NOT NULL,
  "default_amount" REAL,
  "default_billing_cycle" TEXT NOT NULL,
  "icon_name" TEXT NOT NULL DEFAULT 'receipt_long',
  "is_built_in" INTEGER NOT NULL DEFAULT 1 CHECK ("is_built_in" IN (0, 1)),
  "default_currency" TEXT
);
''');
  db.execute('''
CREATE TABLE IF NOT EXISTS "notification_schedules" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "commitment_id" TEXT NOT NULL,
  "scheduled_at" INTEGER NOT NULL,
  "notification_id" INTEGER NOT NULL,
  "status" TEXT NOT NULL DEFAULT 'scheduled'
);
''');
  db.execute('''
CREATE TABLE IF NOT EXISTS "schema_meta" (
  "version" INTEGER NOT NULL PRIMARY KEY,
  "migrated_at" INTEGER NOT NULL
);
''');
  db.execute(
    "INSERT INTO schema_meta (version, migrated_at) VALUES (5, '${DateTime.utc(2026, 4, 1).toIso8601String()}')",
  );
  db.execute(
    "INSERT INTO commitments (id, name, amount, currency, billing_cycle, category, next_due_date, created_at, updated_at, "
    "reporting_currency, paid_reporting_amount, payment_method, payment_source_label) "
    "VALUES ('v5-card', 'Netflix', 49, 'SAR', 'monthly', 'entertainment', '${DateTime.utc(2026, 3, 1).toIso8601String()}', "
    "'${DateTime.utc(2025, 6, 1).toIso8601String()}', '${DateTime.utc(2025, 6, 1).toIso8601String()}', "
    "'SAR', 49, 'card', 'Al Rajhi Visa')",
  );
  db.execute('PRAGMA user_version = 5');
}

void main() {
  test('migration from schema v1 to v2 adds notification schedules and preserves data', () async {
    final rawDb = sqlite.sqlite3.openInMemory();
    addTearDown(rawDb.dispose);

    _createLegacyV1Schema(rawDb);

    final tablesBefore = rawDb.select("SELECT name FROM sqlite_master WHERE type = 'table'");
    final namesBefore = tablesBefore.map((row) => row['name'] as String).toSet();
    expect(namesBefore, isNot(contains('notification_schedules')));

    final executor = NativeDatabase.opened(rawDb);
    final db = AppDatabase(executor);
    addTearDown(db.close);

    expect(db.schemaVersion, AppConstants.schemaVersion);

    final tablesAfter = await db.customSelect(
      "SELECT name FROM sqlite_master WHERE type = 'table'",
    ).get();
    final namesAfter = tablesAfter.map((row) => row.read<String>('name')).toSet();

    expect(namesAfter, contains('notification_schedules'));
    expect(namesAfter, contains('commitments'));

    final legacyRow = await (db.select(db.commitments)..where((t) => t.id.equals('legacy-1')))
        .getSingleOrNull();
    expect(legacyRow?.name, 'Legacy Rent');
    expect(legacyRow?.amount, 2500);
  });

  test('migration from schema v3 adds currency and payment fields with defaults', () async {
    final rawDb = sqlite.sqlite3.openInMemory();
    addTearDown(rawDb.dispose);

    _createLegacyV3Schema(rawDb);

    final executor = NativeDatabase.opened(rawDb);
    final db = AppDatabase(executor);
    addTearDown(db.close);

    expect(db.schemaVersion, AppConstants.schemaVersion);

    final row = await (db.select(db.commitments)..where((t) => t.id.equals('usd-legacy')))
        .getSingleOrNull();
    expect(row?.reportingCurrency, AppConstants.defaultCurrency);
    expect(row?.paidReportingAmount, 20);
    expect(row?.paymentMethod, PaymentMethod.card.storageKey);

    final repository = CommitmentRepository(db);
    final commitment = await repository.getCommitment('usd-legacy');
    expect(commitment?.currency, 'USD');
    expect(commitment?.reportingCurrency, 'SAR');
    expect(commitment?.paidReportingAmount, 20);
  });

  test('migration from schema v4 renames estimated to paid amount and recomputes rate', () async {
    final rawDb = sqlite.sqlite3.openInMemory();
    addTearDown(rawDb.dispose);

    _createLegacyV4Schema(rawDb);

    final executor = NativeDatabase.opened(rawDb);
    final db = AppDatabase(executor);
    addTearDown(db.close);

    expect(db.schemaVersion, AppConstants.schemaVersion);

    final repository = CommitmentRepository(db);
    final commitment = await repository.getCommitment('usd-v4');
    expect(commitment?.paidReportingAmount, 75);
    expect(commitment?.exchangeRate, closeTo(3.75, 0.001));
  });

  test('migration from schema v5 adds payment cards table and cardId column', () async {
    final rawDb = sqlite.sqlite3.openInMemory();
    addTearDown(rawDb.dispose);

    _createLegacyV5Schema(rawDb);

    final executor = NativeDatabase.opened(rawDb);
    final db = AppDatabase(executor);
    addTearDown(db.close);

    expect(db.schemaVersion, AppConstants.schemaVersion);

    final tables = await db.customSelect(
      "SELECT name FROM sqlite_master WHERE type = 'table'",
    ).get();
    final names = tables.map((row) => row.read<String>('name')).toSet();
    expect(names, contains('payment_cards'));

    final row = await (db.select(db.commitments)..where((t) => t.id.equals('v5-card'))).getSingleOrNull();
    expect(row?.cardId, isNull);
    expect(row?.paymentSourceLabel, 'Al Rajhi Visa');
  });
}
