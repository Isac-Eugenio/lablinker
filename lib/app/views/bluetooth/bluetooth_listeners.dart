import 'dart:async';

import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';

abstract class BluetoothCallbacks {
  void onConnectionChanged(BluetoothConnectionState state);
  void onDataReceived(BluetoothData data);
}

class BluetoothListeners {
  final FlutterBluetoothClassic bluetooth;
  final BluetoothCallbacks callbacks;

  StreamSubscription<BluetoothConnectionState>? _connSub;
  StreamSubscription<BluetoothData>? _dataSub;

  BluetoothListeners({
    required this.bluetooth,
    required this.callbacks,
  });

  void start() {
    _connSub = bluetooth.onConnectionChanged.listen(callbacks.onConnectionChanged);
    _dataSub = bluetooth.onDataReceived.listen(callbacks.onDataReceived);
  }

  void dispose() {
    _connSub?.cancel();
    _dataSub?.cancel();
  }
}


