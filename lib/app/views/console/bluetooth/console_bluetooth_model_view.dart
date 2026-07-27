// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';

import 'package:lablinker/app/views/bluetooth/bluetooth_case.dart';
import 'package:lablinker/app/views/bluetooth/bluetooth_command.dart';

class ConsoleBluetoothModelView extends ChangeNotifier {
  final BluetoothCase bluetoothCase;

  ConsoleBluetoothModelView(this.bluetoothCase);

  final BluetoothCommand<bool> _initCommand = BluetoothCommand<bool>();
  final BluetoothCommand<bool> _connectCommand = BluetoothCommand<bool>();
  final BluetoothCommand<List<BluetoothDevice>> _updateCommand =
      BluetoothCommand<List<BluetoothDevice>>();

  List<BluetoothDevice>? get devicePaired => _updateCommand.result?.getOrNull();
  bool get isInitialized => _initCommand.isSuccess;

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

    return _connectCommand.isSuccess;
  }

  Future<bool> disconnect() async {
    await _connectCommand.executeAsync(bluetoothCase.disconnectDevice);

    notifyListeners();

    return _connectCommand.isSuccess;
  }
}
