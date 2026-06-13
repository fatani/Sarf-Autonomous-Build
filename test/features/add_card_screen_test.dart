import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sarf/features/cards/presentation/add_card_screen.dart';
import 'package:sarf/l10n/app_localizations.dart';

void main() {
  testWidgets('Add Card screen preview updates when last4 entered', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const AddCardScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Al Rajhi • Visa • Infinite • •••• 1331'), findsNothing);

    await tester.tap(find.text('Infinite'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField), '1331');
    await tester.pumpAndSettle();

    expect(find.text('Al Rajhi • Visa • Infinite • •••• 1331'), findsOneWidget);
  });
}
