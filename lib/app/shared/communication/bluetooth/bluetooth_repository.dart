/*
-----------------------------------------------------------
Arquivo: bluetooth_repository.dart
Descrição: Repositório responsável pela comunicação com o
           Bluetooth clássico.
Autor: Isac Eugenio
-----------------------------------------------------------
*/

import 'dart:async';

import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';

import 'bluetooth_listeners.dart';

class BluetoothRepository implements BluetoothCallbacks {
  final FlutterBluetoothClassic _bluetooth = FlutterBluetoothClassic();
  late final BluetoothListeners _listeners;

  // Streams para expor estado e dados recebidos
  final StreamController<BluetoothConnectionState> _connectionController =
      StreamController.broadcast();

  final StreamController<String> _dataController = StreamController.broadcast();

  // Streams públicas
  Stream<BluetoothConnectionState> get connectionStream =>
      _connectionController.stream;

  Stream<String> get dataStream => _dataController.stream;

  FlutterBluetoothClassic get bluetoothClassic => _bluetooth;

  BluetoothRepository() {
    _listeners = BluetoothListeners(bluetooth: _bluetooth, callbacks: this);
  }

  // -----------------------------------------------------------
  // Inicializa o Bluetooth e inicia os listeners
  // -----------------------------------------------------------
  Future<bool> init() async {
    final supported = await _bluetooth.isBluetoothSupported();
    final enabled = await _bluetooth.isBluetoothEnabled();

    final available = supported && enabled;

    if (!available) {
      return false;
    }

    _listeners.start();

    return true;
  }

  // -----------------------------------------------------------
  // Retorna a lista de dispositivos pareados
  // -----------------------------------------------------------
  Future<List<BluetoothDevice>> getPairedDevices() {
    return _bluetooth.getPairedDevices();
  }

  // -----------------------------------------------------------
  // Conecta a um dispositivo
  // -----------------------------------------------------------
  Future<bool> connect(String address) async {
    await _bluetooth.connect(address);

    final state = await _bluetooth.onConnectionChanged
        .firstWhere((s) => s.deviceAddress == address)
        .timeout(const Duration(seconds: 5));

    return state.isConnected;
  }

  // -----------------------------------------------------------
  // Desconecta do dispositivo
  // -----------------------------------------------------------
  Future<void> disconnect() async {
    final disconnected = await _bluetooth.disconnect();

    if (!disconnected) {
      throw Exception('Falha ao desconectar.');
    }
  }

  // -----------------------------------------------------------
  // Envia uma mensagem
  // -----------------------------------------------------------
  Future<void> sendMessage(String message) async {
    await _bluetooth.sendString(message);
  }

  // -----------------------------------------------------------
  // Callback de alteração de conexão
  // -----------------------------------------------------------
  @override
  void onConnectionChanged(BluetoothConnectionState state) {
    _connectionController.add(state);
  }

  // -----------------------------------------------------------
  // Callback de dados recebidos
  // -----------------------------------------------------------
  @override
  void onDataReceived(BluetoothData data) {
    _dataController.add(data.asString());
  }

  // -----------------------------------------------------------
  // Libera os recursos utilizados
  // -----------------------------------------------------------
  void dispose() {
    _listeners.dispose();
    _connectionController.close();
    _dataController.close();
  }
}
