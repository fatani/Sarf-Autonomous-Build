import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sarf/app/providers.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/features/commitments/presentation/commitments_screen.dart';
import 'package:sarf/l10n/app_localizations.dart';

class _TestSettingsNotifier extends SettingsNotifier {
  @override
  Future<AppSettingsModel> build() async {
    return const AppSettingsModel(
      localePreference: AppLocalePreference.en,
      notificationsEnabled: true,
      defaultCurrency: 'SAR',
    );
  }
}

void main() {
  testWidgets('commitments screen shows empty state', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appBootstrapProvider.overrideWith((ref) async {}),
          commitmentsProvider.overrideWith((ref) => Stream.value(const [])),
          settingsProvider.overrideWith(_TestSettingsNotifier.new),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const CommitmentsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No commitments yet'), findsOneWidget);
    expect(find.text('Add commitment'), findsOneWidget);
  });

  test('supported locales include Arabic and English', () {
    expect(AppLocalizations.supportedLocales, contains(const Locale('en')));
    expect(AppLocalizations.supportedLocales, contains(const Locale('ar')));
  });
}
