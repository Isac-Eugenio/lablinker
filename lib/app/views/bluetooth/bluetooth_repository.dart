import 'dart:async';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';
import '../../shared/commands/result.dart';
import 'bluetooth_listeners.dart';

class BluetoothRepository implements BluetoothCallbacks {
  final FlutterBluetoothClassic _bluetooth = FlutterBluetoothClassic();
  late final BluetoothListeners _listeners;

  final _connectionController = StreamController<BluetoothConnectionState>.broadcast();
  final _dataController = StreamController<String>.broadcast();

  Stream<BluetoothConnectionState> get connectionStream =>
      _connectionController.stream;

  Stream<String> get dataStream => _dataController.stream;

  FlutterBluetoothClassic get bluetoothClassic  => _bluetooth;

  BluetoothRepository() {
    _listeners = BluetoothListeners(
      bluetooth: _bluetooth,
      callbacks: this,
    );
  }

  // Inicialização
  Future<bool> init() async {
    try {
      final supported = await _bluetooth.isBluetoothSupported();
      final enabled = await _bluetooth.isBluetoothEnabled();
      final available = supported && enabled;

      if (!available) return false;

      _listeners.start();
      return true;
    } catch (e) {
      throw 'Erro ao inicializar Bluetooth: $e';
    }
  }

  // Obter dispositivos pareados
  Future<List<BluetoothDevice>> getPairedDevices() async {
    try {
      return await _bluetooth.getPairedDevices();
    } catch (e) {
      throw 'Erro ao obter dispositivos pareados: $e';
    }
  }

  // Conectar a um dispositivo
  Future<Result<void, String>> connect(String address) async {
    try {
      await _bluetooth.connect(address);
      return Success(null); // encapsula void
    } catch (e) {
      return Failure('Erro ao conectar ao dispositivo $address: $e');
    }
  }


  // Desconectar
  Future<Result<void, String>> disconnect() async {
    try {
      await _bluetooth.disconnect();
      return Success(null);
    } catch (e) {
      return Failure('Erro ao desconectar: $e');
    }
  }

  Future<Result<void, String>> sendMessage(String msg) async {
    try {
      await _bluetooth.sendString(msg);
      return Success(null);
    } catch (e) {
      return Failure('Erro ao enviar mensagem: $e');
    }
  }

  // LISTENER CALLBACKS
  @override
  void onConnectionChanged(BluetoothConnectionState state) {
    _connectionController.add(state);
  }

  @override
  void onDataReceived(BluetoothData data) {
    _dataController.add(data.asString());
  }

  void dispose() {
    _listeners.dispose();
    _connectionController.close();
    _dataController.close();
  }
}
