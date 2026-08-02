/*
--------------------------------------------
Arquivo: message_bubble_widget.dart
Descrição: Balão de mensagem para chat local/externo.
           Exibe o texto da mensagem e o nome do dispositivo remetente.
           Suporta alinhamento dinâmico para usuário ou outro dispositivo.
Autor: Isac Eugenio
--------------------------------------------
*/

import 'package:flutter/material.dart';

class MessageBubbleWidget extends StatelessWidget {
  final String text;
  final bool isUser;        // true = mensagem deste dispositivo
  final String deviceName;  // nome do outro dispositivo

  const MessageBubbleWidget({
    super.key,
    required this.text,
    required this.isUser,
    required this.deviceName,
  });

  @override
  Widget build(BuildContext context) {
    // --- Cores ---
    final Color userColor = Theme.of(context)
        .colorScheme
        .primary
        .withAlpha((0.9 * 255).toInt()); // balão do usuário
    final Color clientColor = Colors.grey[300]!; // balão do outro dispositivo
    final Color userTextColor = Colors.white;
    final Color clientTextColor = Colors.black87;

    // --- Alinhamento ---
    final alignment = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    // --- Título dentro do balão ---
    final String labelText = isUser ? "Este Dispositivo" : deviceName;

    // --- Cores do texto ---
    final Color messageColor = isUser ? userTextColor : clientTextColor;
    final Color titleColor = isUser
        // ignore: deprecated_member_use
        ? userTextColor.withOpacity(0.8)
        // ignore: deprecated_member_use
        : clientTextColor.withOpacity(0.7);

    // --- Bordas arredondadas (diferente para usuário/cliente) ---
    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(12),
      topRight: const Radius.circular(12),
      bottomLeft: isUser ? const Radius.circular(12) : const Radius.circular(0),
      bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(12),
    );

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 6,
            bottom: 6,
            left: isUser ? 50 : 0,
            right: isUser ? 0 : 50,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isUser ? userColor : clientColor,
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.05 * 255).toInt()),
                offset: const Offset(0, 2),
                blurRadius: 3,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Título do dispositivo ---
              Text(
                labelText,
                style: TextStyle(
                  fontSize: 12,
                  color: titleColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              // --- Texto da mensagem ---
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: messageColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
