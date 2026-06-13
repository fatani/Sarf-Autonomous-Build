import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sarf/app/app.dart';
import 'package:sarf/app/providers.dart';
import 'package:sarf/core/crash/crash_log_service.dart';
import 'package:sarf/core/crash/error_screen.dart';
import 'package:sarf/l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final crashLogService = CrashLogService();
  installGlobalErrorHandlers(crashLogService);
  ErrorWidget.builder = (details) => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const SarfErrorScreen(),
      );
  runApp(
    ProviderScope(
      overrides: [
        crashLogServiceProvider.overrideWithValue(crashLogService),
      ],
      child: const SarfApp(),
    ),
  );
}
