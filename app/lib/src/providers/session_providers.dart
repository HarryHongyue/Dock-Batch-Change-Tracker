import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/change_event_model.dart';
import '../data/models/change_session_model.dart';
import '../data/repositories/change_event_repository.dart';
import '../data/repositories/change_session_repository.dart';
import 'database_provider.dart';

final activeSessionProvider = FutureProvider.autoDispose
    .family<ChangeSessionModel?, String>((ref, warehouseId) async {
  final db = await ref.watch(databaseProvider.future);
  return ChangeSessionRepository(db).getActiveSession(warehouseId);
});

final sessionEventsProvider = FutureProvider.autoDispose
    .family<List<ChangeEventModel>, String>((ref, sessionId) async {
  final db = await ref.watch(databaseProvider.future);
  return ChangeEventRepository(db).getBySessionId(sessionId);
});

final sessionListProvider = FutureProvider.autoDispose
    .family<List<ChangeSessionModel>, String>((ref, warehouseId) async {
  final db = await ref.watch(databaseProvider.future);
  return ChangeSessionRepository(db).getByWarehouseId(warehouseId);
});

final dockEventsProvider = FutureProvider.autoDispose
    .family<List<ChangeEventModel>, String>((ref, dockId) async {
  final db = await ref.watch(databaseProvider.future);
  return ChangeEventRepository(db).getByDockId(dockId);
});

final warehouseEventsProvider = FutureProvider.autoDispose
    .family<List<ChangeEventModel>, String>((ref, warehouseId) async {
  final db = await ref.watch(databaseProvider.future);
  return ChangeEventRepository(db).getByWarehouseId(warehouseId);
});
