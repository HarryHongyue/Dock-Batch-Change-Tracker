import 'package:drift/drift.dart';

enum DockStatus {
  active,
  paused,
  empty,
  closed,
  blocked,
  maintenance,
}

enum BatchStatus {
  waiting,
  active,
  paused,
  completed,
  cancelled,
  unknown,
}

enum ChangeSessionStatus {
  draft,
  completed,
  cancelled,
  corrected,
}

enum EventType {
  batchCreated,
  batchAssigned,
  batchMoved,
  batchModified,
  batchReceived,
  statusChanged,
  batchesSwapped,
  batchCompleted,
  batchPaused,
  batchResumed,
  batchRemoved,
  dockPaused,
  dockResumed,
  dockStatusChanged,
  dockCreated,
  dockRenamed,
  correction,
  manualNote,
}

enum SnapshotType {
  manual,
  beforeChange,
  afterChange,
  daily,
  automatic,
}

abstract class EnumToString<T extends Enum> extends TypeConverter<T, String> {
  final List<T> values;
  final T defaultValue;

  const EnumToString(this.values, this.defaultValue);

  @override
  T fromSql(String fromDb) {
    return values.firstWhere(
      (e) => e.name == fromDb,
      orElse: () => defaultValue,
    );
  }

  @override
  String toSql(T value) => value.name;
}

class DockStatusConverter extends EnumToString<DockStatus> {
  const DockStatusConverter() : super(DockStatus.values, DockStatus.empty);
}

class BatchStatusConverter extends EnumToString<BatchStatus> {
  const BatchStatusConverter() : super(BatchStatus.values, BatchStatus.unknown);
}

class ChangeSessionStatusConverter extends EnumToString<ChangeSessionStatus> {
  const ChangeSessionStatusConverter()
      : super(ChangeSessionStatus.values, ChangeSessionStatus.draft);
}

class EventTypeConverter extends EnumToString<EventType> {
  const EventTypeConverter() : super(EventType.values, EventType.manualNote);
}

class SnapshotTypeConverter extends EnumToString<SnapshotType> {
  const SnapshotTypeConverter()
      : super(SnapshotType.values, SnapshotType.manual);
}
