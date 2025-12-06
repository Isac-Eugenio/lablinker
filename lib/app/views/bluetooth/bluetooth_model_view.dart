import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart'
    hide BluetoothState;
import 'package:lablinker/app/views/bluetooth/widgets/build_trailing_icon_widget.dart';
import '../../shared/commands/result.dart';
import 'bluetooth_case.dart';
import 'bluetooth_state.dart';

// ViewModel responsável por expor o estado do Bluetooth para a UI
// e orquestrar as ações de conexão/desconexão/envio de dados.
class BluetoothModelView extends ChangeNotifier {
  final BluetoothCase _case;
  // Getter para expor o estado reativo do Bluetooth (ValueNotifier)
  BluetoothState get state => _case.value;

  // Variável interna para rastrear o estado visual do ícone de trailing (loading/conectado/nenhum)
  StateTrailing _stateTrailing = StateTrailing.none;

  // Variável interna para rastrear o endereço do dispositivo que está sendo ativamente manipulado (tentativa de conexão)
  String? _currentAttemptAddress;

  // Adicione este setter público
  void setCurrentAttemptAddress(String? address) {
    _currentAttemptAddress = address;
    notifyListeners(); // ESSENCIAL: Notifica a UI sobre qual dispositivo está sendo manipulado
  }

  // Setter para atualizar o estado visual do trailing e limpar o rastreamento da tentativa se a ação terminar
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

  // Getter para expor o estado visual do trailing
  StateTrailing get getStateTrailing => _stateTrailing;

  // CORREÇÃO: BluetoothModelView - targetAddress
  // Este getter define qual endereço deve receber o status visual (loading ou conectado)
  String get targetAddress {
    // 1. PRIORIDADE: Se estiver ATIVAMENTE tentando conectar (loading), retorne este endereço.
    // Isso garante que o loading apareça no dispositivo correto.
    if (_currentAttemptAddress != null) {
      return _currentAttemptAddress!;
    }

    // 2. Se não houver tentativa ativa, retorne o endereço do dispositivo CONECTADO.
    if (state.connectedDevice != null) {
      return state.connectedDevice!.address;
    }

    // 3. Caso contrário, vazio.
    return '';
  }

  // Construtor
  BluetoothModelView(this._case) {
    // Observa mudanças no Case e notifica a UI
    _case.addListener(_onCaseUpdated);
  }

  // Método de callback para notificar a UI quando o estado do Case muda
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
  // Conectar a um dispositivo (Inicia e finaliza o rastreamento de UI)
  // -----------------------------------------------------------
  Future<Result<void, String>> initiateConnection(
      BluetoothDevice device,
      ) async {
    // [ADICIONADO] Se já houver um dispositivo conectado, desconecte-o primeiro.
    // Isso é crucial para garantir que apenas um dispositivo esteja ativo por vez.
    if (state.connectedDevice != null &&
        state.connectedDevice!.address != device.address) {
      // Limpa a conexão anterior antes de tentar uma nova
      await _case.disconnectDevice();
      // Não se preocupe com o estado do UI aqui, pois ele será atualizado
      // pelo listener do _case assim que o estado da conexão for limpo.
    }

    // 1. Início: Configura o estado de UI para 'connecting' (loading)
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



    // Retorna o resultado da tentativa de conexão
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
    // Remove o listener para evitar vazamento de memória
    _case.removeListener(_onCaseUpdated);
    super.dispose();
  }
}