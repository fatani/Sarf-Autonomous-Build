import 'package:drift/drift.dart';
import 'package:sarf/core/constants/app_constants.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/database/app_database.dart';

class CommitmentRepository {
  CommitmentRepository(this._db);

  final AppDatabase _db;

  Stream<List<CommitmentModel>> watchCommitments({bool includeDeleted = false}) {
    final query = _db.select(_db.commitments)
      ..orderBy([(row) => OrderingTerm.asc(row.nextDueDate)]);

    if (!includeDeleted) {
      query.where((row) => row.deletedAt.isNull());
    }

    return query.watch().map((rows) => rows.map(_mapRow).toList());
  }

  Stream<CommitmentModel?> watchCommitment(String id) {
    return (_db.select(_db.commitments)..where((row) => row.id.equals(id)))
        .watchSingleOrNull()
        .map((row) => row == null ? null : _mapRow(row));
  }

  Future<CommitmentModel?> getCommitment(String id) async {
    final row = await (_db.select(_db.commitments)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _mapRow(row);
  }

  Future<void> upsert(CommitmentModel commitment) async {
    await _db.into(_db.commitments).insertOnConflictUpdate(
          CommitmentsCompanion(
            id: Value(commitment.id),
            name: Value(commitment.name),
            amount: Value(commitment.amount),
            currency: Value(commitment.currency),
            billingCycle: Value(commitment.billingCycle.storageKey),
            category: Value(commitment.category.storageKey),
            nextDueDate: Value(commitment.nextDueDate),
            reminderDaysBefore: Value(commitment.reminderDaysBefore),
            notes: Value(commitment.notes),
            templateId: Value(commitment.templateId),
            isPaused: Value(commitment.isPaused),
            deletedAt: Value(commitment.deletedAt),
            createdAt: Value(commitment.createdAt),
            updatedAt: Value(commitment.updatedAt),
          ),
        );
  }

  Future<void> softDelete(String id) async {
    final now = DateTime.now().toUtc();
    await (_db.update(_db.commitments)..where((t) => t.id.equals(id))).write(
      CommitmentsCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> restore(String id) async {
    final now = DateTime.now().toUtc();
    await (_db.update(_db.commitments)..where((t) => t.id.equals(id))).write(
      CommitmentsCompanion(
        deletedAt: const Value(null),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> setPaused(String id, bool paused) async {
    final now = DateTime.now().toUtc();
    await (_db.update(_db.commitments)..where((t) => t.id.equals(id))).write(
      CommitmentsCompanion(
        isPaused: Value(paused),
        updatedAt: Value(now),
      ),
    );
  }

  Future<List<CommitmentModel>> getActiveCommitments() async {
    final rows = await (_db.select(_db.commitments)
          ..where((t) => t.deletedAt.isNull())
          ..where((t) => t.isPaused.equals(false)))
        .get();
    return rows.map(_mapRow).toList();
  }

  CommitmentModel _mapRow(Commitment row) {
    return CommitmentModel(
      id: row.id,
      name: row.name,
      amount: row.amount,
      currency: row.currency,
      billingCycle: BillingCycle.fromStorage(row.billingCycle),
      category: CommitmentCategory.fromStorage(row.category),
      nextDueDate: row.nextDueDate,
      reminderDaysBefore: row.reminderDaysBefore,
      notes: row.notes,
      templateId: row.templateId,
      isPaused: row.isPaused,
      deletedAt: row.deletedAt,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}

class SettingsRepository {
  SettingsRepository(this._db);

  final AppDatabase _db;

  static const _localeKey = 'locale';
  static const _notificationsKey = 'notifications_enabled';
  static const _currencyKey = 'default_currency';
  static const _firstLaunchKey = 'first_launch_at';

  Stream<AppSettingsModel> watchSettings() {
    return _db.select(_db.appSettings).watch().map(_mapRows);
  }

  Future<AppSettingsModel> getSettings() async {
    final rows = await _db.select(_db.appSettings).get();
    return _mapRows(rows);
  }

  AppSettingsModel _mapRows(List<AppSetting> rows) {
    final map = {for (final row in rows) row.key: row.value};
    return AppSettingsModel(
      localePreference: AppLocalePreference.fromStorage(map[_localeKey]),
      notificationsEnabled: map[_notificationsKey] != 'false',
      defaultCurrency: map[_currencyKey] ?? AppConstants.defaultCurrency,
    );
  }

  Future<AppSettingsModel> loadSettings() async {
    final rows = await _db.select(_db.appSettings).get();
    return _mapRows(rows);
  }

  Future<void> saveSettings(AppSettingsModel settings) async {
    await _db.batch((batch) {
      batch.insertAllOnConflictUpdate(
        _db.appSettings,
        [
          AppSettingsCompanion.insert(key: _localeKey, value: settings.localePreference.storageKey),
          AppSettingsCompanion.insert(
            key: _notificationsKey,
            value: settings.notificationsEnabled.toString(),
          ),
          AppSettingsCompanion.insert(key: _currencyKey, value: settings.defaultCurrency),
        ],
      );
    });
  }

  Future<DateTime?> getFirstLaunchAt() async {
    final row = await (_db.select(_db.appSettings)..where((t) => t.key.equals(_firstLaunchKey)))
        .getSingleOrNull();
    if (row == null) {
      return null;
    }
    return DateTime.tryParse(row.value);
  }

  Future<DateTime> ensureFirstLaunchAt() async {
    final existing = await getFirstLaunchAt();
    if (existing != null) {
      return existing;
    }
    final now = DateTime.now().toUtc();
    await _db.into(_db.appSettings).insertOnConflictUpdate(
          AppSettingsCompanion.insert(
            key: _firstLaunchKey,
            value: now.toIso8601String(),
          ),
        );
    return now;
  }
}

class TemplateRepository {
  TemplateRepository(this._db);

  final AppDatabase _db;

  Stream<List<ServiceTemplateModel>> watchTemplates() {
    return (_db.select(_db.serviceTemplates)
          ..orderBy([(t) => OrderingTerm.asc(t.nameEn)]))
        .watch()
        .map((rows) => rows.map(_mapRow).toList());
  }

  Future<List<ServiceTemplateModel>> getTemplates() async {
    final rows = await (_db.select(_db.serviceTemplates)
          ..orderBy([(t) => OrderingTerm.asc(t.nameEn)]))
        .get();
    return rows.map(_mapRow).toList();
  }

  Future<ServiceTemplateModel?> getTemplate(String id) async {
    final row =
        await (_db.select(_db.serviceTemplates)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _mapRow(row);
  }

  Future<int> countTemplates() async {
    final count = _db.serviceTemplates.id.count();
    final query = _db.selectOnly(_db.serviceTemplates)..addColumns([count]);
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }

  Future<void> upsertAll(List<ServiceTemplateModel> templates) async {
    await _db.batch((batch) {
      batch.insertAllOnConflictUpdate(
        _db.serviceTemplates,
        templates.map(_toCompanion).toList(),
      );
    });
  }

  ServiceTemplatesCompanion _toCompanion(ServiceTemplateModel template) {
    return ServiceTemplatesCompanion(
      id: Value(template.id),
      nameEn: Value(template.nameEn),
      nameAr: Value(template.nameAr),
      category: Value(template.category.storageKey),
      defaultAmount: Value(template.defaultAmount),
      defaultBillingCycle: Value(template.defaultBillingCycle.storageKey),
      iconName: Value(template.iconName),
      isBuiltIn: Value(template.isBuiltIn),
    );
  }

  ServiceTemplateModel _mapRow(ServiceTemplate row) {
    return ServiceTemplateModel(
      id: row.id,
      nameEn: row.nameEn,
      nameAr: row.nameAr,
      category: CommitmentCategory.fromStorage(row.category),
      defaultAmount: row.defaultAmount,
      defaultBillingCycle: BillingCycle.fromStorage(row.defaultBillingCycle),
      iconName: row.iconName,
      isBuiltIn: row.isBuiltIn,
    );
  }
}

class NotificationScheduleRepository {
  NotificationScheduleRepository(this._db);

  final AppDatabase _db;

  Future<void> replaceForCommitment({
    required String commitmentId,
    required List<ScheduledNotificationRecord> schedules,
  }) async {
    await _db.transaction(() async {
      await (_db.delete(_db.notificationSchedules)
            ..where((t) => t.commitmentId.equals(commitmentId)))
          .go();
      if (schedules.isNotEmpty) {
        await _db.batch((batch) {
          batch.insertAll(
            _db.notificationSchedules,
            schedules.map((schedule) => NotificationSchedulesCompanion(
                  id: Value(schedule.id),
                  commitmentId: Value(schedule.commitmentId),
                  scheduledAt: Value(schedule.scheduledAt),
                  notificationId: Value(schedule.notificationId),
                  status: Value(schedule.status),
                )),
          );
        });
      }
    });
  }

  Future<List<ScheduledNotificationRecord>> getForCommitment(String commitmentId) async {
    final rows = await (_db.select(_db.notificationSchedules)
          ..where((t) => t.commitmentId.equals(commitmentId)))
        .get();
    return rows.map(_mapRow).toList();
  }

  Future<List<ScheduledNotificationRecord>> getAllScheduled() async {
    final rows = await (_db.select(_db.notificationSchedules)
          ..where((t) => t.status.equals('scheduled')))
        .get();
    return rows.map(_mapRow).toList();
  }

  Future<void> markCancelled(String id) async {
    await (_db.update(_db.notificationSchedules)..where((t) => t.id.equals(id))).write(
      const NotificationSchedulesCompanion(status: Value('cancelled')),
    );
  }

  ScheduledNotificationRecord _mapRow(NotificationSchedule row) {
    return ScheduledNotificationRecord(
      id: row.id,
      commitmentId: row.commitmentId,
      scheduledAt: row.scheduledAt,
      notificationId: row.notificationId,
      status: row.status,
    );
  }
}

class ScheduledNotificationRecord {
  const ScheduledNotificationRecord({
    required this.id,
    required this.commitmentId,
    required this.scheduledAt,
    required this.notificationId,
    required this.status,
  });

  final String id;
  final String commitmentId;
  final DateTime scheduledAt;
  final int notificationId;
  final String status;
}
