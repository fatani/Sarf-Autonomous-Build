import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sarf/database/app_database.dart';
import 'package:sarf/features/shared/data/repositories.dart';

AppDatabase _memoryDb() => AppDatabase(NativeDatabase.memory());

void main() {
  test('onboarding does not show after completion is saved', () async {
    final db = _memoryDb();
    addTearDown(db.close);
    final repository = SettingsRepository(db);

    expect(await repository.isOnboardingCompleted(), isFalse);
    await repository.setOnboardingCompleted(true);
    expect(await repository.isOnboardingCompleted(), isTrue);
  });
}
