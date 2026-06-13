import 'dart:convert';

import 'package:sarf/core/constants/app_constants.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/core/utils/commitment_currency.dart';
import 'package:sarf/features/shared/data/repositories.dart';

enum BackupImportResult {
  success,
  invalidAppName,
  unsupportedExportVersion,
  unsupportedSchemaVersion,
  invalidFormat,
}

/// Manual local backup/restore. Full restore after user confirmation.
class BackupService {
  BackupService(
    this._commitmentRepository,
    this._templateRepository,
    this._settingsRepository,
    this._notificationScheduleRepository,
    this._paymentCardRepository,
  );

  final CommitmentRepository _commitmentRepository;
  final TemplateRepository _templateRepository;
  final SettingsRepository _settingsRepository;
  final NotificationScheduleRepository _notificationScheduleRepository;
  final PaymentCardRepository _paymentCardRepository;

  Future<Map<String, dynamic>> exportBackup() async {
    final commitments = await _commitmentRepository.getAllCommitments();
    final customTemplates = await _templateRepository.getCustomTemplates();
    final settings = await _settingsRepository.getRawSettings();
    final schedules = await _notificationScheduleRepository.getAll();
    final cards = await _paymentCardRepository.getAllCards();

    return {
      'appName': AppConstants.appName,
      'exportVersion': AppConstants.backupExportVersion,
      'schemaVersion': AppConstants.schemaVersion,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'data': {
        'commitments': commitments.map(_commitmentToJson).toList(),
        'customTemplates': customTemplates.map(_templateToJson).toList(),
        'settings': settings,
        'notificationSchedules': schedules.map(_scheduleToJson).toList(),
        'paymentCards': cards.map(_cardToJson).toList(),
      },
    };
  }

  String encodeBackup(Map<String, dynamic> backup) {
    return const JsonEncoder.withIndent('  ').convert(backup);
  }

  BackupImportResult validateBackup(Map<String, dynamic> backup) {
    if (backup['appName'] != AppConstants.appName) {
      return BackupImportResult.invalidAppName;
    }
    if (backup['exportVersion'] != AppConstants.backupExportVersion) {
      return BackupImportResult.unsupportedExportVersion;
    }
    final schemaVersion = backup['schemaVersion'];
    if (schemaVersion is! int || schemaVersion > AppConstants.schemaVersion) {
      return BackupImportResult.unsupportedSchemaVersion;
    }
    final data = backup['data'];
    if (data is! Map<String, dynamic>) {
      return BackupImportResult.invalidFormat;
    }
    return BackupImportResult.success;
  }

  Future<BackupImportResult> restoreBackup(String jsonContent) async {
    final Map<String, dynamic> backup;
    try {
      backup = jsonDecode(jsonContent) as Map<String, dynamic>;
    } catch (_) {
      return BackupImportResult.invalidFormat;
    }

    final validation = validateBackup(backup);
    if (validation != BackupImportResult.success) {
      return validation;
    }

    final data = backup['data'] as Map<String, dynamic>;
    final commitments = _parseCommitments(data['commitments']);
    final customTemplates = _parseTemplates(data['customTemplates']);
    final settings = _parseSettings(data['settings']);
    settings['onboarding_completed'] = 'true';
    final schedules = _parseSchedules(data['notificationSchedules']);
    final cards = _parseCards(data['paymentCards']);

    await _commitmentRepository.replaceAll(commitments);
    await _templateRepository.replaceCustomTemplates(customTemplates);
    await _settingsRepository.replaceRawSettings(settings);
    await _notificationScheduleRepository.replaceAll(schedules);
    await _paymentCardRepository.replaceAll(cards);

    return BackupImportResult.success;
  }

  Map<String, dynamic> _commitmentToJson(CommitmentModel c) => {
        'id': c.id,
        'name': c.name,
        'amount': c.amount,
        'currency': c.currency,
        'reportingCurrency': c.reportingCurrency,
        'paidReportingAmount': c.paidReportingAmount,
        if (c.exchangeRate != null) 'exchangeRate': c.exchangeRate,
        'paymentMethod': c.paymentMethod.storageKey,
        if (c.paymentSourceLabel != null) 'paymentSourceLabel': c.paymentSourceLabel,
        if (c.cardId != null) 'cardId': c.cardId,
        'billingCycle': c.billingCycle.storageKey,
        'category': c.category.storageKey,
        'nextDueDate': c.nextDueDate.toUtc().toIso8601String(),
        'reminderDaysBefore': c.reminderDaysBefore,
        'notes': c.notes,
        'templateId': c.templateId,
        'isPaused': c.isPaused,
        'deletedAt': c.deletedAt?.toUtc().toIso8601String(),
        'createdAt': c.createdAt.toUtc().toIso8601String(),
        'updatedAt': c.updatedAt.toUtc().toIso8601String(),
      };

