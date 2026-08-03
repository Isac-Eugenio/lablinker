// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';
import 'package:lablinker/app/shared/communication/bluetooth/bluetooth_case.dart';
import 'package:lablinker/app/shared/communication/bluetooth/bluetooth_command.dart';

abstract class BluetoothModelView extends ChangeNotifier {
  final BluetoothCase bluetoothCase;

  BluetoothModelView(this.bluetoothCase);

  final BluetoothCommand<bool> _initCommand = BluetoothCommand<bool>();
  final BluetoothCommand<bool> _connectCommand = BluetoothCommand<bool>();
  final BluetoothCommand<List<BluetoothDevice>> _updateCommand =
      BluetoothCommand<List<BluetoothDevice>>();

  List<BluetoothDevice>? get devicePaired => _updateCommand.result?.getOrNull();

  BluetoothDevice? get connectedDevice => bluetoothCase.value.connectedDevice;

  bool get isInitialized => bluetoothCase.value.isAvailable;

  Future<bool> init() async {
    await _initCommand.executeAsync(bluetoothCase.initializeBluetooth);

    notifyListeners();

    return _initCommand.isSuccess;
  }

  Future<bool> update() async {
    await _updateCommand.executeAsync(bluetoothCase.updatePairedDevices);

    notifyListeners();

    return _updateCommand.isSuccess;
  }

  Future<bool> connect(BluetoothDevice device) async {
    await _connectCommand.executeWithAsync(
      bluetoothCase.connectToDevice,
      device,
    );

    notifyListeners();

    debugPrint(_connectCommand.error.toString());

    return _connectCommand.isSuccess;
  }

  Future<bool> disconnect() async {
    await _connectCommand.executeAsync(bluetoothCase.disconnectDevice);

    notifyListeners();

    return _connectCommand.isSuccess;
  }

  bool isConnected(BluetoothDevice? device) {
    final connected = connectedDevice;

    if (connected == null || device == null) return false;
    
    return connected.address == device.address;
  }
}
