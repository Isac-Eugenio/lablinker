import 'package:flutter/material.dart';

class MessageBubbleWidget extends StatelessWidget {
  final String text;
  final bool isUser;
  final String deviceName;

  const MessageBubbleWidget({
    super.key,
    required this.text,
    required this.isUser,
    required this.deviceName,
  });

  @override
  Widget build(BuildContext context) {
    // Define cores
    final Color userColor = Theme.of(context).colorScheme.primary.withAlpha((0.9 * 255).toInt());
    final Color clientColor = Colors.grey[300]!;
    final Color userTextColor = Colors.white;
    final Color clientTextColor = Colors.black87;

    // Define alinhamento
    final alignment = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    // LÓGICA DO NOME: Título a ser exibido dentro do balão
    final String labelText = isUser ? "Este Dispositivo" : deviceName;

    // Define as cores do texto (o título terá uma cor ligeiramente diferente)
    final Color messageColor = isUser ? userTextColor : clientTextColor;
    final Color titleColor = isUser ? userTextColor.withOpacity(0.8) : clientTextColor.withOpacity(0.7);

    // Define bordas
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
          // 💡 Ajustei o padding:
          // O padding superior e inferior é menor aqui, pois o espaçamento será interno.
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
          // 💡 NOVO: Coluna interna para empilhar o Título e a Mensagem
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Títulos sempre começam à esquerda do balão
            children: [
              // 1. TÍTULO DO DISPOSITIVO
              Text(
                labelText,
                style: TextStyle(
                  fontSize: 12,
                  color: titleColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4), // Espaçamento entre o título e a mensagem

              // 2. TEXTO DA MENSAGEM
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