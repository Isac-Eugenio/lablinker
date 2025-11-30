import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart' hide BluetoothState;
import '../../shared/commands/result.dart';
import 'bluetooth_case.dart';
import 'bluetooth_state.dart';

class BluetoothModelView extends ChangeNotifier {
  final BluetoothCase _case;

  BluetoothState get state => _case.value;

  BluetoothModelView(this._case) {
    // Observa mudanças no Case e notifica a UI
    _case.addListener(_onCaseUpdated);
  }

  void _onCaseUpdated() {
    notifyListeners();
  }

  // -----------------------------------------------------------
  // Inicializar Bluetooth
  // -----------------------------------------------------------
  Future<Result<bool, String>> initializeBluetooth() {
    return _case.initializeBluetooth();
  }

  // -----------------------------------------------------------
  // Conectar a um dispositivo
  // -----------------------------------------------------------
  Future<Result<void, String>> connectToDevice(BluetoothDevice device) {
    return _case.connectToDevice(device);
  }

  // -----------------------------------------------------------
  // Desconectar
  // -----------------------------------------------------------
  Future<Result<void, String>> disconnectDevice() {
    return _case.disconnectDevice();
  }

  // -----------------------------------------------------------
  // Enviar mensagem
  // -----------------------------------------------------------
  Future<Result<void, String>> sendMessage(String msg) {
    return _case.sendMessage(msg);
  }

  // -----------------------------------------------------------
  // Atualizar lista de dispositivos pareados
  // -----------------------------------------------------------
  Future<Result<List<BluetoothDevice>, String>> updatePairedDevices() {
    return _case.updatePairedDevices();
  }

  // -----------------------------------------------------------
  // Getters auxiliares para a UI
  // -----------------------------------------------------------
  List<BluetoothDevice> get pairedDevices => state.pairedDevices;
  BluetoothDevice? get connectedDevice => state.connectedDevice;
  BluetoothConnectionState? get connectionState => state.connectionState;
  bool get isBluetoothAvailable => state.isAvailable;
  String get receivedData => state.receivedData;

  // -----------------------------------------------------------
  // Dispose
  // -----------------------------------------------------------
  @override
  void dispose() {
    _case.removeListener(_onCaseUpdated);
    super.dispose();
  }
}
