import 'package:drift/drift.dart';
import 'package:sarf/core/constants/app_constants.dart';
import 'package:sarf/database/tables/tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Commitments,
    ServiceTemplates,
    AppSettings,
    NotificationSchedules,
    SchemaMeta,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => AppConstants.schemaVersion;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await into(schemaMeta).insert(
            SchemaMetaCompanion(
              version: Value(schemaVersion),
              migratedAt: Value(DateTime.now().toUtc()),
            ),
          );
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 1) {
            await m.createAll();
          }
          if (from < 2) {
            await m.createTable(notificationSchedules);
          }
          if (from < 3) {
            await customStatement(
              "UPDATE commitments SET category = 'entertainment' WHERE category = 'subscription'",
            );
            await customStatement(
              "UPDATE commitments SET category = 'utilities' WHERE category = 'utility'",
            );
            await customStatement(
              "UPDATE commitments SET category = 'other' WHERE category IN ('rent', 'finance')",
            );
            await customStatement(
              "UPDATE service_templates SET category = 'entertainment' WHERE category = 'subscription'",
            );
            await customStatement(
              "UPDATE service_templates SET category = 'utilities' WHERE category = 'utility'",
            );
            await customStatement(
              "UPDATE service_templates SET category = 'other' WHERE category IN ('rent', 'finance')",
            );
          }
          await into(schemaMeta).insertOnConflictUpdate(
            SchemaMetaCompanion(
              version: Value(to),
              migratedAt: Value(DateTime.now().toUtc()),
            ),
          );
        },
      );
}
