import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

String generateId() => _uuid.v4();

String formatDateTime(DateTime? dt, {String pattern = 'yyyy-MM-dd HH:mm'}) {
  if (dt == null) return '-';
  return DateFormat(pattern).format(dt);
}

String formatShortDateTime(DateTime? dt) {
  if (dt == null) return '-';
  return DateFormat('yyyy.MM.dd HH:mm').format(dt);
}

String formatTime(DateTime? dt, {bool hour24 = true}) {
  if (dt == null) return '-';
  final pattern = hour24 ? 'HH:mm' : 'hh:mm a';
  return DateFormat(pattern).format(dt);
}

String formatDate(DateTime? dt, {String pattern = 'yyyy-MM-dd'}) {
  if (dt == null) return '-';
  return DateFormat(pattern).format(dt);
}

String displayBatchCode(String code, {int? maxLength}) {
  if (maxLength == null || code.length <= maxLength) return code;
  final prefix = code.substring(0, (maxLength / 2).ceil());
  final suffix = code.substring(code.length - (maxLength / 2).floor());
  return '$prefix…$suffix';
}

String? emptyToNull(String value) => value.trim().isEmpty ? null : value.trim();
