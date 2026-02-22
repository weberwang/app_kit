/// Clean Architecture UseCase 基类
/// [Params] — 入参类型，无参时使用 [NoParams]
/// [Result] — 返回类型
abstract interface class UseCase<Result, Params> {
  Future<Result> call(Params params);
}

/// 无参 UseCase 专用哨兵类型
final class NoParams {
  const NoParams();
}
