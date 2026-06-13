import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sarf/app/providers.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/features/commitments/presentation/commitment_form_sheet.dart';
import 'package:sarf/l10n/app_localizations.dart';

class _TestSettingsNotifier extends SettingsNotifier {
  _TestSettingsNotifier(this.settings);

  final AppSettingsModel settings;

  @override
  Future<AppSettingsModel> build() async => settings;
}

void main() {
  Future<void> pumpForm(WidgetTester tester, {String defaultCurrency = 'SAR'}) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          settingsProvider.overrideWith(
            () => _TestSettingsNotifier(
              AppSettingsModel(
                localePreference: AppLocalePreference.en,
                notificationsEnabled: false,
                defaultCurrency: defaultCurrency,
              ),
            ),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => const CommitmentFormSheet(),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
  }

  testWidgets('SAR form hides paid amount and exchange rate fields', (tester) async {
    await pumpForm(tester);
    expect(find.text('Exchange rate'), findsNothing);
    expect(find.text('Paid amount in SAR'), findsNothing);
  });

  testWidgets('USD form shows paid amount in SAR, not exchange rate', (tester) async {
    await pumpForm(tester);
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('USD').last);
    await tester.pumpAndSettle();

    expect(find.text('Paid amount in SAR'), findsOneWidget);
    expect(find.text('Exchange rate'), findsNothing);
  });
}
