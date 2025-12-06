import 'dart:async';
import 'package:lablinker/app/shared/commands/async_command.dart';
import 'package:lablinker/app/shared/commands/result.dart';

// OBRIGATÓRIO: Definir o tipo TFailure para o Result de forma que ele possa
// ser instanciado em caso de erro, por exemplo, como uma String.
// Ajuste TFailure para o tipo que você usa para falhas síncronas (ex: String).
// Neste exemplo, vamos usar String para TFailure.
class TimerCommand<TSuccess> extends AsyncCommand<TSuccess, String>{
  Timer? _pollingTimer;

  bool get isActive => _pollingTimer?.isActive ?? false;

  // A task recebe o Timer como argumento (padrão de Timer.periodic)
  final void Function(Timer timer) task;
  final Duration interval;

  // O construtor é simplificado e apenas recebe a task e o intervalo.
  TimerCommand(this.task, this.interval);

  /// Inicia o Timer periódico. Se já estiver ativo, ele será cancelado e reiniciado.
  Result<TSuccess, String> start(){
    // 1. Limpa o Timer anterior para evitar duplicação e memory leak.
    stop();

    try{
      // 2. OBRIGATÓRIO: Atribui a instância do Timer à variável de rastreamento.
      _pollingTimer = Timer.periodic(interval, task);

      // 3. Retorna Sucesso (assumindo que TSuccess é o tipo de retorno).
      // Como o Timer é iniciado com sucesso, o retorno síncrono é um sucesso.
      return Success(null as TSuccess); // Se TSuccess for void, use null

    } catch(e) {
      // Caso haja uma falha inesperada (ex: Intervalo inválido)
      return Failure("Falha ao iniciar o Timer: ${e.toString()}");
    }
  }

  /// Cancela o Timer periódico. OBRIGATÓRIO para evitar memory leaks.
  Result<void, String> stop() {
    if (_pollingTimer != null && _pollingTimer!.isActive) {
      _pollingTimer?.cancel();
      _pollingTimer = null; // Limpa a referência
      return Success(null);
    }
    // Se o Timer não estava ativo, ainda é um sucesso (não há nada para parar).
    return Success(null);
  }

  // O método execute() é herdado do AsyncCommand, mas um TimerCommand
  // geralmente não implementa o execute, pois seu ciclo é gerido por start/stop.
  @override
  Future<Result<TSuccess, String>> execute(action) async {
    return Future.value(start());
  }

  // O dispose é crucial para comandos de longa duração.
  @override
  void dispose() {
    stop();
    super.dispose();
  }
}