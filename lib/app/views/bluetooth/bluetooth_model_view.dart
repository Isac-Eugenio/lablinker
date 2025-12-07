/*
------------------------------------
Arquivo: bluetooth_model_view.dart
Descrição: ViewModel que expõe o estado do Bluetooth para a UI e gerencia ações de conexão, desconexão e envio de dados
Autor: Isac Eugenio
------------------------------------
*/

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart'
    hide BluetoothState;
import 'package:lablinker/app/views/bluetooth/widgets/build_trailing_icon_widget.dart';
import '../../shared/commands/result.dart';
import 'bluetooth_case.dart';
import 'bluetooth_state.dart';

// ViewModel responsável por controlar a UI do Bluetooth
class BluetoothModelView extends ChangeNotifier {
  final BluetoothCase _case;

  // Expondo o estado do Bluetooth
  BluetoothState get state => _case.value;

  // Estado visual do ícone trailing (loading/conectado/nenhum)
  StateTrailing _stateTrailing = StateTrailing.none;

  // Dispositivo atualmente em tentativa de conexão
  String? _currentAttemptAddress;

  // Setter público para rastrear dispositivo em tentativa
  void setCurrentAttemptAddress(String? address) {
    _currentAttemptAddress = address;
    notifyListeners(); // Atualiza UI
  }

  // Setter para atualizar estado visual do trailing
  set stateTrailing(StateTrailing value) {
    _stateTrailing = value;

    // Limpa endereço de tentativa se conexão concluída ou falhou
    if (value == StateTrailing.none || value == StateTrailing.connected) {
      _currentAttemptAddress = null;
    }

    notifyListeners();
  }

  // Getter do estado visual do trailing
  StateTrailing get getStateTrailing => _stateTrailing;

  // Getter do endereço alvo para mostrar status visual
  String get targetAddress {
    if (_currentAttemptAddress != null) return _currentAttemptAddress!;
    if (state.connectedDevice != null) return state.connectedDevice!.address;
    return '';
  }

  // Construtor: adiciona listener no Case
  BluetoothModelView(this._case) {
    _case.addListener(_onCaseUpdated);
  }

  // Callback quando o Case muda
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
  Future<Result<void, String>> initiateConnection(BluetoothDevice device) async {
    // Desconecta dispositivo ativo se for diferente
    if (state.connectedDevice != null && state.connectedDevice!.address != device.address) {
      await _case.disconnectDevice();
    }

    // Define estado visual de conexão
    _currentAttemptAddress = device.address;
    _stateTrailing = StateTrailing.connecting;
    notifyListeners();

    // Executa a conexão
    final result = await _case.connectToDevice(device);

    // Atualiza estado visual conforme sucesso ou falha
    if (result.isFailure) {
      stateTrailing = StateTrailing.none;
    } else {
      stateTrailing = StateTrailing.connected;
    }

    return result;
  }

  // -----------------------------------------------------------
  // Desconectar dispositivo
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

  // Limpa buffer de dados recebidos
  void clearBuffer() {
    _case.clearReceivedBuffer();
  }

  // -----------------------------------------------------------
  // Getters auxiliares para a UI
  // -----------------------------------------------------------
  List<BluetoothDevice> get pairedDevices => state.pairedDevices;
  BluetoothDevice? get connectedDevice => state.connectedDevice;
  BluetoothConnectionState? get connectionState => state.connectionState;
  bool get isBluetoothAvailable => state.isAvailable;
  String get receivedData => state.receivedData;

  StreamSubscription<String>? get dataSub => _case.dataSub;

  // -----------------------------------------------------------
  // Dispose
  // -----------------------------------------------------------
  @override
  void dispose() {
    _case.removeListener(_onCaseUpdated);
    super.dispose();
  }
}
