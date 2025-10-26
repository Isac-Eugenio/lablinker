sealed class Result<TSuccess, TFailure> {
  const Result();

  Object? get value {
    return switch (this) {
      Success(:final value) => value,
      Failure(:final value) => value,
      Running(:final value) => value,
    };
  }
  bool get isSuccess => this is Success;
  bool get isFailure => this is Failure;
  bool get isRunning => this is Running;

  TSuccess? get successOrNull =>
      this is Success<TSuccess, TFailure> ? (this as Success).value : null;

  TFailure? get failureOrNull =>
      this is Failure<TSuccess, TFailure> ? (this as Failure).value : null;

  TSuccess? get runningValue =>
      this is Running<TSuccess, TFailure> ? (this as Running).value : null;

  TSuccess? getOrNull() =>
      this is Success<TSuccess, TFailure> ? (this as Success).value : null;

  TFailure? getOrNullFailure() =>
      this is Failure<TSuccess, TFailure> ? (this as Failure).value : null;

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

final class Success<TSuccess, TFailure> extends Result<TSuccess, TFailure> {
  @override
  final TSuccess value;

  const Success(this.value);
}

final class Failure<TSuccess, TFailure> extends Result<TSuccess, TFailure> {
  @override
  final TFailure value;

  const Failure(this.value);
}

final class Running<TSuccess, TFailure> extends Result<TSuccess, TFailure> {
  @override
  final TSuccess value;

  const Running(this.value);
}

