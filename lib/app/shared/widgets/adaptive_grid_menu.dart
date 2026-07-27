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

enum AdaptiveGridMenuMode { list, grid }

class AdaptiveGridMenu extends StatelessWidget {
  final AdaptiveGridMenuMode mode;

  final List<Widget> items; // Lista de itens a serem exibidos

  const AdaptiveGridMenu({super.key, required this.items, required this.mode});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;

        switch (mode) {
          case AdaptiveGridMenuMode.list:
            crossAxisCount = 1;
            break;

          case AdaptiveGridMenuMode.grid:
            crossAxisCount = items.length <= 2
                ? items.length
                : sqrt(items.length).ceil();
            break;
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.2,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: items,
          ),
        );
      },
    );
  }
}
