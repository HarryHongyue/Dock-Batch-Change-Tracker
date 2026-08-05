class AppConstants {
  AppConstants._();

  static const String appName = 'DockFlow Tracker';
  static const String appNameCn = '道口批次追踪器';
  static const String appVersion = '1.0.2';
  static const String exportVersion = '1.0.0';

  static const int defaultDockCount = 6;

  static const String prefFirstRun = 'first_run';
  static const String prefThemeMode = 'theme_mode';
  static const String prefCurrentWarehouse = 'current_warehouse_id';
}

class AppStrings {
  AppStrings._();

  static const String loading = '加载中…';
  static const String warehouses = '仓库列表';
  static const String addWarehouse = '新增仓库';
  static const String editWarehouse = '编辑仓库';
  static const String warehouseName = '仓库名称';
  static const String warehouseDescription = '仓库描述';
  static const String dockKanban = '道口看板';
  static const String changeMode = '变更模式';
  static const String startChange = '开始变更';
  static const String finishChange = '完成变更';
  static const String cancelChange = '取消变更';
  static const String undo = '撤销';
  static const String timeline = '时间线';
  static const String settings = '设置';
  static const String batch = '批次';
  static const String dock = '道口';
  static const String batchCode = '批次编号';
  static const String batchName = '批次简称';
  static const String note = '备注';
  static const String move = '移动';
  static const String swap = '交换';
  static const String create = '新增';
  static const String complete = '完成';
  static const String pause = '暂停';
  static const String resume = '恢复';
  static const String status = '状态';
  static const String save = '保存';
  static const String delete = '删除';
  static const String archive = '归档';
  static const String exportJson = '导出 JSON';
  static const String importJson = '导入 JSON';
  static const String exportCsv = '导出 CSV';
  static const String seedData = '载入测试数据';
  static const String onboardingTitle = '初始化仓库';
  static const String onboardingHint = '创建第一个仓库和道口';
}

class DockStatusLabels {
  DockStatusLabels._();
  static const String active = '正常';
  static const String paused = 'B';
  static const String empty = '空闲';
  static const String closed = '关闭';
  static const String blocked = '阻塞';
  static const String maintenance = '维护';
}
