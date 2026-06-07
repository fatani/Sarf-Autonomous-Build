import 'package:flutter/widgets.dart';
import 'package:sarf/core/domain/enums.dart';
import 'package:sarf/l10n/app_localizations.dart';

abstract final class LocaleUtils {
  static Locale resolveNotificationLocale(AppLocalePreference preference) {
    return switch (preference) {
      AppLocalePreference.ar => const Locale('ar'),
      AppLocalePreference.en => const Locale('en'),
      AppLocalePreference.system => _systemLocale(),
    };
  }

  static AppLocalizations notificationLocalizations(AppLocalePreference preference) {
    return lookupAppLocalizations(resolveNotificationLocale(preference));
  }

  static Locale _systemLocale() {
    final system = WidgetsBinding.instance.platformDispatcher.locale;
    if (system.languageCode == 'ar') {
      return const Locale('ar');
    }
    return const Locale('en');
  }
}
