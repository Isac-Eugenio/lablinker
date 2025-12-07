/*
-----------------------------------------------------------
Arquivo: home_view.dart
Descrição: Tela inicial do app que exibe um menu adaptativo em grid.
           Ajusta automaticamente o número de colunas conforme a
           quantidade de itens e direciona para telas específicas.
Autor: Isac Eugenio
-----------------------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes.dart';
import 'package:lablinker/app/shared/widgets/app_bar_widget.dart';
import 'package:lablinker/app/views/home/widgets/adaptive_grid_menu.dart';
import 'package:lablinker/app/views/home/widgets/item_page_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra de navegação personalizada
      appBar: AppBarWidget(title: 'Menu', rollback: false),

      body: SafeArea(
        child: AdaptiveGridMenu(
          // Lista de itens do menu
          items: [
            // Cada item é um ItemPageWidget que pode ter rota de navegação
            ItemPageWidget(
              title: 'Gamepad',
              icon: Icons.videogame_asset,
              route: Routes.gamepad,
            ),
            const ItemPageWidget(
              title: 'IOT',
              icon: Icons.sensors,
              // Sem rota definida → apenas visual
            ),
            ItemPageWidget(
              title: 'Consoles',
              icon: Icons.message,
              route: Routes.consoles,
            ),
            const ItemPageWidget(
              title: 'Configurações',
              icon: Icons.settings,
              // Sem rota definida → apenas visual
            ),
          ],
        ),
      ),
    );
  }
}
