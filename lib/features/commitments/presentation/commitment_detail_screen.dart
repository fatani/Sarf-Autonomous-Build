import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sarf/app/providers.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/core/utils/formatters.dart';
import 'package:sarf/features/commitments/application/commitment_actions.dart';
import 'package:sarf/features/commitments/presentation/commitment_form_sheet.dart';
import 'package:sarf/l10n/app_localizations.dart';

class CommitmentDetailScreen extends ConsumerWidget {
  const CommitmentDetailScreen({required this.commitmentId, super.key});

  final String commitmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final commitmentAsync = ref.watch(commitmentDetailProvider(commitmentId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.commitmentDetailsTitle),
        actions: [
          ...commitmentAsync.maybeWhen(
            data: (commitment) {
              if (commitment == null || commitment.isDeleted) {
                return <Widget>[];
              }
              return [
                IconButton(
                  tooltip: l10n.edit,
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () => _openEditForm(context, commitment),
                ),
              ];
            },
            orElse: () => <Widget>[],
          ),
        ],
      ),
      body: commitmentAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(
          child: FilledButton(
            onPressed: () => ref.invalidate(commitmentDetailProvider(commitmentId)),
            child: Text(l10n.retry),
          ),
        ),
        data: (commitment) {
          if (commitment == null) {
            return Center(child: Text(l10n.errorGeneric));
          }
          return _DetailBody(
            commitment: commitment,
            locale: locale,
            onPauseToggle: () => ref
                .read(commitmentActionsProvider)
                .setPaused(commitment.id, !commitment.isPaused),
            onDelete: () => _confirmDelete(context, ref, commitment),
          );
        },
      ),
    );
  }

  Future<void> _openEditForm(BuildContext context, CommitmentModel commitment) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => CommitmentFormSheet(existing: commitment),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    CommitmentModel commitment,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteCommitment),
        content: Text(l10n.deleteCommitmentConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.delete)),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await ref.read(commitmentActionsProvider).softDelete(commitment.id);
      if (context.mounted) {
        context.pop();
      }
    }
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({
    required this.commitment,
    required this.locale,
    required this.onPauseToggle,
    required this.onDelete,
  });

  final CommitmentModel commitment;
  final Locale locale;
  final VoidCallback onPauseToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final days = DateUtilsSarf.daysUntil(commitment.nextDueDate, DateTime.now());
    final dueLabel = days < 0
        ? l10n.overdue
        : days == 0
            ? l10n.dueToday
            : l10n.dueInDays(days);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(commitment.name, style: theme.textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(
                  Formatters.commitmentAmountLine(commitment, locale, l10n),
                  style: theme.textTheme.titleLarge,
                ),
                if (Formatters.paymentSourceLine(commitment, l10n) case final paymentLine?) ...[
                  const SizedBox(height: 8),
                  Text(
                    paymentLine,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _DetailTile(label: l10n.billingCycleLabel, value: Formatters.billingCycleLabel(commitment.billingCycle, l10n)),
        _DetailTile(label: l10n.categoryLabel, value: Formatters.categoryLabel(commitment.category, l10n)),
        _DetailTile(label: l10n.nextDueDateLabel, value: Formatters.date(commitment.nextDueDate, locale)),
        _DetailTile(label: l10n.upcomingDues, value: dueLabel),
        if (commitment.reminderDaysBefore != null)
          _DetailTile(
            label: l10n.reminderDaysLabel,
            value: l10n.reminderDaysOption(commitment.reminderDaysBefore!),
          ),
        _DetailTile(
          label: l10n.paymentMethodLabel,
          value: Formatters.paymentMethodLabel(commitment.paymentMethod, l10n),
        ),
        if (commitment.paymentSourceLabel != null &&
            commitment.paymentSourceLabel!.trim().isNotEmpty)
          _DetailTile(label: l10n.paymentSourceLabel, value: commitment.paymentSourceLabel!),
        if (commitment.hasForeignCurrency) ...[
          _DetailTile(
            label: l10n.paidAmountInReportingCurrency(commitment.reportingCurrency),
            value: Formatters.money(
              commitment.paidReportingAmount,
              commitment.reportingCurrency,
              locale,
            ),
          ),
          if (Formatters.effectiveRateLine(commitment, l10n) case final rateLine?)
            _DetailTile(label: l10n.effectiveRateLabel, value: rateLine),
        ],
        if (commitment.notes != null && commitment.notes!.isNotEmpty)
          _DetailTile(label: l10n.notesLabel, value: commitment.notes!),
        if (commitment.isPaused)
          _DetailTile(label: l10n.paused, value: l10n.paused),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onPauseToggle,
                child: Text(commitment.isPaused ? l10n.resumeCommitment : l10n.pauseCommitment),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.tonal(
                onPressed: onDelete,
                child: Text(l10n.delete),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(label),
        subtitle: Text(value),
      ),
    );
  }
}

final commitmentDetailProvider = StreamProvider.family<CommitmentModel?, String>((ref, id) {
  ref.watch(appBootstrapProvider);
  return ref.watch(commitmentRepositoryProvider).watchCommitment(id);
});
