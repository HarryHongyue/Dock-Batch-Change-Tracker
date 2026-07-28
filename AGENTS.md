# Agent Notes

## Project
- Flutter app: `app/`
- Flutter SDK installed at: `/mnt/g/GitHubPersonal/flutter-sdk`
- To use Flutter, run: `export PATH="/mnt/g/GitHubPersonal/flutter-sdk/bin:$PATH"`

## Common Commands
- `cd app && flutter pub get`
- `cd app && dart run build_runner build --delete-conflicting-outputs`
- `cd app && flutter analyze`
- `cd app && flutter test`
  - On WSL: `export LD_LIBRARY_PATH=/mnt/g/GitHubPersonal/Dock-Batch-Change-Tracker/app/native_libs:$LD_LIBRARY_PATH` if `libsqlite3.so` isn't found
- `cd app && flutter run -d <device>`
- Android debug APK: `cd app && flutter build apk --debug`
  - Output: `app/build/app/outputs/flutter-apk/app-debug.apk`
  - Also copied to: `DockFlow-Tracker-debug.apk`
- iOS build: `flutter build ios` (requires macOS + Xcode)
