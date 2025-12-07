/*
------------------------------------
Arquivo: notification_widget.dart
Descrição: Exibe uma notificação rápida (SnackBar) na tela usando ScaffoldMessenger
Autor: Isac Eugenio
------------------------------------
*/

import 'package:flutter/material.dart';

class NotificationWidget {
  // Contexto da tela onde a notificação será exibida
  final BuildContext context;

  // Mensagem que será mostrada
  final String message;

  // Duração em segundos da exibição do SnackBar
  final int durationSeconds;

  NotificationWidget({
    required this.context,
    required this.message,
    required this.durationSeconds,
  }) {
    // Mostra o SnackBar automaticamente ao instanciar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: durationSeconds),
      ),
    );
  }
}
