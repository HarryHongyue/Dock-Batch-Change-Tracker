import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../database.dart';

class DatabaseService {
  late final AppDatabase db;
  bool _isOpen = false;

  Future<AppDatabase> open({bool inMemory = false}) async {
    if (_isOpen) return db;

    if (inMemory) {
      db = AppDatabase(NativeDatabase.memory());
    } else {
      final directory = await getApplicationDocumentsDirectory();
      final file = File(p.join(directory.path, 'dockflow.db'));
      db = AppDatabase(NativeDatabase.createInBackground(file));
    }

    _isOpen = true;
    return db;
  }

  Future<void> close() async {
    if (_isOpen) {
      await db.close();
      _isOpen = false;
    }
  }
}
