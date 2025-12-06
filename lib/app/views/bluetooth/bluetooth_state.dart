import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';

class BluetoothState {
  final bool isAvailable;
  final List<BluetoothDevice> pairedDevices;
  final BluetoothDevice? connectedDevice;
  final BluetoothConnectionState? connectionState;
  final String receivedData;

  // 💡 NOVO CAMPO: Armazena o último dispositivo que estava conectado antes do clear/disconnect.
  final BluetoothDevice? lastConnectedDevice;

  const BluetoothState({
    this.isAvailable = false,
    this.pairedDevices = const [],
    this.connectedDevice,
    this.connectionState,
    this.receivedData = '',
    this.lastConnectedDevice, // 💡 NOVO PARÂMETRO NO CONSTRUTOR
  });

  BluetoothState copyWith({
    bool? isAvailable,
    List<BluetoothDevice>? pairedDevices,
    BluetoothDevice? connectedDevice,
    BluetoothConnectionState? connectionState,
    String? receivedData,
    BluetoothDevice? lastConnectedDevice, // 💡 NOVO PARÂMETRO NO copyWith
  }) {
    // 1. Variáveis para armazenar os novos valores
    BluetoothDevice? newConnectedDevice = connectedDevice ?? this.connectedDevice;
    String newReceivedData = receivedData ?? this.receivedData;

    // 2. Lógica de limpeza em caso de desconexão
    if (connectionState != null) {
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
      // O valor de lastConnectedDevice é o fornecido (se houver) OU o valor atual do estado.
      lastConnectedDevice: lastConnectedDevice ?? this.lastConnectedDevice,
    );
  }

  // --- MÉTODO clear() MODIFICADO ---

  /**
   * @description Cria uma nova instância de BluetoothState com os dados de conexão e recebidos limpos,
   * salvando o dispositivo atualmente conectado (this.connectedDevice) como o "último conectado".
   * @returns {BluetoothState} Uma nova instância do estado limpo.
   */
  BluetoothState clear() {
    // Não criamos uma variável local temporária. Passamos diretamente o valor
    // do estado atual (this.connectedDevice) para a cópia do campo 'lastConnectedDevice'.
    return copyWith(
      // 💡 CHAVE DA MUDANÇA: O dispositivo atualmente conectado (this.connectedDevice)
      // é usado para definir o novo valor de 'lastConnectedDevice'.
      lastConnectedDevice: connectedDevice,

      connectedDevice: null,  // Limpa o dispositivo conectado atual
      connectionState: null,  // Limpa o estado da conexão
      receivedData: '',       // Limpa os dados recebidos
    );
  }
}