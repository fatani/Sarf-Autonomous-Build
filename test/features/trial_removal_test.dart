import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('trial reminder code is removed from notification service', () {
    final source = File(
      'lib/features/notifications/data/local_notification_service.dart',
    ).readAsStringSync();

    expect(source, isNot(contains('syncTrialReminder')));
    expect(source, isNot(contains('trialReminder')));
    expect(source, isNot(contains('trialPeriodDays')));
  });

  test('trial constants are removed from app constants', () {
    final source = File('lib/core/constants/app_constants.dart').readAsStringSync();

    expect(source, isNot(contains('trialPeriodDays')));
    expect(source, isNot(contains('trialReminderDaysBefore')));
  });
}
