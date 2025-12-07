/*
------------------------------------
Arquivo: bluetooth_repository.dart
Descrição: Repository responsável por gerenciar a camada de acesso ao Bluetooth,
           incluindo inicialização, conexão, desconexão, envio de mensagens
           e streams de dados/estado.
Autor: Isac Eugenio
------------------------------------
*/

import 'dart:async';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';
import '../../shared/commands/result.dart';
import 'bluetooth_listeners.dart';

class BluetoothRepository implements BluetoothCallbacks {
  final FlutterBluetoothClassic _bluetooth = FlutterBluetoothClassic();
  late final BluetoothListeners _listeners;

  // Streams para expor estado e dados recebidos
  final _connectionController = StreamController<BluetoothConnectionState>.broadcast();
  final _dataController = StreamController<String>.broadcast();

  Stream<BluetoothConnectionState> get connectionStream => _connectionController.stream;
  Stream<String> get dataStream => _dataController.stream;

  FlutterBluetoothClassic get bluetoothClassic => _bluetooth;

  BluetoothRepository() {
    _listeners = BluetoothListeners(bluetooth: _bluetooth, callbacks: this);
  }

  // -----------------------------------------------------------
  // Inicializa o Bluetooth e inicia os listeners
  // -----------------------------------------------------------
  Future<bool> init() async {
    try {
      final supported = await _bluetooth.isBluetoothSupported();
      final enabled = await _bluetooth.isBluetoothEnabled();
      final available = supported && enabled;

      if (!available) return false;

      _listeners.start(); // inicia listeners de eventos
      return true;
    } catch (e) {
      throw 'Erro ao inicializar Bluetooth: $e';
    }
  }

  // -----------------------------------------------------------
  // Retorna lista de dispositivos pareados
  // -----------------------------------------------------------
  Future<List<BluetoothDevice>> getPairedDevices() async {
    try {
      return await _bluetooth.getPairedDevices();
    } catch (e) {
      throw 'Erro ao obter dispositivos pareados: $e';
    }
  }

  // -----------------------------------------------------------
  // Conectar a um dispositivo específico
  // -----------------------------------------------------------
  Future<Result<bool, String>> connect(String address) async {
    try {
      await _bluetooth.connect(address);

      // Aguarda primeiro evento de mudança de estado para o dispositivo correto
      final state = await _bluetooth.onConnectionChanged
          .firstWhere((s) => s.deviceAddress == address)
          .timeout(const Duration(seconds: 5)); // Timeout para evitar travamento

      if (state.isConnected) {
        return Success(true);
      } else {
        return Failure('Falha ao conectar ao dispositivo $address. Estado final: ${state.isConnected}');
      }
    } on TimeoutException {
      return Failure('Erro de Timeout ao conectar ao dispositivo $address.');
    } catch (e) {
      return Failure('Erro ao conectar ao dispositivo $address: $e');
    }
  }

  // -----------------------------------------------------------
  // Desconectar dispositivo
  // -----------------------------------------------------------
  Future<Result<void, String>> disconnect() async {
    try {
      var r = await _bluetooth.disconnect();
      if (!r) throw Exception("Desconexão mal-sucedida");

      return Success(null);
    } catch (e) {
      return Failure('Erro ao desconectar: $e');
    }
  }

  // -----------------------------------------------------------
  // Enviar mensagem via Bluetooth
  // -----------------------------------------------------------
  Future<Result<void, String>> sendMessage(String msg) async {
    try {
      await _bluetooth.sendString(msg);
      return Success(null);
    } catch (e) {
      return Failure('Erro ao enviar mensagem: $e');
    }
  }

  // -----------------------------------------------------------
  // Callbacks para listeners
  // -----------------------------------------------------------
  @override
  void onConnectionChanged(BluetoothConnectionState state) {
    _connectionController.add(state);
  }

  @override
  void onDataReceived(BluetoothData data) {
    _dataController.add(data.asString());
  }

  // -----------------------------------------------------------
  // Limpeza de recursos
  // -----------------------------------------------------------
  void dispose() {
    _listeners.dispose();
    _connectionController.close();
    _dataController.close();
  }
}
