/*
-----------------------------------------------------------
Arquivo: adaptive_grid_menu.dart
Descrição: Componente de grid adaptativo que organiza itens
           automaticamente em colunas com base na quantidade
           de itens disponíveis.
Autor: Isac Eugenio
-----------------------------------------------------------
*/

import 'package:flutter/material.dart';
import 'dart:math';

class AdaptiveGridMenu extends StatelessWidget {
  final List<Widget> items; // Lista de itens a serem exibidos
  const AdaptiveGridMenu({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calcula automaticamente o número de colunas
        // Se tiver 2 ou menos itens, usa a quantidade exata
        // Caso contrário, calcula a raiz quadrada arredondada para cima
        int crossAxisCount = items.length <= 2 ? items.length : (sqrt(items.length)).ceil();

        return Padding(
          padding: const EdgeInsets.all(16.0), // Espaçamento externo do grid
          child: GridView.count(
            crossAxisCount: crossAxisCount, // Número de colunas
            mainAxisSpacing: 16, // Espaço vertical entre itens
            crossAxisSpacing: 16, // Espaço horizontal entre itens
            childAspectRatio: 1.2, // Proporção largura/altura dos itens
            physics: const NeverScrollableScrollPhysics(), // Grid fixo, sem scroll
            children: items, // Itens do grid
          ),
        );
      },
    );
  }
}
