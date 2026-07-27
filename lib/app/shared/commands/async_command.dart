/*
------------------------------------
Arquivo: async_command.dart
Descrição: Comando assíncrono genérico que estende Command. Permite executar ações async e gerenciar resultados com sucesso ou falha
Autor: Isac Eugenio
------------------------------------
*/

import 'package:result_dart/result_dart.dart';
import 'command.dart';

abstract class AsyncCommand<TSuccess extends Object> extends Command<TSuccess> {
  // Executa uma ação assíncrona sem parâmetros e atualiza o resultado
  Future<void> executeAsync(Future<Result<TSuccess>> Function() action) async {
    setResult = null; // Reseta o resultado antes da execução

    // Aguarda o resultado da ação e atualiza o setResult
    setResult = await action();
  }

  // Executa uma ação assíncrona com parâmetro e atualiza o resultado
  Future<void> executeWithAsync<P>(
    Future<Result<TSuccess>> Function(P param) action,
    P param,
  ) async {
    setResult = null; // Reseta o resultado antes da execução

    setResult = await action(param); // Executa ação com parâmetro
  }
}
