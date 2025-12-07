/*
------------------------------------
Classe: MessageModel
Descrição: Representa uma mensagem, com texto e indicador se foi enviada pelo usuário
Autor: Isac Eugenio
------------------------------------
*/

class MessageModel {
  // Texto da mensagem
  final String text;

  // Define se a mensagem foi enviada pelo usuário (true) ou pelo sistema (false)
  final bool isUser;

  // Construtor que inicializa os campos text e isUser
  MessageModel(this.text, this.isUser);
}
