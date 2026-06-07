import 'package:drift/drift.dart';

class Commitments extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  RealColumn get amount => real()();
  TextColumn get currency => text()();
  TextColumn get billingCycle => text()();
  TextColumn get category => text()();
  DateTimeColumn get nextDueDate => dateTime()();
  IntColumn get reminderDaysBefore => integer().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get templateId => text().nullable()();
  BoolColumn get isPaused => boolean().withDefault(const Constant(false))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class ServiceTemplates extends Table {
  TextColumn get id => text()();
  TextColumn get nameEn => text()();
  TextColumn get nameAr => text()();
  TextColumn get category => text()();
  RealColumn get defaultAmount => real().nullable()();
  TextColumn get defaultBillingCycle => text()();
  TextColumn get iconName => text().withDefault(const Constant('receipt_long'))();
  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

class NotificationSchedules extends Table {
  TextColumn get id => text()();
  TextColumn get commitmentId => text()();
  DateTimeColumn get scheduledAt => dateTime()();
  IntColumn get notificationId => integer()();
  TextColumn get status => text().withDefault(const Constant('scheduled'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class SchemaMeta extends Table {
  IntColumn get version => integer()();
  DateTimeColumn get migratedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {version};
}
