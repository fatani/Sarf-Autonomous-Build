import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sarf/app/providers.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/features/onboarding/presentation/onboarding_screen.dart';
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
  testWidgets('onboarding shows on first launch', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appBootstrapProvider.overrideWith((ref) async {}),
          onboardingCompletedProvider.overrideWith((ref) async => false),
          settingsProvider.overrideWith(_TestSettingsNotifier.new),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const OnboardingScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Know what you need to pay this month.'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
  });

  testWidgets('onboarding strings are localized in Arabic', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appBootstrapProvider.overrideWith((ref) async {}),
          onboardingCompletedProvider.overrideWith((ref) async => false),
          settingsProvider.overrideWith(_TestSettingsNotifier.new),
        ],
        child: MaterialApp(
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const OnboardingScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('اعرف ما عليك دفعه هذا الشهر.'), findsOneWidget);
    expect(find.text('تخطي'), findsOneWidget);
  });
}
