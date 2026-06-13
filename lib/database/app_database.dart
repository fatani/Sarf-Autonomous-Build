import 'package:drift/drift.dart';
import 'package:sarf/core/constants/app_constants.dart';
import 'package:sarf/database/tables/tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Commitments,
    PaymentCards,
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
          if (from < 4) {
            await m.addColumn(commitments, commitments.reportingCurrency);
            await m.addColumn(commitments, commitments.paidReportingAmount);
            await m.addColumn(commitments, commitments.exchangeRate);
            await m.addColumn(commitments, commitments.paymentMethod);
            await m.addColumn(commitments, commitments.paymentSourceLabel);
            await customStatement('''
              UPDATE commitments SET
                reporting_currency = '${AppConstants.defaultCurrency}',
                paid_reporting_amount = amount,
                exchange_rate = 1.0,
                payment_method = 'card'
            ''');
            await m.addColumn(serviceTemplates, serviceTemplates.defaultCurrency);
          }
          if (from < 5 && from >= 4) {
            await customStatement(
              'ALTER TABLE commitments RENAME COLUMN estimated_reporting_amount TO paid_reporting_amount',
            );
            await customStatement('''
              UPDATE commitments SET exchange_rate = paid_reporting_amount / amount
              WHERE currency != reporting_currency AND amount > 0
            ''');
          }
          if (from < 6) {
            await m.createTable(paymentCards);
            await m.addColumn(commitments, commitments.cardId);
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
