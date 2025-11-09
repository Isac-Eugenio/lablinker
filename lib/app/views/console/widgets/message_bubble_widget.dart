import 'package:flutter/material.dart';

class MessageBubbleWidget extends StatelessWidget {
  final String text;
  final bool isUser;

  const MessageBubbleWidget({
    super.key,
    required this.text,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    // Define cores do tema
    final Color userColor = Theme.of(
      context,
    ).colorScheme.primary.withAlpha((0.9 * 255).toInt());
    final Color clientColor = Colors.grey[300]!;
    final Color userTextColor = Colors.white;
    final Color clientTextColor = Colors.black87;

    // Define alinhamento e bordas
    final alignment = isUser
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(12),
      topRight: const Radius.circular(12),
      bottomLeft: isUser ? const Radius.circular(12) : const Radius.circular(0),
      bottomRight: isUser
          ? const Radius.circular(0)
          : const Radius.circular(12),
    );

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 6,
            bottom: 6,
            left: isUser ? 50 : 0, // espaçamento lateral
            right: isUser ? 0 : 50,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: isUser ? userTextColor : clientTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
