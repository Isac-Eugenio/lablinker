/*
------------------------------------
Arquivo: bluetooth_listeners.dart
Descrição: Gerencia listeners de conexão e dados do Bluetooth usando callbacks
Autor: Isac Eugenio
------------------------------------
*/


// Interface para receber callbacks de eventos Bluetooth
import 'dart:async';

import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';

abstract class BluetoothCallbacks {
  void onConnectionChanged(BluetoothConnectionState state);
  void onDataReceived(BluetoothData data);
}

// Classe que registra e gerencia listeners de streams do Bluetooth
class BluetoothListeners {
  // Instância do Bluetooth
  final FlutterBluetoothClassic bluetooth;

  // Callbacks para tratar eventos
  final BluetoothCallbacks callbacks;

  // Subscriptions das streams
  StreamSubscription<BluetoothConnectionState>? _connSub;
  StreamSubscription<BluetoothData>? _dataSub;

  BluetoothListeners({
    required this.bluetooth,
    required this.callbacks,
  });

  // Inicia a escuta das streams de conexão e dados
  void start() {
    _connSub = bluetooth.onConnectionChanged.listen(callbacks.onConnectionChanged);
    _dataSub = bluetooth.onDataReceived.listen(callbacks.onDataReceived);
  }

  // Cancela a escuta das streams
  void dispose() {
    _connSub?.cancel();
    _dataSub?.cancel();
  }
}
