import 'package:flutter/cupertino.dart';
import 'package:lablinker/app/models/message_model.dart';

class ConsoleModelview extends ChangeNotifier{
  final TextEditingController commandController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final List<MessageModel> messages = [];

  void sendCommand(String command) {
    if (command.isEmpty) return;

    // Mensagem do usuário (direita)
    messages.add(MessageModel(command, true));

    // Simula uma resposta
    messages.add(MessageModel("Executando: $command", false));

    commandController.clear();
    notifyListeners();

    // Scroll até o final
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  void clearMessages() {
    messages.clear();
    notifyListeners();
  }
  
}