import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/core/utils/locale_utils.dart';
import 'package:sarf/database/database_provider.dart';
import 'package:sarf/features/insights/domain/insights_service.dart';
import 'package:sarf/features/notifications/data/local_notification_service.dart';
import 'package:sarf/features/reports/domain/reports_service.dart';
import 'package:sarf/features/shared/data/repositories.dart';
import 'package:sarf/features/templates/data/bootstrap_service.dart';

final commitmentRepositoryProvider = Provider<CommitmentRepository>((ref) {
  return CommitmentRepository(ref.watch(appDatabaseProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(ref.watch(appDatabaseProvider));
});

final templateRepositoryProvider = Provider<TemplateRepository>((ref) {
  return TemplateRepository(ref.watch(appDatabaseProvider));
});

final notificationScheduleRepositoryProvider = Provider<NotificationScheduleRepository>((ref) {
  return NotificationScheduleRepository(ref.watch(appDatabaseProvider));
});

final localNotificationServiceProvider = Provider<LocalNotificationService>((ref) {
  return LocalNotificationService(
    ref.watch(notificationScheduleRepositoryProvider),
    ref.watch(settingsRepositoryProvider),
  );
});

final bootstrapServiceProvider = Provider<BootstrapService>((ref) {
  return BootstrapService(ref.watch(templateRepositoryProvider));
});

final insightsServiceProvider = Provider<InsightsService>((ref) {
  return InsightsService();
});

final reportsServiceProvider = Provider<ReportsService>((ref) {
  return ReportsService();
});

final appBootstrapProvider = FutureProvider<void>((ref) async {
  await ref.watch(bootstrapServiceProvider).ensureSeeded();
  await ref.watch(settingsRepositoryProvider).ensureFirstLaunchAt();
  await ref.watch(localNotificationServiceProvider).initialize();
  final settings = await ref.watch(settingsRepositoryProvider).loadSettings();
  if (settings.notificationsEnabled) {
    final commitments = await ref.watch(commitmentRepositoryProvider).getActiveCommitments();
    final l10n = LocaleUtils.notificationLocalizations(settings.localePreference);
    await ref.watch(localNotificationServiceProvider).rescheduleAll(
          commitments: commitments,
          notificationsEnabled: settings.notificationsEnabled,
          defaultCurrency: settings.defaultCurrency,
          notificationTitle: l10n.notificationTitle,
          notificationBody: (name, amount, date) => l10n.notificationBody(name, amount, date),
          trialReminderTitle: l10n.trialReminderTitle,
          trialReminderBody: (days) => l10n.trialReminderBody(days),
          weeklyDigestTitle: l10n.weeklyDigestTitle,
          weeklyDigestBody: (count, amount) => l10n.weeklyDigestBody(count, amount),
        );
  }
});

final settingsProvider = AsyncNotifierProvider<SettingsNotifier, AppSettingsModel>(
  SettingsNotifier.new,
);

class SettingsNotifier extends AsyncNotifier<AppSettingsModel> {
  @override
  Future<AppSettingsModel> build() async {
    final repository = ref.watch(settingsRepositoryProvider);
    return repository.loadSettings();
  }

  Future<void> updateSettings(AppSettingsModel settings) async {
    final repository = ref.read(settingsRepositoryProvider);
    await repository.saveSettings(settings);
    state = AsyncData(settings);
  }
}

final localeProvider = Provider<Locale?>((ref) {
  final settings = ref.watch(settingsProvider);
  return settings.maybeWhen(
    data: (value) => switch (value.localePreference) {
      AppLocalePreference.system => null,
      AppLocalePreference.en => const Locale('en'),
      AppLocalePreference.ar => const Locale('ar'),
    },
    orElse: () => null,
  );
});

final commitmentsProvider = StreamProvider<List<CommitmentModel>>((ref) {
  ref.watch(appBootstrapProvider);
  return ref.watch(commitmentRepositoryProvider).watchCommitments();
});

final archivedCommitmentsProvider = StreamProvider<List<CommitmentModel>>((ref) {
  ref.watch(appBootstrapProvider);
  return ref
      .watch(commitmentRepositoryProvider)
      .watchCommitments(includeDeleted: true)
      .map((items) => items.where((item) => item.isDeleted).toList());
});

final templatesProvider = StreamProvider<List<ServiceTemplateModel>>((ref) {
  ref.watch(appBootstrapProvider);
  return ref.watch(templateRepositoryProvider).watchTemplates();
});

final insightsProvider = Provider<AsyncValue<InsightsSummary>>((ref) {
  final commitments = ref.watch(commitmentsProvider);
  final settings = ref.watch(settingsProvider);

  return commitments.when(
    data: (items) {
      final currency = settings.maybeWhen(
        data: (value) => value.defaultCurrency,
        orElse: () => 'SAR',
      );
      return AsyncData(
        ref.watch(insightsServiceProvider).calculate(
              commitments: items,
              defaultCurrency: currency,
            ),
      );
    },
    loading: () => const AsyncLoading(),
    error: AsyncError.new,
  );
});

final reportProvider = Provider<AsyncValue<SpendingReport>>((ref) {
  final commitments = ref.watch(commitmentsProvider);
  final settings = ref.watch(settingsProvider);

  return commitments.when(
    data: (items) {
      final currency = settings.maybeWhen(
        data: (value) => value.defaultCurrency,
        orElse: () => 'SAR',
      );
      return AsyncData(
        ref.watch(reportsServiceProvider).generate(
              commitments: items,
              defaultCurrency: currency,
            ),
      );
    },
    loading: () => const AsyncLoading(),
    error: AsyncError.new,
  );
});

final showArchivedProvider = StateProvider<bool>((ref) => false);
