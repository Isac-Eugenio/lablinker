import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart'
    hide BluetoothState;
import '../../shared/commands/async_command.dart';
import '../../shared/commands/result.dart';
import 'bluetooth_repository.dart';
import 'bluetooth_command.dart';
import 'bluetooth_state.dart';

class BluetoothCase extends ValueNotifier<BluetoothState> {
  final BluetoothRepository _repo;

  // Comandos
  final AsyncCommand<bool, String> initializeCommand = BluetoothCommand();
  final AsyncCommand<void, String> connectCommand = BluetoothCommand();
  final AsyncCommand<void, String> disconnectCommand = BluetoothCommand();
  final AsyncCommand<void, String> sendCommand = BluetoothCommand();

  // Subscriptions das streams do Repository
  StreamSubscription<BluetoothConnectionState>? _connSub;
  StreamSubscription<String>? _dataSub;

  BluetoothCase(this._repo) : super(const BluetoothState());

  // -----------------------------------------------------------
  // Inicializar Bluetooth e ouvir streams
  // -----------------------------------------------------------
  Future<Result<bool, String>> initializeBluetooth() async {
    await initializeCommand.executeAsync(() async {
      final available = await _repo.init(); // lança exception se falhar
      if (!available) return Failure('Bluetooth não disponível');

      _listenStreams();
      value = value.copyWith(
        isAvailable: true,
        connectionState: BluetoothConnectionState(
          isConnected: true,
          deviceAddress: '',
          status: '',
        ),
      );

      updatePairedDevices();

      return Success(true);
    });

    notifyListeners();
    return initializeCommand.result ?? Failure('Erro desconhecido');
  }

  // -----------------------------------------------------------
  // Conectar a um dispositivo
  // -----------------------------------------------------------
  Future<Result<void, String>> connectToDevice(BluetoothDevice device) async {
    await connectCommand.executeWithAsync(
      (d) => _repo.connect(d.address), // lança exception se falhar
      device,
    );

    debugPrint(connectCommand.result.toString());

    if (connectCommand.result?.isSuccess ?? false) {
      value = value.copyWith(
        connectedDevice: device,
        connectionState: BluetoothConnectionState(
          isConnected: connectCommand.result?.value as bool,
          deviceAddress: device.address,
          status: connectCommand.result?.value != null ? "conectado" : "",
        ),
      );
    }

    notifyListeners();
    return connectCommand.result ?? Failure('Erro desconhecido ao conectar');
  }

  // -----------------------------------------------------------
  // Desconectar
  // -----------------------------------------------------------
  Future<Result<void, String>> disconnectDevice() async {
    await disconnectCommand.executeAsync(
      () => _repo.disconnect(), // lança exception se falhar
    );

    if (disconnectCommand.result?.isSuccess ?? false) {
      value = value.copyWith(connectedDevice: null);
    }

    notifyListeners();
    return disconnectCommand.result ??
        Failure('Erro desconhecido ao desconectar');
  }

  // -----------------------------------------------------------
  // Enviar mensagem
  // -----------------------------------------------------------
  Future<Result<void, String>> sendMessage(String msg) async {
    await sendCommand.executeWithAsync(
      (m) => _repo.sendMessage(m), // lança exception se falhar
      msg,
    );

    notifyListeners();
    return sendCommand.result ?? Failure('Erro desconhecido ao enviar');
  }

  // -----------------------------------------------------------
  // Atualizar lista de dispositivos pareados
  // -----------------------------------------------------------
  Future<Result<List<BluetoothDevice>, String>> updatePairedDevices() async {
    final devices = await _repo.getPairedDevices(); // lança exception se falhar
    value = value.copyWith(pairedDevices: devices);
    notifyListeners();
    return Success(devices);
  }

  // -----------------------------------------------------------
  // Ouvir streams do Repository
  // -----------------------------------------------------------
  void _listenStreams() {
    // Listener de conexão
    _connSub = _repo.connectionStream.listen((state) {
      value = value.copyWith(
        connectionState: state,
        connectedDevice: state.isConnected ? value.connectedDevice : null,
      );
      notifyListeners();
    });

    // Listener de dados recebidos
    _dataSub = _repo.dataStream.listen((data) {
      final updatedData = '${value.receivedData}$data\n';
      value = value.copyWith(receivedData: updatedData);
      notifyListeners(); // necessário para atualizar a UI
    });
  }
}
