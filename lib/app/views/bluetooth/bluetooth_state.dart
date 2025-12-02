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
    // 1. Variáveis para armazenar os novos valores de connectedDevice e receivedData
    BluetoothDevice? newConnectedDevice = connectedDevice ?? this.connectedDevice;
    String newReceivedData = receivedData ?? this.receivedData;

    // 2. Verifica se um novo connectionState foi fornecido
    if (connectionState != null) {
      // ASSUME que BluetoothConnectionState tem uma propriedade 'isConnected'
      // Se a nova conexão NÃO estiver conectada, limpamos o dispositivo e os dados
      if (connectionState.isConnected == false) {
        newConnectedDevice = null;
        newReceivedData = '';
      }
    }

    return BluetoothState(
      isAvailable: isAvailable ?? this.isAvailable,
      pairedDevices: pairedDevices ?? this.pairedDevices,
      connectedDevice: newConnectedDevice,
      receivedData: newReceivedData,
      connectionState: connectionState ?? this.connectionState,
    );
  }

  // --- NOVO MÉTODO clear() ---

  /**
   * @description Cria uma nova instância de BluetoothState com os dados de conexão e recebidos limpos,
   * mantendo o estado de disponibilidade (isAvailable) e a lista de dispositivos pareados (pairedDevices).
   * @returns {BluetoothState} Uma nova instância do estado limpo.
   */
  BluetoothState clear() {
    return copyWith(
      connectedDevice: null, // Limpa o dispositivo conectado
      connectionState: null,  // Limpa o estado da conexão
      receivedData: '',       // Limpa os dados recebidos
    );
  }
}