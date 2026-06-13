import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sarf/app/app.dart';
import 'package:sarf/app/providers.dart';
import 'package:sarf/core/crash/crash_log_service.dart';
import 'package:sarf/core/domain/models.dart';
import 'package:sarf/database/app_database.dart';
import 'package:sarf/database/database_provider.dart';
import 'package:sarf/features/shared/data/repositories.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  List<Override> appOverrides() {
    return [
      appDatabaseProvider.overrideWithValue(db),
      appBootstrapProvider.overrideWith((ref) async {}),
      crashLogServiceProvider.overrideWithValue(CrashLogService()),
      commitmentsProvider.overrideWith(
        (ref) => Stream.value(const <CommitmentModel>[]),
      ),
      archivedCommitmentsProvider.overrideWith(
        (ref) => Stream.value(const <CommitmentModel>[]),
      ),
      templatesProvider.overrideWith(
        (ref) => Stream.value(const <ServiceTemplateModel>[]),
      ),
    ];
  }

  Widget buildSarfApp() {
    return ProviderScope(
      overrides: appOverrides(),
      child: const SarfApp(),
    );
  }

  testWidgets('SarfApp shows onboarding on first launch then main app after skip', (tester) async {
    await tester.pumpWidget(buildSarfApp());
    await tester.pumpAndSettle();

    expect(find.text('Know what you need to pay this month.'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('No commitments yet'), findsNothing);

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.text('No commitments yet'), findsOneWidget);
    expect(find.text('Know what you need to pay this month.'), findsNothing);
    expect(find.text('Commitments'), findsWidgets);

    final settingsRepository = SettingsRepository(db);
    expect(await settingsRepository.isOnboardingCompleted(), isTrue);
  });

  testWidgets('SarfApp does not show onboarding after completion is persisted', (tester) async {
    await SettingsRepository(db).setOnboardingCompleted(true);

    await tester.pumpWidget(buildSarfApp());
    await tester.pumpAndSettle();

    expect(find.text('No commitments yet'), findsOneWidget);
    expect(find.text('Know what you need to pay this month.'), findsNothing);
  });

  testWidgets('SarfApp shows onboarding then main app after Start on last page', (tester) async {
    await tester.pumpWidget(buildSarfApp());
    await tester.pumpAndSettle();

    expect(find.text('Know what you need to pay this month.'), findsOneWidget);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Add your first commitment and start clearly.'), findsOneWidget);
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();

    expect(find.text('No commitments yet'), findsOneWidget);
    expect(find.text('Know what you need to pay this month.'), findsNothing);

    final settingsRepository = SettingsRepository(db);
    expect(await settingsRepository.isOnboardingCompleted(), isTrue);
  });
}
