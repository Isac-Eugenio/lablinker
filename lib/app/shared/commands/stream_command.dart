import 'dart:async';
import 'package:lablinker/app/shared/commands/result.dart';

import 'async_command.dart';

abstract class StreamCommand<TSuccess, TFailure>
    extends AsyncCommand<TSuccess, TFailure> {
  StreamSubscription<Result<TSuccess, TFailure>>? _subscription;

  final StreamController<Result<TSuccess, TFailure>> _controller =
      StreamController.broadcast();

  Stream<Result<TSuccess, TFailure>> get stream => _controller.stream;

  bool get isDone => result is Success || result is Failure;

  @override
  bool get isRunning =>
      (result == null || result is Running) && _subscription != null;

  Future<void> executeStream(Stream<Result<TSuccess, TFailure>> source) async {
    await _subscription?.cancel();

    _subscription = source.listen(
      (event) {
        setResult = event;
        _controller.add(event); // envia para os listeners externos
      },
      onError: (e, st) {
        final failure = e is TFailure
            ? Failure<TSuccess, TFailure>(e)
            : Failure<TSuccess, TFailure>(Exception(e.toString()) as TFailure);
        setResult = failure;
        _controller.add(failure);
      },
      onDone: cancel,
    );
  }

  void pause() {
    _subscription?.pause();
    notifyListeners();
  }

  void resume() {
    _subscription?.resume();
    notifyListeners();
  }

  Future<void> cancel() async {
    await _subscription?.cancel();
    _subscription = null;
    notifyListeners();
  }

  @override
  void dispose() {
    cancel();
    _controller.close();
    super.dispose();
    notifyListeners();
  }
}
