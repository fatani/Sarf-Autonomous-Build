import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sarf/app/providers.dart';
import 'package:sarf/app/router.dart';
import 'package:sarf/core/constants/app_constants.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/core/utils/locale_utils.dart';
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
          trialReminderTitle: l10n.trialReminderTitle,
          trialReminderBody: (days) => l10n.trialReminderBody(days),
          weeklyDigestTitle: l10n.weeklyDigestTitle,
          weeklyDigestBody: (count, amount) => l10n.weeklyDigestBody(count, amount),
        );
  }
}
