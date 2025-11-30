import 'package:flutter/material.dart';

import '../../models/message_model.dart';
import '../../shared/commands/result.dart';
import '../bluetooth/bluetooth_model_view.dart';

class ConsoleModelview extends ChangeNotifier {
  final BuildContext context;
  final BluetoothModelView bluetooth;

  ConsoleModelview(this.bluetooth, this.context);

  final TextEditingController commandController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final List<MessageModel> messages = [];

  void sendCommand(String command) async {
    if (command.isEmpty) return;

    Result<void, String> result = await bluetooth.sendMessage(command);

    if (result.isFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao Enviar a mensagem !"),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    messages.add(MessageModel(command, true));
    messages.add(MessageModel("Executando: $command", false));

    commandController.clear();
    notifyListeners();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  void clearMessages() {
    messages.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    commandController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
