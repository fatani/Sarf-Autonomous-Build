import 'package:drift_flutter/drift_flutter.dart' as drift_flutter;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sarf/database/app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase(
    drift_flutter.driftDatabase(
      name: 'sarf_db',
      native: const drift_flutter.DriftNativeOptions(shareAcrossIsolates: true),
    ),
  );
  ref.onDispose(db.close);
  return db;
});
