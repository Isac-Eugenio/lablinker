/*
-----------------------------------------------------------
Arquivo: console_modelview.dart
Descrição: Gerencia o console de mensagens via Bluetooth.
           Recebe, processa e exibe mensagens do dispositivo remoto.
           Permite envio de comandos e rastreia mensagens completas.
Autor: Isac Eugenio
-----------------------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:lablinker/app/views/bluetooth/bluetooth_state.dart';
import '../../models/message_model.dart';
import '../bluetooth/bluetooth_model_view.dart';

class ConsoleModelview extends ChangeNotifier {
  final BuildContext context;
  final BluetoothModelView bluetooth;

  final TextEditingController commandController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final List<MessageModel> messages = [];

  // Estado do Bluetooth
  BluetoothState get bluetoothState => bluetooth.state;

  // Buffer parcial de mensagens recebidas
  String _inputBuffer = '';
  static const String _delimiter = '\n';

  // Armazena o último dado TOTAL recebido
  String _lastReceivedData = '';
  String? _lastValidReceivedMessage;

  ConsoleModelview(this.bluetooth, this.context) {
    bluetooth.addListener(_handleReceivedData);
  }

  // Parsing de dados recebidos via Bluetooth
  void _handleReceivedData() {
    final currentReceivedData = bluetooth.receivedData;

    // Reset caso buffer seja menor (ex: desconexão)
    if (currentReceivedData.length < _lastReceivedData.length) {
      _lastReceivedData = '';
      _inputBuffer = '';
    }

    if (currentReceivedData == _lastReceivedData) return; // nada novo

    // Extrai apenas o novo chunk
    final newDataChunk = currentReceivedData.substring(_lastReceivedData.length);
    if (newDataChunk.isEmpty) return;

    _lastReceivedData = currentReceivedData;

    // Concatena com buffer parcial anterior
    _inputBuffer += newDataChunk;

    // Separa por delimitador
    final parts = _inputBuffer.split(_delimiter);

    // Último elemento pode estar incompleto, permanece no buffer
    _inputBuffer = parts.last;

    // Mensagens completas filtradas
    final completeMessages = parts.sublist(0, parts.length - 1);
    final List<MessageModel> newFilteredMessages = [];

    for (var msgText in completeMessages) {
      final trimmedText = msgText.trim();
      if (trimmedText.isEmpty) continue;
      if (trimmedText == _lastValidReceivedMessage) continue; // deduplicação

      newFilteredMessages.add(MessageModel(trimmedText, false));
      _lastValidReceivedMessage = trimmedText;
    }

    if (newFilteredMessages.isNotEmpty) {
      messages.addAll(newFilteredMessages);
      notifyListeners();
      _scrollToBottom();
    }
  }

  // Scroll automático para o fim da lista
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // Envia comando via Bluetooth e adiciona à lista local
  void sendCommand(String command) async {
    if (command.isEmpty || bluetooth.connectedDevice == null) return;

    final commandWithDelimiter = '$command$_delimiter';

    final result = await bluetooth.sendMessage(commandWithDelimiter);

    if (result.isFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao enviar a mensagem!"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    messages.add(MessageModel(command, true));
    commandController.clear();
    notifyListeners();
    _scrollToBottom();
  }

  // Limpa todas as mensagens e buffers
  void clearMessages() {
    messages.clear();
    commandController.clear();
    _inputBuffer = '';
    _lastReceivedData = '';
    _lastValidReceivedMessage = null;
    bluetooth.clearBuffer();
    notifyListeners();
  }

  @override
  void dispose() {
    bluetooth.removeListener(_handleReceivedData);
    commandController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
