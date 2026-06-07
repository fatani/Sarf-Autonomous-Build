import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sarf/app/providers.dart';
import 'package:sarf/core/utils/formatters.dart';
import 'package:sarf/l10n/app_localizations.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final reportAsync = ref.watch(reportProvider);
    final locale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.reportsTitle)),
      body: reportAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(
          child: FilledButton(
            onPressed: () => ref.invalidate(reportProvider),
            child: Text(l10n.retry),
          ),
        ),
        data: (report) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(l10n.reportsSubtitle, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.reportPeriod, style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: 4),
                      Text(report.periodLabel, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 12),
                      Text(l10n.reportTotal, style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: 4),
                      Text(
                        Formatters.money(report.totalMonthly, report.currency, locale),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(l10n.activeCount(report.activeCount)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(l10n.byCategory, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              if (report.byCategory.isEmpty)
                Text(l10n.commitmentsEmptyTitle)
              else
                ...report.byCategory.entries.map(
                  (entry) => Card(
                    child: ListTile(
                      title: Text(Formatters.categoryLabel(entry.key, l10n)),
                      trailing: Text(Formatters.money(entry.value, report.currency, locale)),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
