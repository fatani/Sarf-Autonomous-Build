import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sarf/app/providers.dart';
import 'package:sarf/app/router.dart';
import 'package:sarf/core/utils/formatters.dart';
import 'package:sarf/core/utils/payment_card_display.dart';
import 'package:sarf/l10n/app_localizations.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final insightsAsync = ref.watch(insightsProvider);
    final locale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.insightsTitle)),
      body: insightsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: FilledButton(
            onPressed: () => ref.invalidate(insightsProvider),
            child: Text(l10n.retry),
          ),
        ),
        data: (summary) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _SummaryCard(
                title: l10n.monthlyTotal,
                value: Formatters.money(summary.monthlyTotal, summary.currency, locale),
                subtitle: l10n.activeCount(summary.activeCount),
              ),
              const SizedBox(height: 12),
              _SummaryCard(
                title: l10n.yearlyProjection,
                value: Formatters.money(summary.yearlyProjection, summary.currency, locale),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton.icon(
                  onPressed: () => context.push(AppRoute.reports.path),
                  icon: const Icon(Icons.summarize_outlined),
                  label: Text(l10n.viewReport),
                ),
              ),
              const SizedBox(height: 24),
              Text(l10n.mostExpensive, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              if (summary.mostExpensive.isEmpty)
                Text(l10n.commitmentsEmptyTitle)
              else
                ...summary.mostExpensive.map(
                  (commitment) => Card(
                    child: ListTile(
                      title: Text(commitment.name),
                      subtitle: Text(Formatters.categoryLabel(commitment.category, l10n)),
                      trailing: Text(
                        Formatters.commitmentAmountLine(commitment, locale, l10n),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              Text(l10n.spendingByCard, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              if (summary.byCard.isEmpty)
                Text(l10n.commitmentsEmptyTitle)
              else
                ...summary.byCard.map(
                  (entry) {
                    final cards = ref.watch(paymentCardsProvider).valueOrNull ?? [];
                    final cardMap = {for (final item in cards) item.id: item};
                    final card =
                        entry.cardId != null ? cardMap[entry.cardId] : null;
                    final title = card != null
                        ? PaymentCardDisplay.shortLabel(card, l10n)
                        : entry.fallbackLabel ?? '';
                    return Card(
                      child: ListTile(
                        title: Text(title),
                        subtitle: Text(l10n.cardCommitmentCount(entry.commitmentCount)),
                        trailing: Text(
                          Formatters.money(entry.monthlyTotal, summary.currency, locale),
                        ),
                      ),
                    );
                  },
                ),
              const SizedBox(height: 24),
              Text(l10n.byCategory, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              if (summary.byCategory.isEmpty)
                Text(
                  l10n.commitmentsEmptyTitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              else
                ...summary.byCategory.entries.map(
                  (entry) => Card(
                    child: ListTile(
                      title: Text(Formatters.categoryLabel(entry.key, l10n)),
                      trailing: Text(
                        Formatters.money(entry.value, summary.currency, locale),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              Text(l10n.upcomingDues, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              if (summary.upcoming.isEmpty)
                Text(l10n.commitmentsEmptyTitle)
              else
                ...summary.upcoming.map(
                  (commitment) {
                    final days = DateUtilsSarf.daysUntil(commitment.nextDueDate, DateTime.now());
                    final label = days < 0
                        ? l10n.overdue
                        : days == 0
                            ? l10n.dueToday
                            : l10n.dueInDays(days);
                    return Card(
                      child: ListTile(
                        title: Text(commitment.name),
                        subtitle: Text(label),
                        trailing: Text(
                          Formatters.commitmentAmountLine(commitment, locale, l10n),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    this.subtitle,
  });

  final String title;
  final String value;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            Text(value, style: theme.textTheme.headlineSmall),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(subtitle!, style: theme.textTheme.bodySmall),
            ],
          ],
        ),
      ),
    );
  }
}
