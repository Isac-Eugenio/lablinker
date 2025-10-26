import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';
import 'package:lablinker/app/shared/commands/result.dart';

class BluetoothRepository extends ChangeNotifier {
  late final FlutterBluetoothClassic _bluetooth;

  BluetoothRepository() {
    _bluetooth = FlutterBluetoothClassic();
  }

  StreamSubscription<BluetoothConnectionState>? _connSub;
  StreamSubscription<BluetoothData>? _dataSub;

  BluetoothConnectionState? connectionState;
  List<BluetoothDevice> pairedDevices = [];
  BluetoothDevice? connectedDevice;

  bool isAvailable = false;
  String receivedData = '';

  Future<Result<bool, String>> init() async {
    try {
      final supported = await _bluetooth.isBluetoothSupported();
      final enabled = await _bluetooth.isBluetoothEnabled();
      isAvailable = supported && enabled;
      notifyListeners();

      if (!isAvailable) {
        return Failure('Bluetooth não suportado ou desativado');
      }

      await loadPairedDevices();

      _connSub = _bluetooth.onConnectionChanged.listen((s) {
        connectionState = s;
        if (s.isConnected) {
          connectedDevice = pairedDevices.firstWhere(
            (d) => d.address == s.deviceAddress,
            orElse: () => BluetoothDevice(
              name: 'Unknown Device',
              address: s.deviceAddress,
              paired: false,
            ),
          );
        } else {
          connectedDevice = null;
        }
        notifyListeners();
      });

      _dataSub = _bluetooth.onDataReceived.listen((d) {
        receivedData += '${d.asString()}\n';
        notifyListeners();
      });

      return Success(true);
    } catch (e) {
      return Failure('Erro ao inicializar Bluetooth: $e');
    }
  }

  Future<Result<List<BluetoothDevice>, String>> loadPairedDevices() async {
    try {
      pairedDevices = await _bluetooth.getPairedDevices();
      notifyListeners();
      return Success(pairedDevices);
    } catch (e) {
      return Failure('Erro ao carregar dispositivos pareados: $e');
    }
  }

  Future<Result<void, String>> connect(BluetoothDevice device) async {
    try {
      await _bluetooth.connect(device.address);
      return Success(null);
    } catch (e) {
      return Failure('Erro ao conectar ao dispositivo: $e');
    }
  }

  Future<Result<void, String>> disconnect() async {
    try {
      await _bluetooth.disconnect();
      connectedDevice = null;
      notifyListeners();
      return Success(null);
    } catch (e) {
      return Failure('Erro ao desconectar do dispositivo: $e');
    }
  }

  Future<Result<void, String>> sendMessage(String msg) async {
    if (msg.isEmpty) {
      return Failure('Mensagem vazia');
    }

    try {
      await _bluetooth.sendString(msg);
      return Success(null);
    } catch (e) {
      return Failure('Erro ao enviar mensagem: $e');
    }
  }

  @override
  void dispose() {
    _connSub?.cancel();
    _dataSub?.cancel();
    super.dispose();
  }
}
