import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sarf/app/providers.dart';
import 'package:sarf/app/router.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/core/utils/payment_card_display.dart';
import 'package:sarf/l10n/app_localizations.dart';

class CardsScreen extends ConsumerWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final cardsAsync = ref.watch(paymentCardsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.cardsSectionTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoute.addCard.path),
        icon: const Icon(Icons.add),
        label: Text(l10n.addCard),
      ),
      body: cardsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(
          child: FilledButton(
            onPressed: () => ref.invalidate(paymentCardsProvider),
            child: Text(l10n.retry),
          ),
        ),
        data: (cards) {
          final active = cards.where((card) => !card.isArchived).toList();
          final archived = cards.where((card) => card.isArchived).toList();

          if (cards.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  l10n.cardsEmptyHint,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            children: [
              ...active.map((card) => _CardTile(card: card)),
              if (archived.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text(l10n.archived, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                ...archived.map((card) => _CardTile(card: card, archived: true)),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _CardTile extends ConsumerWidget {
  const _CardTile({required this.card, this.archived = false});

  final PaymentCardModel card;
  final bool archived;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            archived ? Icons.credit_card_off_outlined : Icons.credit_card_outlined,
          ),
        ),
        title: Text(
          PaymentCardDisplay.preview(card, l10n),
          style: archived ? const TextStyle(decoration: TextDecoration.lineThrough) : null,
        ),
        subtitle: card.nickname != null ? Text(card.nickname!) : null,
        trailing: archived
            ? null
            : PopupMenuButton<String>(
                    onSelected: (value) async {
                  if (value == 'edit') {
                    if (context.mounted) {
                      await context.push('/settings/cards/${card.id}/edit');
                    }
                  } else if (value == 'archive') {
                    await ref.read(paymentCardRepositoryProvider).archive(card.id);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(value: 'edit', child: Text(l10n.edit)),
                  PopupMenuItem(value: 'archive', child: Text(l10n.archiveCard)),
                ],
              ),
      ),
    );
  }
}
