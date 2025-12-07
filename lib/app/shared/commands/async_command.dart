/*
------------------------------------
Arquivo: async_command.dart
Descrição: Comando assíncrono genérico que estende Command. Permite executar ações async e gerenciar resultados com sucesso ou falha
Autor: Isac Eugenio
------------------------------------
*/

import 'package:lablinker/app/shared/commands/result.dart';
import 'command.dart';

abstract class AsyncCommand<TSuccess, TFailure>
    extends Command<TSuccess, TFailure> {

  // Executa uma ação assíncrona sem parâmetros e atualiza o resultado
  Future<void> executeAsync(
      Future<Result<TSuccess, TFailure>> Function() action,
      ) async {
    setResult = null; // Reseta o resultado antes da execução
    notifyListeners(); // Notifica mudanças para listeners

    try {
      // Aguarda o resultado da ação e atualiza o setResult
      setResult = await action();
    } catch (e) {
      // Em caso de erro, cria um Failure
      setResult = Failure<TSuccess, TFailure>(e as TFailure);
    } finally {
      notifyListeners(); // Notifica listeners mesmo em erro
    }
  }

  // Executa uma ação assíncrona com parâmetro e atualiza o resultado
  Future<void> executeWithAsync<P>(
      Future<Result<TSuccess, TFailure>> Function(P param) action,
      P param,
      ) async {
    setResult = null; // Reseta o resultado antes da execução
    notifyListeners();

    try {
      setResult = await action(param); // Executa ação com parâmetro
    } catch (e) {
      setResult = Failure<TSuccess, TFailure>(e as TFailure); // Captura falha
    } finally {
      notifyListeners(); // Notifica listeners
    }
  }
}
