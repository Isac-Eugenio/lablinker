import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';

class BluetoothState {
  final bool isAvailable;
  final List<BluetoothDevice> pairedDevices;
  final BluetoothDevice? connectedDevice;
  final BluetoothConnectionState? connectionState;
  final String receivedData;

  const BluetoothState({
    this.isAvailable = false,
    this.pairedDevices = const [],
    this.connectedDevice,
    this.connectionState,
    this.receivedData = '',
  });

  BluetoothState copyWith({
    bool? isAvailable,
    List<BluetoothDevice>? pairedDevices,
    BluetoothDevice? connectedDevice,
    BluetoothConnectionState? connectionState,
    String? receivedData,
  }) {
    return BluetoothState(
      isAvailable: isAvailable ?? this.isAvailable,
      pairedDevices: pairedDevices ?? this.pairedDevices,
      connectedDevice: connectedDevice ?? this.connectedDevice,
      connectionState: connectionState ?? this.connectionState,
      receivedData: receivedData ?? this.receivedData,
    );
  }
}
