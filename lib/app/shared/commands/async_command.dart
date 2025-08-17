import 'package:lablinker/app/shared/commands/result.dart';

import 'command.dart';

abstract class AsyncCommand<TSuccess, TFailure>
    extends Command<TSuccess, TFailure> {
  Future<void> executeAsync(
    Future<Result<TSuccess, TFailure>> Function() action,
  ) async {
    setResult = null;
    notifyListeners();

    try {
      setResult = await action();
    } catch (e) {
      setResult = Failure<TSuccess, TFailure>(e as TFailure);
    } finally {
      notifyListeners();
    }
  }

  Future<void> executeWithAsync<P>(
    Future<Result<TSuccess, TFailure>> Function(P param) action,
    P param,
  ) async {
    setResult = null;
    notifyListeners();

    try {
      setResult = await action(param);
    } catch (e) {
      setResult = Failure<TSuccess, TFailure>(e as TFailure);
    } finally {
      notifyListeners();
    }
  }
}
