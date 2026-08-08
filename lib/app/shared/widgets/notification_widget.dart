/*
------------------------------------
Arquivo: notification_widget.dart
Descrição: Exibe uma notificação rápida (SnackBar) na tela usando ScaffoldMessenger
Autor: Isac Eugenio
------------------------------------
*/

import 'package:flutter/material.dart';

enum NotificationType {
  failure(Colors.deepOrangeAccent),
  message(Colors.white10),
  loading(Colors.yellow),
  success(Colors.green),
  error(Colors.red);

  final Color color;

  const NotificationType(this.color);
}

class NotificationWidget {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static void show(
    String message, {
    int durationSeconds = 3,
    NotificationType typeMessage = NotificationType.message,
  }) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: durationSeconds),
        backgroundColor: typeMessage.color,
      ),
    );
  }
}
