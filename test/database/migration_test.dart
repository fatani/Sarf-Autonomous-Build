import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sarf/core/constants/app_constants.dart';
import 'package:sarf/database/app_database.dart';
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
}
