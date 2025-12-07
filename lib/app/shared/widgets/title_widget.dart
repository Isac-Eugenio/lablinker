/*
------------------------------------
Arquivo: title_widget.dart
Descrição: Widget simples para exibir títulos usando o estilo definido no tema do app
Autor: Isac Eugenio
------------------------------------
*/

import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  // Texto do título
  final String title;

  const TitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      // Aplica o estilo de título grande definido no ThemeData
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
