import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('weekly digest scheduling does not use matchDateTimeComponents', () {
    final source = File(
      'lib/features/notifications/data/local_notification_service.dart',
    ).readAsStringSync();

    expect(source, isNot(contains('matchDateTimeComponents')));
  });
}
