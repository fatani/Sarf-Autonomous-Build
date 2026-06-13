import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sarf/app/providers.dart';
import 'package:sarf/features/cards/presentation/add_card_screen.dart';
import 'package:sarf/l10n/app_localizations.dart';

class EditCardScreen extends ConsumerWidget {
  const EditCardScreen({required this.cardId, super.key});

  final String cardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return FutureBuilder(
      future: ref.read(paymentCardRepositoryProvider).getCard(cardId),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.editCard)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        final card = snapshot.data;
        if (card == null) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.editCard)),
            body: Center(child: Text(l10n.errorGeneric)),
          );
        }
        return AddCardScreen(existing: card);
      },
    );
  }
}
