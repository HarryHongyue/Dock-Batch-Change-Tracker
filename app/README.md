# DockFlow Tracker / 道口批次追踪器

本地优先（local-first）的仓库道口与批次变更追踪应用。

## 技术栈

- Flutter 3.24.3 / Dart 3.5.3
- Material 3
- Riverpod（状态管理）
- Drift + SQLite（本地数据库）
- GoRouter（路由）
- freezed / json_serializable（数据模型与序列化）
- intl、path_provider、share_plus、uuid、csv、shared_preferences

## 架构

```
lib/
  main.dart
  src/
    app.dart              # 应用根组件
    router.dart           # GoRouter 配置
    theme.dart            # Material 3 主题
    constants.dart        # 常量与字符串
    utils.dart            # 工具函数
    data/
      database.dart       # Drift 数据库定义
      tables/             # 数据表定义
      models/             # freezed 数据模型
      repositories/       # Drift 仓库层
      services/           # 业务服务层
    providers/            # Riverpod Provider
    ui/
      pages/              # 页面
      widgets/            # 通用组件
```

## 依赖生成

项目包含 `part '*.g.dart'` 与 `part '*.freezed.dart'`，需要先运行代码生成：

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

## 运行

### Android

```bash
flutter run
```

或使用已连接的 Android 设备：

```bash
flutter devices
flutter run -d <device-id>
```

### iOS

```bash
cd ios
pod install
cd ..
flutter run
```

## 构建发布包

```bash
# Android 调试 APK（已生成在 build/app/outputs/flutter-apk/app-debug.apk）
flutter build apk --debug

# Android 发布 APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

## 支持的系统版本

- **Android**：最低 Android 5.0（API 21），目标 Android 14（API 34）。支持小米、三星、华为等主流 Android 手机。
- **iOS**：代码支持 iOS 12+，但打包必须在 macOS + Xcode 环境下完成。

## 测试

```bash
flutter test
```

`test/dock_operation_test.dart` 覆盖了仓库/道口创建、长批次编号、批次移动、交换、目标道口占用检测、多事件会话、前后快照、撤销、JSON 导出/导入、CSV 导出等场景。

> 在 Linux/WSL 测试时，若提示找不到 `libsqlite3.so`，确保已安装 `libsqlite3-dev`（提供 `libsqlite3.so` 软链接），或在运行测试前设置 `LD_LIBRARY_PATH` 指向包含该软链接的目录。

## MVP 说明

- 第一版本地运行，不依赖网络、登录或服务器。
- 支持仓库、道口、批次的增删改查与归档。
- 支持变更会话：开始变更 → 多事件操作 → 撤销/完成，自动记录变更前后快照。
- 支持 JSON 完整备份/恢复与 CSV 导出。
- 预留 `SyncServiceInterface`，后续可接入云同步。
- 部分高级功能（多人协作、照片附件、扫码、NFC、平面图等）为后续扩展预留，当前版本以核心道口-批次追踪为主。
- 由于 Drift/SQLite 使用 `dart:ffi`，当前版本主要面向 Android / iOS / Linux / Windows / macOS 桌面，暂不完整支持 Web。

## 种子数据

在 `设置 → 载入测试数据` 中可插入 `Maastricht Warehouse` 及 6 个道口、示例变更会话，用于快速验证时间线与快照比较。
