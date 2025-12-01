/*
import 'package:flutter/widgets.dart';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';
import 'package:lablinker/app/shared/commands/result.dart';
import 'package:lablinker/app/views/bluetooth/bluetooth_repository.dart';
import 'package:lablinker/app/views/teste_view/teste_command.dart';

class TesteModelview extends ValueNotifier<BluetoothRepository?> {
  TesteModelview():super(null){
    value = BluetoothRepository();
  }

  final TesteCommand _command = TesteCommand();

  // Getters para leitura da camada de apresentação
  List<BluetoothDevice> get getPairedDevices => value!.pairedDevices;
  BluetoothConnectionState? get getConnectionState => value!.connectionState;
  BluetoothDevice? get getConnectedDevice => value!.connectedDevice;
  String get getReceivedData => value!.receivedData;
  bool get isBluetoothAvailable => value!.isAvailable;

  // Atualiza a lista de dispositivos pareados
  Future<Result<List<BluetoothDevice>, String>> updateListDevice() async {
    final result = await value!.loadPairedDevices();
    notifyListeners();
    return result;
  } 

  // Inicializa o Bluetooth e trata o estado via AsyncCommand
  Future<Result<bool, String>> initializeBluetooth() async {
    await _command.executeAsync(() => value!.init());
    final result = _command.result;

    if (result == null) {
      return Failure('Nenhum resultado retornado do comando');
    }

    if (result.isFailure) {
      return Failure(
        result.failureOrNull ?? 'Falha desconhecida ao iniciar Bluetooth',
      );
    }

    if (result.isSuccess) {
      debugPrint('Bluetooth inicializado com sucesso');
      notifyListeners();
      return Success(true);
    }

    return Running(true);
  }

  // Conecta a um dispositivo específico
  Future<Result<void, String>> connectToDevice(BluetoothDevice device) async {
    await _command.executeAsync(() => value!.connect(device));
    final result = _command.result;

    if (result == null || result.isFailure) {
      return Failure(
        result?.failureOrNull ?? 'Erro ao conectar ao dispositivo',
      );
    }

    notifyListeners();
    return Success(null);
  }

  // Desconecta o dispositivo atual
  Future<Result<void, String>> disconnectDevice() async {
    await _command.executeAsync(() => value!.disconnect());
    final result = _command.result;
    if (result == null || result.isFailure) {
      return Failure(result?.failureOrNull ?? 'Erro ao desconectar');
    }

    notifyListeners();
    return Success(null);
  }

  // Envia mensagem ao dispositivo conectado
  Future<Result<void, String>> sendMessage(String msg) async {
    await _command.executeAsync(() => value!.sendMessage(msg));
    final result = _command.result;

    if (result == null || result.isFailure) {
      return Failure(result?.failureOrNull ?? 'Erro ao enviar mensagem');
    }

    return Success(null);
  }
}
*/
