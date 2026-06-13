import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sarf/app/providers.dart';
import 'package:sarf/app/router.dart';
import 'package:sarf/core/crash/error_screen.dart';
import 'package:sarf/core/theme/sarf_theme.dart';
import 'package:sarf/features/onboarding/presentation/onboarding_screen.dart';
import 'package:sarf/l10n/app_localizations.dart';

class SarfApp extends ConsumerWidget {
  const SarfApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(appBootstrapProvider);
    final locale = ref.watch(localeProvider);
    final onboardingAsync = ref.watch(onboardingCompletedProvider);

    return onboardingAsync.when(
      loading: () => MaterialApp(
        theme: SarfTheme.light(),
        darkTheme: SarfTheme.dark(),
        themeMode: ThemeMode.system,
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      error: (_, _) => MaterialApp(
        theme: SarfTheme.light(),
        darkTheme: SarfTheme.dark(),
        themeMode: ThemeMode.system,
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const SarfErrorScreen(),
      ),
      data: (onboardingCompleted) {
        if (!onboardingCompleted) {
          return MaterialApp(
            theme: SarfTheme.light(),
            darkTheme: SarfTheme.dark(),
            themeMode: ThemeMode.system,
            locale: locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const OnboardingScreen(),
          );
        }

        return MaterialApp.router(
          onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
          theme: SarfTheme.light(),
          darkTheme: SarfTheme.dark(),
          themeMode: ThemeMode.system,
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: appRouter,
        );
      },
    );
  }
}
