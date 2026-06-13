import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sarf/app/providers.dart';
import 'package:sarf/app/router.dart';
import 'package:sarf/core/constants/app_constants.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/core/utils/locale_utils.dart';
import 'package:sarf/features/settings/data/backup_service.dart';
import 'package:sarf/l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settingsAsync = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: settingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(
          child: FilledButton(
            onPressed: () => ref.invalidate(settingsProvider),
            child: Text(l10n.retry),
          ),
        ),
        data: (settings) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(l10n.languageLabel, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            SegmentedButton<AppLocalePreference>(
              segments: [
                ButtonSegment(value: AppLocalePreference.system, label: Text(l10n.systemDefault)),
                ButtonSegment(value: AppLocalePreference.en, label: Text(l10n.languageEnglish)),
                ButtonSegment(value: AppLocalePreference.ar, label: Text(l10n.languageArabic)),
              ],
              selected: {settings.localePreference},
              onSelectionChanged: (selection) {
                _updateSettings(ref, settings.copyWith(localePreference: selection.first));
              },
            ),
            const SizedBox(height: 24),
            Text(l10n.notificationsLabel, style: Theme.of(context).textTheme.titleMedium),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.notificationsEnabled),
              subtitle: Text(l10n.notificationsDisabledHint),
              value: settings.notificationsEnabled,
              onChanged: (value) async {
                if (value) {
                  final granted = await ref.read(localNotificationServiceProvider).requestPermissions();
                  if (!granted) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.notificationPermissionDenied)),
                      );
                    }
                    return;
                  }
                }
                await _updateSettings(ref, settings.copyWith(notificationsEnabled: value));
                await _rescheduleAll(ref, settings.copyWith(notificationsEnabled: value));
              },
            ),
            const SizedBox(height: 16),
            Text(l10n.defaultCurrencyLabel, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: ['SAR', 'USD', 'EUR', 'AED']
                  .map(
                    (currency) => ChoiceChip(
                      label: Text(currency),
                      selected: settings.defaultCurrency == currency,
                      onSelected: (_) {
                        _updateSettings(ref, settings.copyWith(defaultCurrency: currency));
                      },
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            Text(l10n.cardsSectionTitle, style: Theme.of(context).textTheme.titleMedium),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.cardsSectionTitle),
              subtitle: Text(l10n.cardsSectionSubtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(AppRoute.cards.path),
            ),
            const SizedBox(height: 24),
            Text(l10n.backupSection, style: Theme.of(context).textTheme.titleMedium),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.exportBackup),
              trailing: const Icon(Icons.upload_outlined),
              onTap: () => _exportBackup(context, ref),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.importBackup),
              trailing: const Icon(Icons.download_outlined),
              onTap: () => _importBackup(context, ref, settings),
            ),
            const SizedBox(height: 24),
            Text(l10n.diagnosticsSection, style: Theme.of(context).textTheme.titleMedium),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.exportCrashLog),
              subtitle: Text(l10n.exportCrashLogHint),
              trailing: const Icon(Icons.bug_report_outlined),
              onTap: () => _exportCrashLog(context, ref),
            ),
            const SizedBox(height: 24),
            Text(l10n.legalSection, style: Theme.of(context).textTheme.titleMedium),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.privacyPolicy),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(AppRoute.privacy.path),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.termsOfUse),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(AppRoute.terms.path),
            ),
            const SizedBox(height: 24),
            Text(l10n.aboutSection, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(l10n.aboutBody),
            const SizedBox(height: 8),
            Text('${l10n.versionLabel}: ${AppConstants.appVersion}'),
          ],
        ),
      ),
    );
  }

  Future<void> _updateSettings(WidgetRef ref, AppSettingsModel settings) {
    return ref.read(settingsProvider.notifier).updateSettings(settings);
  }

  Future<void> _rescheduleAll(WidgetRef ref, AppSettingsModel settings) async {
    final commitments = await ref.read(commitmentRepositoryProvider).getActiveCommitments();
    final l10n = LocaleUtils.notificationLocalizations(settings.localePreference);
    await ref.read(localNotificationServiceProvider).rescheduleAll(
          commitments: commitments,
          notificationsEnabled: settings.notificationsEnabled,
          defaultCurrency: settings.defaultCurrency,
          notificationTitle: l10n.notificationTitle,
          notificationBody: (name, amount, date) => l10n.notificationBody(name, amount, date),
          weeklyDigestTitle: l10n.weeklyDigestTitle,
          weeklyDigestBody: (count, amount) => l10n.weeklyDigestBody(count, amount),
        );
  }

  Future<void> _exportBackup(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    try {
      final backup = await ref.read(backupServiceProvider).exportBackup();
      final json = ref.read(backupServiceProvider).encodeBackup(backup);
      final timestamp = DateTime.now().toUtc().toIso8601String().replaceAll(':', '-');
      await Share.shareXFiles(
        [
          XFile.fromData(
            utf8.encode(json),
            name: 'sarf_backup_$timestamp.json',
            mimeType: 'application/json',
          ),
        ],
        subject: l10n.exportBackup,
      );
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.backupExportFailed)),
        );
      }
    }
  }

  Future<void> _importBackup(
    BuildContext context,
    WidgetRef ref,
    AppSettingsModel settings,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.importBackupConfirmTitle),
        content: Text(l10n.importBackupConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.importBackup),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) {
      return;
    }

    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      withData: true,
    );
    if (result == null || result.files.isEmpty || result.files.single.bytes == null) {
      return;
    }

    final jsonContent = String.fromCharCodes(result.files.single.bytes!);
    final importResult = await ref.read(backupServiceProvider).restoreBackup(jsonContent);

    if (!context.mounted) {
      return;
    }

    if (importResult == BackupImportResult.success) {
      ref.invalidate(settingsProvider);
      ref.invalidate(commitmentsProvider);
      ref.invalidate(templatesProvider);
      ref.invalidate(paymentCardsProvider);
      final updatedSettings = await ref.read(settingsProvider.future);
      await _rescheduleAll(ref, updatedSettings);
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.backupImportSuccess)),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_importErrorMessage(l10n, importResult))),
    );
  }

  String _importErrorMessage(AppLocalizations l10n, BackupImportResult result) {
    return switch (result) {
      BackupImportResult.invalidAppName => l10n.backupImportInvalidApp,
      BackupImportResult.unsupportedExportVersion => l10n.backupImportUnsupportedVersion,
      BackupImportResult.unsupportedSchemaVersion => l10n.backupImportUnsupportedSchema,
      BackupImportResult.invalidFormat => l10n.backupImportInvalidFormat,
      BackupImportResult.success => l10n.backupImportSuccess,
    };
  }

  Future<void> _exportCrashLog(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final text = await ref.read(crashLogServiceProvider).exportAsText();
    if (!context.mounted) {
      return;
    }
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.crashLogEmpty)),
      );
      return;
    }
    if (!context.mounted) {
      return;
    }
    await Share.share(text, subject: l10n.exportCrashLog);
  }
}
