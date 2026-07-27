/*
-----------------------------------------------------------
Arquivo: command.dart
Descrição: Classe base para execução de comandos que retornam
           Result<TSuccess, TFailure>, notificando os listeners
           durante a execução e após sua conclusão.
Autor: Isac Eugenio
-----------------------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

abstract class Command<TSuccess extends Object> extends ChangeNotifier {
  // Armazena o resultado da última execução
  Result<TSuccess>? _result;

  // Retorna o resultado atual
  Result<TSuccess>? get result => _result;

  // Atualiza o resultado e notifica os listeners
  set setResult(Result<TSuccess>? value) {
    _result = value;
    notifyListeners();
  }

  // Indica se o comando está em execução
  bool get isRunning => _result == null;

  // Indica se o resultado foi sucesso
  bool get isSuccess => _result?.isSuccess() ?? false;

  // Indica se o resultado foi erro
  bool get isError => _result?.isError() ?? false;

  // Retorna o valor de sucesso
  TSuccess? get success => _result?.getOrNull();

  // Retorna a exceção, caso exista
  Exception? get error => _result?.exceptionOrNull();

  // Executa uma ação com parâmetro
  void executeWith<TParam>(
    Result<TSuccess> Function(TParam param) action,
    TParam param,
  ) {
    _result = null;
    notifyListeners();

    _result = action(param);

    notifyListeners();
  }

  // Executa uma ação sem parâmetros
  void execute(Result<TSuccess> Function() action) {
    _result = null;
    notifyListeners();

    _result = action();

    notifyListeners();
  }

  // Limpa o resultado
  void clear() {
    _result = null;
    notifyListeners();
  }
}
