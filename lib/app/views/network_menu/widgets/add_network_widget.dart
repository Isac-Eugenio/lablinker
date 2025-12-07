/*
-----------------------------------------------------------
Arquivo: add_network_widget.dart
Descrição: Widget de botão para adicionar nova rede.
           Redireciona para a tela de cadastro de rede via rota.
Autor: Isac Eugenio
-----------------------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes.dart';

class AddNetworkWidget extends StatelessWidget {
  final String routeRollback; // Rota de rollback (não utilizada neste exemplo)

  const AddNetworkWidget({super.key, required this.routeRollback});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add), // Ícone de adicionar
      onPressed: () => Navigator.pushNamed(context, Routes.addNetwork), // Navega para tela de adicionar rede
    );
  }
}