  CommitmentModel _commitmentFromJson(Map<String, dynamic> json) {
    return CommitmentCurrency.fromLegacyJsonFields(
      json: json,
      id: json['id'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      billingCycle: BillingCycle.fromStorage(json['billingCycle'] as String),
      category: CommitmentCategory.fromStorage(json['category'] as String),
      nextDueDate: DateTime.parse(json['nextDueDate'] as String),
      reminderDaysBefore: json['reminderDaysBefore'] as int?,
      notes: json['notes'] as String?,
      templateId: json['templateId'] as String?,
      isPaused: json['isPaused'] as bool? ?? false,
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> _cardToJson(PaymentCardModel card) => {
        'id': card.id,
        'network': card.network.storageKey,
        'bankName': card.bankName,
        if (card.cardTier != null) 'cardTier': card.cardTier!.storageKey,
        if (card.last4 != null) 'last4': card.last4,
        if (card.nickname != null) 'nickname': card.nickname,
        'isArchived': card.isArchived,
        'createdAt': card.createdAt.toUtc().toIso8601String(),
        'updatedAt': card.updatedAt.toUtc().toIso8601String(),
        if (card.archivedAt != null) 'archivedAt': card.archivedAt!.toUtc().toIso8601String(),
      };

  PaymentCardModel _cardFromJson(Map<String, dynamic> json) {
    return PaymentCardModel(
      id: json['id'] as String,
      network: CardNetwork.fromStorage(json['network'] as String?),
      bankName: json['bankName'] as String,
      cardTier: CardTier.fromStorage(json['cardTier'] as String?),
      last4: json['last4'] as String?,
      nickname: json['nickname'] as String?,
      isArchived: json['isArchived'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      archivedAt: json['archivedAt'] == null
          ? null
          : DateTime.parse(json['archivedAt'] as String),
    );
  }

  Map<String, dynamic> _templateToJson(ServiceTemplateModel t) => {
        'id': t.id,
        'nameEn': t.nameEn,
        'nameAr': t.nameAr,
        'category': t.category.storageKey,
        'defaultAmount': t.defaultAmount,
        'defaultBillingCycle': t.defaultBillingCycle.storageKey,
        'iconName': t.iconName,
        'isBuiltIn': t.isBuiltIn,
        if (t.defaultCurrency != null) 'defaultCurrency': t.defaultCurrency,
      };

  ServiceTemplateModel _templateFromJson(Map<String, dynamic> json) {
    return ServiceTemplateModel(
      id: json['id'] as String,
      nameEn: json['nameEn'] as String,
      nameAr: json['nameAr'] as String,
      category: CommitmentCategory.fromStorage(json['category'] as String),
      defaultAmount: (json['defaultAmount'] as num?)?.toDouble(),
      defaultBillingCycle:
          BillingCycle.fromStorage(json['defaultBillingCycle'] as String),
      iconName: json['iconName'] as String? ?? 'receipt_long',
      isBuiltIn: json['isBuiltIn'] as bool? ?? false,
      defaultCurrency: json['defaultCurrency'] as String?,
    );
  }

  Map<String, dynamic> _scheduleToJson(ScheduledNotificationRecord s) => {
        'id': s.id,
        'commitmentId': s.commitmentId,
        'scheduledAt': s.scheduledAt.toUtc().toIso8601String(),
        'notificationId': s.notificationId,
        'status': s.status,
      };

  ScheduledNotificationRecord _scheduleFromJson(Map<String, dynamic> json) {
    return ScheduledNotificationRecord(
      id: json['id'] as String,
      commitmentId: json['commitmentId'] as String,
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      notificationId: json['notificationId'] as int,
      status: json['status'] as String,
    );
  }

  List<CommitmentModel> _parseCommitments(Object? raw) {
    if (raw is! List) {
      return [];
    }
    return raw
        .whereType<Map<String, dynamic>>()
        .map(_commitmentFromJson)
        .toList();
  }

  List<ServiceTemplateModel> _parseTemplates(Object? raw) {
    if (raw is! List) {
      return [];
    }
    return raw.whereType<Map<String, dynamic>>().map(_templateFromJson).toList();
  }

  List<PaymentCardModel> _parseCards(Object? raw) {
    if (raw is! List) {
      return [];
    }
    return raw.whereType<Map<String, dynamic>>().map(_cardFromJson).toList();
  }

  Map<String, String> _parseSettings(Object? raw) {
    if (raw is! Map) {
      return {};
    }
    return raw.map((key, value) => MapEntry(key.toString(), value.toString()));
  }

  List<ScheduledNotificationRecord> _parseSchedules(Object? raw) {
    if (raw is! List) {
      return [];
    }
    return raw
        .whereType<Map<String, dynamic>>()
        .map(_scheduleFromJson)
        .toList();
  }
}
