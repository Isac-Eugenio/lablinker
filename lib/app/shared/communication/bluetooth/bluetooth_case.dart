/*
-----------------------------------------------------------
Arquivo: bluetooth_case.dart
Descrição: Caso de uso responsável pelas regras de negócio
           do Bluetooth e conversão de erros para Result.
Autor: Isac Eugenio
-----------------------------------------------------------
*/

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart'
    hide BluetoothState;
import 'package:result_dart/result_dart.dart';

import 'bluetooth_repository.dart';
import 'bluetooth_state.dart';

class BluetoothCase extends ValueNotifier<BluetoothState> {
  // Repositório responsável pelas operações Bluetooth
  final BluetoothRepository _repo;

  // Assinaturas das streams
  StreamSubscription? _connSub;
  StreamSubscription? _dataSub;

  StreamSubscription? get dataSub => _dataSub;
  StreamSubscription? get connSub => _connSub;

  BluetoothCase(this._repo) : super(const BluetoothState());

  // -----------------------------------------------------------
  // Inicializar Bluetooth e ouvir streams
  // -----------------------------------------------------------
  Future<Result<bool>> initializeBluetooth() async {
    try {
      final available = await _repo.init();

      if (!available) {
        return Failure(Exception('Bluetooth não disponível'));
      }

      _listenStreams();

      value = value.copyWith(
        isAvailable: true,
        connectionState: BluetoothConnectionState(
          isConnected: false,
          deviceAddress: '',
          status: '',
        ),
      );

      await updatePairedDevices();

      notifyListeners();

      return const Success(true);
    } catch (e) {
      return Failure(Exception('Erro ao inicializar Bluetooth'));
    }
  }

  // -----------------------------------------------------------
  // Conectar a um dispositivo
  // -----------------------------------------------------------
  Future<Result<bool>> connectToDevice(BluetoothDevice device) async {
    try {
      final connected = await _repo.connect(device.address);

      if (!connected) {
        return Failure(Exception('Falha ao conectar'));
      }

      value = value.copyWith(
        connectedDevice: device,
        lastConnectedDevice: device,
        connectionState: BluetoothConnectionState(
          isConnected: true,
          deviceAddress: device.address,
          status: 'conectado',
        ),
      );

      notifyListeners();

      return const Success(true);
    } catch (e) {
      return Failure(Exception('Erro ao conectar: $e'));
    }
  }

  // -----------------------------------------------------------
  // Desconectar dispositivo
  // -----------------------------------------------------------
  Future<Result<bool>> disconnectDevice() async {
    try {
      await _repo.disconnect();

      value = value.copyWith(
        connectedDevice: null,
        connectionState: BluetoothConnectionState(
          isConnected: false,
          deviceAddress: '',
          status: '',
        ),
      );

      notifyListeners();

      return const Success(true);
    } catch (e) {
      return Failure(Exception('Erro ao desconectar: $e'));
    }
  }

  // -----------------------------------------------------------
  // Enviar mensagem
  // -----------------------------------------------------------
  Future<Result<bool>> sendMessage(String msg) async {
    try {
      await _repo.sendMessage(msg);

      return const Success(true);
    } catch (e) {
      return Failure(Exception('Erro ao enviar mensagem: $e'));
    }
  }

  // -----------------------------------------------------------
  // Atualizar lista de dispositivos pareados
  // -----------------------------------------------------------
  Future<Result<List<BluetoothDevice>>> updatePairedDevices() async {
    try {
      final devices = await _repo.getPairedDevices();

      value = value.copyWith(pairedDevices: devices);

      notifyListeners();

      return Success(devices);
    } catch (e) {
      return Failure(Exception('Erro ao buscar dispositivos: $e'));
    }
  }

  // -----------------------------------------------------------
  // Ouvir streams do Repository
  // -----------------------------------------------------------
  void _listenStreams() {
    _connSub = _repo.connectionStream.listen((state) {
      value = value.copyWith(
        connectionState: state,
        connectedDevice: state.isConnected ? value.connectedDevice : null,
      );

      notifyListeners();
    });

    _dataSub = _repo.dataStream.listen((data) {
      final updatedData = '${value.receivedData}$data\n';

      value = value.copyWith(receivedData: updatedData);

      notifyListeners();
    });
  }

  // -----------------------------------------------------------
  // Limpar buffer de dados recebidos
  // -----------------------------------------------------------
  void clearReceivedBuffer() {
    value = value.copyWith(receivedData: '');

    notifyListeners();
  }

  // -----------------------------------------------------------
  // Liberar recursos
  // -----------------------------------------------------------
  @override
  void dispose() {
    _connSub?.cancel();
    _dataSub?.cancel();

    super.dispose();
  }
}
