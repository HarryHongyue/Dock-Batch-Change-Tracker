import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../data/services/database_service.dart';

final databaseProvider = FutureProvider<AppDatabase>((ref) async {
  final service = DatabaseService();
  final db = await service.open();
  ref.onDispose(() async {
    await service.close();
  });
  return db;
});
