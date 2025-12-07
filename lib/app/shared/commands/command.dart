/*
------------------------------------
Arquivo: command.dart
Descrição: Comando genérico que gerencia execução, resultado e estado (sucesso, erro ou execução em andamento)
Autor: Isac Eugenio
------------------------------------
*/

import 'package:flutter/cupertino.dart';
import 'result.dart';

abstract class Command<TSuccess, TFailure> extends ChangeNotifier {
  // Armazena o resultado da execução (sucesso ou falha)
  Result<TSuccess, TFailure>? _result;

  // Retorna o resultado atual
  Result<TSuccess, TFailure>? get result => _result;

  // Define o resultado e notifica listeners
  set setResult(Result<TSuccess, TFailure>? value) {
    _result = value;
    notifyListeners();
  }

  // Indica se o comando ainda está em execução (resultado nulo)
  bool get isRunning => _result == null;

  // Indica se o comando foi concluído com sucesso
  bool get isSuccess => _result is Success<TSuccess, TFailure>;

  // Indica se o comando falhou
  bool get isError => _result is Failure<TSuccess, TFailure>;

  // Retorna o valor de sucesso, se houver
  TSuccess? get success => _result?.getOrNull();

  // Retorna o valor de erro, se houver
  TFailure? get error => _result?.getOrNullFailure();

  // Executa uma ação com parâmetro, atualizando o resultado e notificando listeners
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

  // Executa uma ação sem parâmetro, atualizando o resultado e notificando listeners
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
