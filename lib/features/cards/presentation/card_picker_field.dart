import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sarf/app/providers.dart';
import 'package:sarf/app/router.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/core/utils/payment_card_display.dart';
import 'package:sarf/l10n/app_localizations.dart';

class CardPickerField extends ConsumerWidget {
  const CardPickerField({
    required this.selectedCardId,
    required this.onChanged,
    super.key,
  });

  final String? selectedCardId;
  final ValueChanged<String?> onChanged;

  static const noCardValue = '__none__';
  static const addCardValue = '__add__';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final cardsAsync = ref.watch(activePaymentCardsProvider);

    return cardsAsync.when(
      loading: () => const LinearProgressIndicator(),
      error: (_, _) => Text(l10n.errorGeneric),
      data: (cards) {
        if (cards.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.commitmentCardHint,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => _addCard(context, ref),
                icon: const Icon(Icons.add),
                label: Text(l10n.addCard),
              ),
            ],
          );
        }

        return DropdownButtonFormField<String>(
          key: ValueKey(selectedCardId),
          initialValue: selectedCardId ?? noCardValue,
          decoration: InputDecoration(labelText: l10n.commitmentCardLabel),
          items: [
            DropdownMenuItem(value: noCardValue, child: Text(l10n.noCardSelected)),
            ...cards.map(
              (card) => DropdownMenuItem(
                value: card.id,
                child: Text(PaymentCardDisplay.shortLabel(card, l10n)),
              ),
            ),
            DropdownMenuItem(value: addCardValue, child: Text(l10n.addNewCard)),
          ],
          onChanged: (value) async {
            if (value == addCardValue) {
              await _addCard(context, ref);
              return;
            }
            onChanged(value == noCardValue ? null : value);
          },
        );
      },
    );
  }

  Future<void> _addCard(BuildContext context, WidgetRef ref) async {
    final result = await context.push<PaymentCardModel?>(AppRoute.addCard.path);
    if (result != null) {
      onChanged(result.id);
    }
  }
}
