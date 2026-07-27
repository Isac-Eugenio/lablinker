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
import 'package:lablinker/app/shared/routes/routes_config.dart';
import 'package:lablinker/app/shared/widgets/app_bar_widget.dart';
import 'package:lablinker/app/shared/widgets/adaptive_grid_menu.dart';
import 'package:lablinker/app/shared/widgets/item_page_widget.dart';
import 'package:lablinker/app/shared/routes/routes.dart';
import 'package:lablinker/app/views/protocols_menu/protocols_menu_model_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  final String title;

  const HomeView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    ProtocolsMenuModelView protocolsMenuModelView = context
        .watch<ProtocolsMenuModelView>();

    return Scaffold(
      // Barra de navegação personalizada
      appBar: AppBarWidget(title: title, rollback: false),

      body: SafeArea(
        child: AdaptiveGridMenu(
          // Lista de itens do menu
          mode: AdaptiveGridMenuMode.grid,
          items: [
            // Cada item é um ItemPageWidget que pode ter rota de navegação
            ItemPageWidget(
              title: 'Gamepad',
              icon: Icons.videogame_asset,
              action: () =>
                  protocolsMenuModelView.setTypeView(ModeTypeview.gamepad),
            ),
            ItemPageWidget(
              title: 'IOT',
              icon: Icons.sensors,
              action: () =>
                  protocolsMenuModelView.setTypeView(ModeTypeview.iot),
              // Sem rota definida → apenas visual
            ),
            ItemPageWidget(
              title: 'Consoles',
              icon: Icons.message,
              route: Routes.protocolsRoute.path,
              action: () =>
                  protocolsMenuModelView.setTypeView(ModeTypeview.console),
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
