/*
------------------------------------
Arquivo: stream_command.dart
Descrição: Comando assíncrono que opera sobre Streams de Result. Permite execução, cancelamento, pausa e notificação de listeners
Autor: Isac Eugenio
------------------------------------
*/

import 'dart:async';

import 'package:result_dart/result_dart.dart';

import 'async_command.dart';

abstract class StreamCommand<TSuccess extends Object>
    extends AsyncCommand<TSuccess> {
  // Assinatura da stream em execução
  StreamSubscription<Result<TSuccess>>? _subscription;

  // Controlador para expor os eventos da stream
  final StreamController<Result<TSuccess>> _controller =
      StreamController<Result<TSuccess>>.broadcast();

  // Stream pública
  Stream<Result<TSuccess>> get stream => _controller.stream;

  // Indica se a stream está em execução
  @override
  bool get isRunning => _subscription != null;

  // Executa uma stream de Result<TSuccess>
  Future<void> executeStream(Stream<Result<TSuccess>> source) async {
    await cancel();

    setResult = null;

    _subscription = source.listen(
      (event) {
        setResult = event;
        _controller.add(event);
      },
      onError: (Object error, StackTrace stackTrace) {},
      onDone: () async {
        await cancel();
      },
    );
  }

  // Pausa a stream
  void pause() {
    _subscription?.pause();
    notifyListeners();
  }

  // Retoma a stream
  void resume() {
    _subscription?.resume();
    notifyListeners();
  }

  // Cancela a stream
  Future<void> cancel() async {
    await _subscription?.cancel();
    _subscription = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _controller.close();
    super.dispose();
  }
}
