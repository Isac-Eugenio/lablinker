import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart'
    hide BluetoothState;
import 'package:lablinker/app/views/bluetooth/widgets/build_trailing_icon_widget.dart';
import '../../shared/commands/result.dart';
import 'bluetooth_case.dart';
import 'bluetooth_state.dart';

class BluetoothModelView extends ChangeNotifier {
  final BluetoothCase _case;

  BluetoothState get state => _case.value;

  StateTrailing _stateTrailing = StateTrailing.none;

  String? _currentAttemptAddress;

  // Adicione este setter público
  void setCurrentAttemptAddress(String? address) {
    _currentAttemptAddress = address;
    notifyListeners(); // ESSENCIAL: Notifica a UI sobre qual dispositivo está sendo manipulado
  }

  set stateTrailing(StateTrailing value) {
    _stateTrailing = value;

    // Lógica de limpeza:
    // Se a conexão for concluída (conectado) ou falhar (none),
    // limpamos o endereço de tentativa para que o indicador desapareça
    if (value == StateTrailing.none || value == StateTrailing.connected) {
      _currentAttemptAddress = null;
    }

    notifyListeners();
  }

  StateTrailing get getStateTrailing => _stateTrailing;

  String get targetAddress {
    // Retorna o endereço do dispositivo conectado, se existir.
    if (state.connectedDevice != null) {
      return state.connectedDevice!.address;
    }
    // Caso contrário, retorna o endereço que está tentando conectar.
    return _currentAttemptAddress ?? '';
  }

  BluetoothModelView(this._case) {
    // Observa mudanças no Case e notifica a UI
    _case.addListener(_onCaseUpdated);
  }

  void _onCaseUpdated() {
    notifyListeners();
  }

  // -----------------------------------------------------------
  // Inicializar Bluetooth
  // -----------------------------------------------------------
  Future<Result<bool, String>> initializeBluetooth() {
    return _case.initializeBluetooth();
  }

  // -----------------------------------------------------------
  // Conectar a um dispositivo
  // -----------------------------------------------------------
  // -----------------------------------------------------------
  // Conectar a um dispositivo (Inicia e finaliza o rastreamento de UI)
  // -----------------------------------------------------------
  Future<Result<void, String>> initiateConnection(
    BluetoothDevice device,
  ) async {
    // 1. Início: Configura o estado de UI para 'connecting' (loading)
    // Fazendo a chamada direta para _currentAttemptAddress = device.address;
    // e notifyListeners() evita chamar dois setters seguidos na View.

    // Define qual dispositivo está em tentativa (para o trailing mostrar o loading)
    _currentAttemptAddress = device.address;
    _stateTrailing = StateTrailing.connecting;
    notifyListeners();

    // 2. Executa a conexão (Future)
    final result = await _case.connectToDevice(device);

    // 3. Fim: Avalia o resultado e limpa/define o estado final
    if (result.isFailure) {
      // Se falhar, define o estado como 'none'.
      // O setter de stateTrailing cuidará de chamar notifyListeners()
      // e de limpar _currentAttemptAddress para null.
      stateTrailing = StateTrailing.none;
    } else {
      // Se for sucesso, define o estado como 'connected'.
      // O setter de stateTrailing cuidará de chamar notifyListeners()
      // e de limpar _currentAttemptAddress para null (já que a conexão foi estabelecida).
      stateTrailing = StateTrailing.connected;

      // **Nota:** Esperamos que o BluetoothCase atualize o state.connectedDevice
      // internamente quando a conexão for bem-sucedida.
    }

    return result;
  }

  // -----------------------------------------------------------
  // Desconectar
  // -----------------------------------------------------------
  Future<Result<void, String>> disconnectDevice() {
    return _case.disconnectDevice();
  }

  // -----------------------------------------------------------
  // Enviar mensagem
  // -----------------------------------------------------------
  Future<Result<void, String>> sendMessage(String msg) {
    return _case.sendMessage(msg);
  }

  // -----------------------------------------------------------
  // Atualizar lista de dispositivos pareados
  // -----------------------------------------------------------
  Future<Result<List<BluetoothDevice>, String>> updatePairedDevices() {
    return _case.updatePairedDevices();
  }

  // -----------------------------------------------------------
  // Getters auxiliares para a UI
  // -----------------------------------------------------------
  List<BluetoothDevice> get pairedDevices => state.pairedDevices;
  BluetoothDevice? get connectedDevice => state.connectedDevice;
  BluetoothConnectionState? get connectionState => state.connectionState;
  bool get isBluetoothAvailable => state.isAvailable;
  String get receivedData => state.receivedData;

  // -----------------------------------------------------------
  // Dispose
  // -----------------------------------------------------------
  @override
  void dispose() {
    _case.removeListener(_onCaseUpdated);
    super.dispose();
  }
}
