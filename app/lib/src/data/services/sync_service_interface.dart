/// 预留的同步接口。第一版不实现强制云同步。
abstract class SyncServiceInterface {
  Future<void> initialize();
  Future<void> syncAll();
  Future<void> pullFromRemote();
  Future<void> pushToRemote();
  Future<void> logout();
  Stream<double>? get progress;
}
