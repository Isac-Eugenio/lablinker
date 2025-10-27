import 'package:flutter/material.dart';

class NotificationWidget {
  final BuildContext context;
  final String message;
  final int durationSeconds;

  NotificationWidget({
    required this.context,
    required this.message,
    required this.durationSeconds,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: durationSeconds),
      ),
    );
  }
}
