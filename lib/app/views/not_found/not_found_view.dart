import 'package:flutter/material.dart';

import '../../shared/theme/theme_widgets.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: ColorsPrimarySystem.primaryColor.color,
    body: Center(
      child: Text(
        "Nenhuma Página Encontrada (Debug)",
        style: TextTheme.of(context).titleMedium,
      ),
    ),
  );
}
