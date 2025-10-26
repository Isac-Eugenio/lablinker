import 'package:flutter/cupertino.dart';
import 'result.dart';

abstract class Command<TSuccess, TFailure> extends ChangeNotifier {
  Result<TSuccess, TFailure>? _result;

  Result<TSuccess, TFailure>? get result => _result;

  set setResult(Result<TSuccess, TFailure>? value) {
    _result = value;
    notifyListeners();
  }

  bool get isRunning => _result == null;

  bool get isSuccess => _result is Success<TSuccess, TFailure>;
  bool get isError => _result is Failure<TSuccess, TFailure>;

  TSuccess? get success => _result?.getOrNull();
  TFailure? get error => _result?.getOrNullFailure();

  void executeWith(Function action, dynamic param) {
    _result = null;
    notifyListeners();

    try {
      _result = action(param);
    } catch (e) {
      _result = Failure<TSuccess, TFailure>(e as TFailure);
    } finally {
      notifyListeners();
    }
  }

  void execute(Result<TSuccess, TFailure> Function() action) {
    _result = null;
    notifyListeners();

    try {
      _result = action();
    } catch (e) {
      _result = Failure<TSuccess, TFailure>(e as TFailure);
    } finally {
      notifyListeners();
    }
  }
}
