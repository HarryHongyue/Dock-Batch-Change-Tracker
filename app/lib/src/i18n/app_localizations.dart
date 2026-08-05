
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/models/change_event_model.dart';
import '../data/models/enums.dart';

class AppLocalizations {
  final Locale locale;

  const AppLocalizations(this.locale);

  static const AppLocalizations _fallback = AppLocalizations(Locale('zh'));
  static AppLocalizations _current = _fallback;

  // ignore: unnecessary_getters_setters
  static AppLocalizations get current => _current;

  // ignore: unnecessary_getters_setters
  static set current(AppLocalizations value) {
    _current = value;
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        _fallback;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  bool get isEnglish => locale.languageCode == 'en';
  bool get isChinese => locale.languageCode == 'zh';

  static const _values = <String, Map<String, String>>{
    'zh': {
      'appName': '道口追踪',
      'appNameFull': 'DockFlow 道口追踪',
      'dockKanban': '道口看板',
      'settings': '设置',
      'warehouseList': '仓库列表',
      'startChange': '开始变更',
      'pause': '暂停',
      'resume': '恢复',
      'active': '作业',
      'empty': '空闲',
      'closed': '关闭',
      'blocked': '阻塞',
      'maintenance': '维护',
      'move': '移动',
      'modifyBatch': '修改批次',
      'createBatch': '创建批次',
      'history': '历史',
      'delete': '删除',
      'selected': '已选中',
      'addDock': '添加道口',
      'batchCreated': '创建批次',
      'batchMoved': '移动批次',
      'batchModified': '修改批次',
      'batchReceived': '接收批次',
      'statusChanged': '状态变更',
      'batchCompleted': '完成批次',
      'batchAssigned': '分配批次',
      'batchesSwapped': '交换批次',
      'batchPaused': '批次暂停',
      'batchResumed': '批次恢复',
      'batchRemoved': '移除批次',
      'dockPaused': '道口暂停',
      'dockResumed': '道口恢复',
      'dockStatusChanged': '道口状态变更',
      'dockCreated': '创建道口',
      'dockRenamed': '重命名道口',
      'correction': '更正',
      'manualNote': '手动备注',
      'loading': '加载中…',
      'noData': '暂无记录',
      'createWarehouse': '创建仓库',
      'warehouseName': '仓库名称',
      'warehouseDescription': '仓库描述',
      'dockCount': '道口数量',
      'dockName': '道口名称',
      'batchCode': '批次编号',
      'initialBatch': '初始批次（可为空）',
      'createAndStart': '创建仓库并开始使用',
      'batch': '批次',
      'dock': '道口',
      'status': '状态',
      'save': '保存',
      'cancel': '取消',
      'confirm': '确定',
      'ok': '确定',
      'error': '错误',
      'success': '成功',
      'language': '语言',
      'chinese': '简体中文',
      'english': 'English',
      'theme': '主题',
      'dark': '深色',
      'light': '浅色',
      'system': '跟随系统',
      'manage': '管理',
      'done': '完成',
      'addOneDock': '添加一个道口',
      'addManyDocks': '批量添加道口',
      'deleteSelectedDocks': '删除选中的道口',
      'deleteSelectedEvents': '删除选中的记录',
      'inputDockName': '输入道口名称',
      'inputDockCount': '输入要添加的道口数量',
      'countCannotBeNegative': '数量不能为负',
      'pleaseInputNumber': '请输入有效的整数',
      'about': '关于',
      'version': '版本',
      'manageHistory': '管理历史',
      'currentBatch': '当前批次',
      'noBatch': '当前无批次',
      'selectTargetDock': '选择目标道口',
      'hasBatch': '有批次',
      'moveSuccess': '移动成功',
      'moveFailed': '移动失败',
      'modifySuccess': '已改为',
      'modifyFailed': '修改失败',
      'dockPausedSnackbar': '道口已暂停',
      'dockResumedSnackbar': '道口已恢复',
      'pauseFailed': '暂停失败',
      'resumeFailed': '恢复失败',
      'createFailed': '创建失败',
      'loadFailed': '加载失败',
      'importFailed': '导入失败',
      'exportFailed': '导出失败',
      'seedFailed': '载入失败',
      'fileNotFound': '文件不存在',
      'recordsImported': '已导入 {0} 条记录',
      'testDataLoaded': '测试数据已载入',
      'invalidCount': '输入无效，按 0 处理',
      'batchCreatedPattern': '在 {0} 创建批次 {1}',
      'batchMovedPattern': '批次 {0} 移动到 {1}',
      'batchReceivedPattern': '从 {0} 接收批次 {1}',
      'batchModifiedPattern': '批次由 {0} 改为 {1}，旧批次已归档',
      'batchNewPattern': '新增批次 {0}',
      'batchCompletedPattern': '批次 {0} 在 {1} 完成',
      'dockPausedPattern': '{0} 已暂停',
      'dockResumedPattern': '{0} 已恢复',
      'statusChangedPattern': '{0} 状态变为 {1}',
      'dockAdjustment': '道口调整',
      'correctionPattern': '更正 {0}',
    },
    'en': {
      'appName': 'DockFlow',
      'appNameFull': 'DockFlow Tracker',
      'dockKanban': 'Dock Kanban',
      'settings': 'Settings',
      'warehouseList': 'Warehouses',
      'startChange': 'Start Change',
      'pause': 'Paused',
      'resume': 'Resume',
      'active': 'Active',
      'empty': 'Empty',
      'closed': 'Closed',
      'blocked': 'Blocked',
      'maintenance': 'Maintenance',
      'move': 'Move',
      'modifyBatch': 'Modify Batch',
      'createBatch': 'Create Batch',
      'history': 'History',
      'delete': 'Delete',
      'selected': 'Selected',
      'addDock': 'Add Dock',
      'batchCreated': 'Batch created',
      'batchMoved': 'Batch moved',
      'batchModified': 'Batch modified',
      'batchReceived': 'Batch received',
      'statusChanged': 'Status changed',
      'batchCompleted': 'Batch completed',
      'batchAssigned': 'Batch assigned',
      'batchesSwapped': 'Batches swapped',
      'batchPaused': 'Batch paused',
      'batchResumed': 'Batch resumed',
      'batchRemoved': 'Batch removed',
      'dockPaused': 'Dock paused',
      'dockResumed': 'Dock resumed',
      'dockStatusChanged': 'Dock status changed',
      'dockCreated': 'Dock created',
      'dockRenamed': 'Dock renamed',
      'correction': 'Correction',
      'manualNote': 'Manual note',
      'loading': 'Loading…',
      'noData': 'No records',
      'createWarehouse': 'Create Warehouse',
      'warehouseName': 'Warehouse name',
      'warehouseDescription': 'Description',
      'dockCount': 'Dock count',
      'dockName': 'Dock name',
      'batchCode': 'Batch code',
      'initialBatch': 'Initial batch (optional)',
      'createAndStart': 'Create warehouse and start',
      'batch': 'Batch',
      'dock': 'Dock',
      'status': 'Status',
      'save': 'Save',
      'cancel': 'Cancel',
      'confirm': 'Confirm',
      'ok': 'OK',
      'error': 'Error',
      'success': 'Success',
      'language': 'Language',
      'chinese': '简体中文',
      'english': 'English',
      'theme': 'Theme',
      'dark': 'Dark',
      'light': 'Light',
      'system': 'System',
      'manage': 'Manage',
      'done': 'Done',
      'addOneDock': 'Add a dock',
      'addManyDocks': 'Add multiple docks',
      'deleteSelectedDocks': 'Delete selected docks',
      'deleteSelectedEvents': 'Delete selected records',
      'inputDockName': 'Enter dock name',
      'inputDockCount': 'Enter number of docks to add',
      'countCannotBeNegative': 'Count cannot be negative',
      'pleaseInputNumber': 'Please enter a valid integer',
      'about': 'About',
      'version': 'Version',
      'manageHistory': 'Manage history',
      'currentBatch': 'Current batch',
      'noBatch': 'No batch',
      'selectTargetDock': 'Select target dock',
      'hasBatch': 'Has batch',
      'moveSuccess': 'Move successful',
      'moveFailed': 'Move failed',
      'modifySuccess': 'Changed to',
      'modifyFailed': 'Modify failed',
      'dockPausedSnackbar': 'Dock paused',
      'dockResumedSnackbar': 'Dock resumed',
      'pauseFailed': 'Pause failed',
      'resumeFailed': 'Resume failed',
      'createFailed': 'Create failed',
      'loadFailed': 'Load failed',
      'importFailed': 'Import failed',
      'exportFailed': 'Export failed',
      'seedFailed': 'Seed failed',
      'fileNotFound': 'File not found',
      'recordsImported': 'Imported {0} records',
      'testDataLoaded': 'Test data loaded',
      'invalidCount': 'Invalid input, treated as 0',
      'batchCreatedPattern': 'Batch {1} created at {0}',
      'batchMovedPattern': 'Batch {0} moved to {1}',
      'batchReceivedPattern': 'Received batch {1} from {0}',
      'batchModifiedPattern': 'Batch changed from {0} to {1}',
      'batchNewPattern': 'New batch {0}',
      'batchCompletedPattern': 'Batch {0} completed at {1}',
      'dockPausedPattern': '{0} paused',
      'dockResumedPattern': '{0} resumed',
      'statusChangedPattern': '{0} status changed to {1}',
      'dockAdjustment': 'Dock adjustment',
      'correctionPattern': 'Correct {0}',
    },
  };

  String _t(String key) =>
      _values[locale.languageCode]?[key] ??
      _values['en']![key] ??
      key;

  String _format(String key, List<Object> args) {
    var result = _t(key);
    if (args.isNotEmpty) {
      result = result.replaceAll('{0}', args[0].toString());
    }
    if (args.length > 1) {
      result = result.replaceAll('{1}', args[1].toString());
    }
    if (args.length > 2) {
      result = result.replaceAll('{2}', args[2].toString());
    }
    if (args.length > 3) {
      result = result.replaceAll('{3}', args[3].toString());
    }
    return result;
  }

  String get appName => _t('appName');
  String get appNameFull => _t('appNameFull');
  String get dockKanban => _t('dockKanban');
  String get settings => _t('settings');
  String get warehouseList => _t('warehouseList');
  String get startChange => _t('startChange');
  String get pause => _t('pause');
  String get resume => _t('resume');
  String get active => _t('active');
  String get empty => _t('empty');
  String get closed => _t('closed');
  String get blocked => _t('blocked');
  String get maintenance => _t('maintenance');
  String get move => _t('move');
  String get modifyBatch => _t('modifyBatch');
  String get createBatch => _t('createBatch');
  String get history => _t('history');
  String get delete => _t('delete');
  String get selected => _t('selected');
  String get addDock => _t('addDock');
  String get batchCreated => _t('batchCreated');
  String get batchMoved => _t('batchMoved');
  String get batchModified => _t('batchModified');
  String get batchReceived => _t('batchReceived');
  String get statusChanged => _t('statusChanged');
  String get batchCompleted => _t('batchCompleted');
  String get loading => _t('loading');
  String get noData => _t('noData');
  String get createWarehouse => _t('createWarehouse');
  String get warehouseName => _t('warehouseName');
  String get warehouseDescription => _t('warehouseDescription');
  String get dockCount => _t('dockCount');
  String get dockName => _t('dockName');
  String get batchCode => _t('batchCode');
  String get initialBatch => _t('initialBatch');
  String get createAndStart => _t('createAndStart');
  String get batch => _t('batch');
  String get dock => _t('dock');
  String get status => _t('status');
  String get save => _t('save');
  String get cancel => _t('cancel');
  String get confirm => _t('confirm');
  String get ok => _t('ok');
  String get error => _t('error');
  String get success => _t('success');
  String get language => _t('language');
  String get chinese => _t('chinese');
  String get english => _t('english');
  String get theme => _t('theme');
  String get dark => _t('dark');
  String get light => _t('light');
  String get system => _t('system');
  String get manage => _t('manage');
  String get done => _t('done');
  String get addOneDock => _t('addOneDock');
  String get addManyDocks => _t('addManyDocks');
  String get deleteSelectedDocks => _t('deleteSelectedDocks');
  String get deleteSelectedEvents => _t('deleteSelectedEvents');
  String get inputDockName => _t('inputDockName');
  String get inputDockCount => _t('inputDockCount');
  String get countCannotBeNegative => _t('countCannotBeNegative');
  String get pleaseInputNumber => _t('pleaseInputNumber');
  String get about => _t('about');
  String get version => _t('version');
  String get manageHistory => _t('manageHistory');
  String get currentBatch => _t('currentBatch');
  String get noBatch => _t('noBatch');
  String get selectTargetDock => _t('selectTargetDock');
  String get hasBatch => _t('hasBatch');
  String get moveSuccess => _t('moveSuccess');
  String get moveFailed => _t('moveFailed');
  String get modifySuccess => _t('modifySuccess');
  String get modifyFailed => _t('modifyFailed');
  String get dockPausedSnackbar => _t('dockPausedSnackbar');
  String get dockResumedSnackbar => _t('dockResumedSnackbar');
  String get pauseFailed => _t('pauseFailed');
  String get resumeFailed => _t('resumeFailed');
  String get createFailed => _t('createFailed');
  String get loadFailed => _t('loadFailed');
  String get importFailed => _t('importFailed');
  String get exportFailed => _t('exportFailed');
  String get seedFailed => _t('seedFailed');
  String get fileNotFound => _t('fileNotFound');
  String get testDataLoaded => _t('testDataLoaded');
  String get invalidCount => _t('invalidCount');

  String recordsImported(int count) => _format('recordsImported', [count]);

  String batchCreatedMsg(String dockName, String batchCode) =>
      _format('batchCreatedPattern', [dockName, batchCode]);

  String batchMovedMsg(String batchCode, String dockName) =>
      _format('batchMovedPattern', [batchCode, dockName]);

  String batchReceivedMsg(String sourceName, String batchCode) =>
      _format('batchReceivedPattern', [sourceName, batchCode]);

  String batchModifiedMsg(String? oldCode, String newCode) =>
      oldCode == null || oldCode.isEmpty
          ? _format('batchNewPattern', [newCode])
          : _format('batchModifiedPattern', [oldCode, newCode]);

  String batchCompletedMsg(String batchCode, String dockName) =>
      _format('batchCompletedPattern', [batchCode, dockName]);

  String dockPausedMsg(String dockName) =>
      _format('dockPausedPattern', [dockName]);

  String dockResumedMsg(String dockName) =>
      _format('dockResumedPattern', [dockName]);

  String statusChangedMsg(String dockName, String newStatus) =>
      _format('statusChangedPattern', [dockName, newStatus]);

  String get dockAdjustment => _t('dockAdjustment');

  String correctionMsg(String eventType) => _format('correctionPattern', [eventType]);

  String dockStatusLabel(DockStatus s) {
    switch (s) {
      case DockStatus.active:
        return active;
      case DockStatus.paused:
        return pause;
      case DockStatus.empty:
        return empty;
      case DockStatus.closed:
        return closed;
      case DockStatus.blocked:
        return blocked;
      case DockStatus.maintenance:
        return maintenance;
    }
  }

  String eventDisplay(ChangeEventModel? event, {String? fallback}) {
    if (event == null) return '';
    if (event.note != null && event.note!.isNotEmpty) {
      return event.note!;
    }
    if (event.eventType.name == 'manualNote') return fallback ?? '';
    return _t(event.eventType.name);
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode == 'zh' || locale.languageCode == 'en';

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
