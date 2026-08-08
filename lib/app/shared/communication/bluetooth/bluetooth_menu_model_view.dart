import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';
import 'package:lablinker/app/shared/communication/bluetooth/bluetooth_model_view.dart';

class BluetoothMenuModelView extends BluetoothModelView {
  BluetoothMenuModelView(super.bluetoothCase);

  String? _connectingDeviceAddress;
  String? _disconnectingDeviceAddress;

  bool isConnectingDevice(BluetoothDevice? device) =>
      device?.address == _connectingDeviceAddress;

  bool isDisconnectingDevice(BluetoothDevice? device) =>
      device?.address == _disconnectingDeviceAddress;

  void setConnectingDeviceAddress(String? address) {
    _connectingDeviceAddress = address;
    notifyListeners();
  }

  void setDisconnectingDeviceAddress(String? address) {
    _disconnectingDeviceAddress = address;
    notifyListeners();
  }

  bool isConnected(BluetoothDevice? device) {
    final connected = connectedDevice;

    if (connected == null || device == null) return false;

    return connected.address == device.address;
  }

  Future<void> toggleConnection(BluetoothDevice device) async {
    if (isConnected(device)) {
      setDisconnectingDeviceAddress(device.address);
      await disconnect();
      setDisconnectingDeviceAddress(null);
    } else {
      setConnectingDeviceAddress(device.address);
      await connect(device);
      setConnectingDeviceAddress(null);
    }
    notifyListeners();
  }
}
