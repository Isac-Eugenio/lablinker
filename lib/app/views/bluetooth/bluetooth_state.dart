/*
------------------------------------
Arquivo: bluetooth_state.dart
Descrição: Representa o estado reativo do Bluetooth no app,
           incluindo disponibilidade, dispositivos pareados,
           dispositivo conectado, dados recebidos e histórico
           do último dispositivo conectado.
Autor: Isac Eugenio
------------------------------------
*/

import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';

class BluetoothState {
  final bool isAvailable;                   // Bluetooth disponível?
  final List<BluetoothDevice> pairedDevices; // Lista de dispositivos pareados
  final BluetoothDevice? connectedDevice;    // Dispositivo atualmente conectado
  final BluetoothConnectionState? connectionState; // Estado da conexão
  final String receivedData;                 // Dados recebidos
  final BluetoothDevice? lastConnectedDevice; // Último dispositivo conectado antes do clear/disconnect

  const BluetoothState({
    this.isAvailable = false,
    this.pairedDevices = const [],
    this.connectedDevice,
    this.connectionState,
    this.receivedData = '',
    this.lastConnectedDevice,
  });

  // -----------------------------------------------------------
  // Cria uma cópia do estado, permitindo sobrescrever campos
  // -----------------------------------------------------------
  BluetoothState copyWith({
    bool? isAvailable,
    List<BluetoothDevice>? pairedDevices,
    BluetoothDevice? connectedDevice,
    BluetoothConnectionState? connectionState,
    String? receivedData,
    BluetoothDevice? lastConnectedDevice,
  }) {
    // Variáveis temporárias para ajustes
    BluetoothDevice? newConnectedDevice = connectedDevice ?? this.connectedDevice;
    String newReceivedData = receivedData ?? this.receivedData;

    // Se houver atualização no estado de conexão e ela for desconectada,
    // limpamos o dispositivo conectado e os dados recebidos
    if (connectionState != null && connectionState.isConnected == false) {
      newConnectedDevice = null;
      newReceivedData = '';
    }

    return BluetoothState(
      isAvailable: isAvailable ?? this.isAvailable,
      pairedDevices: pairedDevices ?? this.pairedDevices,
      connectedDevice: newConnectedDevice,
      receivedData: newReceivedData,
      connectionState: connectionState ?? this.connectionState,
      lastConnectedDevice: lastConnectedDevice ?? this.lastConnectedDevice,
    );
  }

  // -----------------------------------------------------------
  // Limpa dados de conexão, mas preserva o último dispositivo conectado
  // -----------------------------------------------------------
  BluetoothState clear() {
    return copyWith(
      lastConnectedDevice: connectedDevice, // salva o conectado atual
      connectedDevice: null,                // limpa o conectado
      connectionState: null,                // limpa estado da conexão
      receivedData: '',                     // limpa dados recebidos
    );
  }
}
