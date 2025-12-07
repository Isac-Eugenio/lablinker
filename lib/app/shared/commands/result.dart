/*
------------------------------------
Arquivo: result.dart
Descrição: Representa o resultado de uma operação com três estados: sucesso, falha ou execução em andamento. Permite acessar valores de forma segura e aplicar transformações (map/fold)
Autor: Isac Eugenio
------------------------------------
*/

sealed class Result<TSuccess, TFailure> {
  const Result();

  // Retorna o valor contido no resultado, independente do tipo
  Object? get value {
    return switch (this) {
      Success(:final value) => value,
      Failure(:final value) => value,
      Running(:final value) => value,
    };
  }

  // Verifica se o resultado é sucesso
  bool get isSuccess => this is Success;

  // Verifica se o resultado é falha
  bool get isFailure => this is Failure;

  // Verifica se o resultado está em execução
  bool get isRunning => this is Running;

  // Retorna o valor de sucesso, se houver
  TSuccess? get successOrNull =>
      this is Success<TSuccess, TFailure> ? (this as Success).value : null;

  // Retorna o valor de falha, se houver
  TFailure? get failureOrNull =>
      this is Failure<TSuccess, TFailure> ? (this as Failure).value : null;

  // Retorna valor temporário enquanto executando
  TSuccess? get runningValue =>
      this is Running<TSuccess, TFailure> ? (this as Running).value : null;

  // Alias para successOrNull
  TSuccess? getOrNull() =>
      this is Success<TSuccess, TFailure> ? (this as Success).value : null;

  // Alias para failureOrNull
  TFailure? getOrNullFailure() =>
      this is Failure<TSuccess, TFailure> ? (this as Failure).value : null;

  // Executa funções específicas conforme estado (sucesso, falha ou running)
  T fold<T>(
      T Function(TSuccess value) onSuccess,
      T Function(TFailure value) onFailure, [
        T Function(TSuccess value)? onRunning,
      ]) {
    if (this is Success<TSuccess, TFailure> && onRunning == null) {
      return onSuccess((this as Success<TSuccess, TFailure>).value);
    } else if (this is Running<TSuccess, TFailure> && onRunning != null) {
      return onRunning((this as Running<TSuccess, TFailure>).value);
    } else if (this is Failure<TSuccess, TFailure>) {
      return onFailure((this as Failure<TSuccess, TFailure>).value);
    } else {
      throw StateError('Unhandled state in fold');
    }
  }

  // Transforma o valor de sucesso, mantendo falha ou running
  Result<TNew, TFailure> map<TNew>(TNew Function(TSuccess value) onSuccess) {
    if (this is Success<TSuccess, TFailure>) {
      return Success<TNew, TFailure>(
        onSuccess((this as Success<TSuccess, TFailure>).value),
      );
    } else if (this is Running<TSuccess, TFailure>) {
      return Running<TNew, TFailure>(
        onSuccess((this as Running<TSuccess, TFailure>).value),
      );
    } else {
      return Failure<TNew, TFailure>(
        (this as Failure<TSuccess, TFailure>).value,
      );
    }
  }

  // Transforma o valor de falha, mantendo sucesso ou running
  Result<TSuccess, TNew> mapFailure<TNew>(
      TNew Function(TFailure value) onFailure,
      ) {
    if (this is Failure<TSuccess, TFailure>) {
      return Failure<TSuccess, TNew>(
        onFailure((this as Failure<TSuccess, TFailure>).value),
      );
    } else if (this is Running<TSuccess, TFailure>) {
      return Running<TSuccess, TNew>(
        (this as Running<TSuccess, TFailure>).value,
      );
    } else {
      return Success<TSuccess, TNew>(
        (this as Success<TSuccess, TFailure>).value,
      );
    }
  }

  @override
  String toString() {
    switch (this) {
      case Success(:final value):
        return 'Success($value)';
      case Failure(:final value):
        return 'Failure($value)';
      case Running(:final value):
        return 'Running($value)';
    }
  }
}

// Representa um resultado de sucesso
final class Success<TSuccess, TFailure> extends Result<TSuccess, TFailure> {
  @override
  final TSuccess value;

  const Success(this.value);
}

// Representa um resultado de falha
final class Failure<TSuccess, TFailure> extends Result<TSuccess, TFailure> {
  @override
  final TFailure value;

  const Failure(this.value);
}

// Representa um resultado em execução (running)
final class Running<TSuccess, TFailure> extends Result<TSuccess, TFailure> {
  @override
  final TSuccess value;

  const Running(this.value);
}
