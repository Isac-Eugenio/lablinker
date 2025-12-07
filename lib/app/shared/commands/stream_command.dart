/*
------------------------------------
Arquivo: stream_command.dart
Descrição: Comando assíncrono que opera sobre Streams de Result. Permite execução, cancelamento, pausa e notificação de listeners
Autor: Isac Eugenio
------------------------------------
*/

import 'dart:async';
import 'package:lablinker/app/shared/commands/result.dart';
import 'async_command.dart';

abstract class StreamCommand<TSuccess, TFailure>
    extends AsyncCommand<TSuccess, TFailure> {

  // Assinatura atual da stream, usada para cancelar/resumir
  StreamSubscription<Result<TSuccess, TFailure>>? _subscription;

  // Controlador da stream para enviar eventos para listeners externos
  final StreamController<Result<TSuccess, TFailure>> _controller =
  StreamController.broadcast();

  // Exposição da stream para quem quiser escutar os eventos
  Stream<Result<TSuccess, TFailure>> get stream => _controller.stream;

  // Indica se a execução terminou (sucesso ou falha)
  bool get isDone => result is Success || result is Failure;

  // Indica se está em execução ou em estado running
  @override
  bool get isRunning =>
      (result == null || result is Running) && _subscription != null;

  // Executa a stream, atualizando result e enviando eventos aos listeners
  Future<void> executeStream(Stream<Result<TSuccess, TFailure>> source) async {
    await _subscription?.cancel(); // Cancela execução anterior

    _subscription = source.listen(
          (event) {
        setResult = event; // Atualiza resultado interno
        _controller.add(event); // Envia para listeners externos
      },
      onError: (e, st) {
        // Captura erro e converte em Failure
        final failure = e is TFailure
            ? Failure<TSuccess, TFailure>(e)
            : Failure<TSuccess, TFailure>(Exception(e.toString()) as TFailure);
        setResult = failure;
        _controller.add(failure);
      },
      onDone: cancel, // Ao terminar, cancela assinatura
    );
  }

  // Pausa a execução da stream
  void pause() {
    _subscription?.pause();
    notifyListeners();
  }

  // Retoma a execução da stream
  void resume() {
    _subscription?.resume();
    notifyListeners();
  }

  // Cancela a execução da stream
  Future<void> cancel() async {
    await _subscription?.cancel();
    _subscription = null;
    notifyListeners();
  }

  // Fecha o controlador e limpa a assinatura ao descartar o comando
  @override
  void dispose() {
    cancel();
    _controller.close();
    super.dispose();
    notifyListeners();
  }
}
