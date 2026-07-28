# DockFlow Tracker / 道口批次追踪器

本地优先的仓库道口与批次变更追踪 Flutter 应用。

## 仓库结构

- `app/` - Flutter 项目目录
- `第一个基础开发文档.md` - 基础开发文档
- `AGENTS.md` - 项目运行与构建备忘

## 技术栈

- Flutter 3.24.3 / Dart 3.5.3
- Material 3
- Riverpod 状态管理
- Drift + SQLite 本地数据
- GoRouter 页面导航
- freezed / json_serializable 数据模型
- intl, path_provider, share_plus

## 快速开始

1. 设置 Flutter 环境（如果尚未设置）：
   ```bash
   export PATH="/mnt/g/GitHubPersonal/flutter-sdk/bin:$PATH"
   ```

2. 安装依赖：
   ```bash
   cd app
   flutter pub get
   ```

3. 生成代码：
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. 分析：
   ```bash
   flutter analyze
   ```

5. 测试：
   ```bash
   flutter test
   ```
   
   > Linux/WSL 环境若找不到 `libsqlite3.so`，请安装 `libsqlite3-dev`，或设置 `LD_LIBRARY_PATH` 指向 `app/native_libs/`。


6. 运行：
   ```bash
   flutter run
   ```

## 打包

- Android debug APK 已构建：`DockFlow-Tracker-debug.apk`（90 MB，可直接用 `adb install` 或发送到手机安装）。
- 重新构建：`flutter build apk --debug`（开发测试）或 `flutter build apk --release`（发布，需要签名配置）。
- iOS: `flutter build ios`（需要 macOS + Xcode）。

## 支持的系统版本

- **Android**：最低 Android 5.0（API 21），目标 Android 14（API 34）。支持主流 Android 手机，包括小米、三星、华为等。
- **iOS**：代码支持 iOS 12+，但要打包/安装 IPA 必须在 macOS + Xcode 环境下完成。当前 WSL 无法直接构建 iOS。
