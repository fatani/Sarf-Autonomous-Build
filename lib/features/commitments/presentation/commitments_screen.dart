import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sarf/app/providers.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/core/utils/formatters.dart';
import 'package:sarf/features/commitments/application/commitment_actions.dart';
import 'package:sarf/features/commitments/presentation/commitment_form_sheet.dart';
import 'package:sarf/l10n/app_localizations.dart';

class CommitmentsScreen extends ConsumerWidget {
  const CommitmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final commitmentsAsync = ref.watch(commitmentsProvider);
    final showArchived = ref.watch(showArchivedProvider);
    final archivedAsync = ref.watch(archivedCommitmentsProvider);
    final locale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.commitmentsTitle),
        actions: [
          IconButton(
            tooltip: showArchived ? l10n.hideArchived : l10n.showArchived,
            onPressed: () {
              ref.read(showArchivedProvider.notifier).state = !showArchived;
            },
            icon: Icon(showArchived ? Icons.inventory_2 : Icons.inventory_2_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(context),
        icon: const Icon(Icons.add),
        label: Text(l10n.addCommitment),
      ),
      body: commitmentsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorState(
          message: l10n.errorGeneric,
          onRetry: () => ref.invalidate(commitmentsProvider),
        ),
        data: (commitments) {
          final active = commitments.where((item) => !item.isDeleted).toList();
          if (active.isEmpty && !showArchived) {
            return _EmptyState(
              title: l10n.commitmentsEmptyTitle,
              body: l10n.commitmentsEmptyBody,
            );
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            children: [
              if (active.isNotEmpty)
                ...active.map(
                  (commitment) => _CommitmentCard(
                    commitment: commitment,
                    locale: locale,
                    onTap: () => context.push('/commitments/${commitment.id}'),
                    onPauseToggle: () => ref
                        .read(commitmentActionsProvider)
                        .setPaused(commitment.id, !commitment.isPaused),
                    onDelete: () => _confirmDelete(context, ref, commitment),
                  ),
                ),
              if (showArchived)
                archivedAsync.when(
                  loading: () => const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (_, _) => const SizedBox.shrink(),
                  data: (archived) {
                    if (archived.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Text(l10n.archived, style: Theme.of(context).textTheme.titleMedium),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        Text(l10n.archived, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        ...archived.map(
                          (commitment) => _CommitmentCard(
                            commitment: commitment,
                            locale: locale,
                            archived: true,
                            onTap: () {},
                            onRestore: () =>
                                ref.read(commitmentActionsProvider).restore(commitment.id),
                          ),
                        ),
                      ],
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _openForm(BuildContext context, {CommitmentModel? commitment}) {
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
    if (confirmed == true) {
      await ref.read(commitmentActionsProvider).softDelete(commitment.id);
    }
  }
}

class _CommitmentCard extends StatelessWidget {
  const _CommitmentCard({
    required this.commitment,
    required this.locale,
    required this.onTap,
    this.onPauseToggle,
    this.onDelete,
    this.onRestore,
    this.archived = false,
  });

  final CommitmentModel commitment;
  final Locale locale;
  final VoidCallback onTap;
  final VoidCallback? onPauseToggle;
  final VoidCallback? onDelete;
  final VoidCallback? onRestore;
  final bool archived;

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

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: archived ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      commitment.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        decoration: archived ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                  Text(
                    Formatters.money(commitment.amount, commitment.currency, locale),
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  Chip(
                    visualDensity: VisualDensity.compact,
                    label: Text(Formatters.billingCycleLabel(commitment.billingCycle, l10n)),
                  ),
                  Chip(
                    visualDensity: VisualDensity.compact,
                    label: Text(dueLabel),
                  ),
                  if (commitment.isPaused)
                    Chip(
                      visualDensity: VisualDensity.compact,
                      label: Text(l10n.paused),
                    ),
                ],
              ),
              if (!archived) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: onPauseToggle,
                      child: Text(commitment.isPaused ? l10n.resumeCommitment : l10n.pauseCommitment),
                    ),
                    TextButton(onPressed: onDelete, child: Text(l10n.delete)),
                  ],
                ),
              ] else if (onRestore != null) ...[
                const SizedBox(height: 8),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(onPressed: onRestore, child: Text(l10n.restore)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long_outlined, size: 56, color: theme.colorScheme.outline),
            const SizedBox(height: 16),
            Text(title, style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(
              body,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(height: 12),
          FilledButton(onPressed: onRetry, child: Text(l10n.retry)),
        ],
      ),
    );
  }
}
