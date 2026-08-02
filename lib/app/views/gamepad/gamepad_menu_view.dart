/*
-----------------------------------------------------------
Arquivo: gamepad_menu_view.dart
Descrição: Tela de menu para Gamepad. Permite futuras ações
           via botão flutuante e exibe conteúdo do menu.
Autor: Isac Eugenio
-----------------------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes.dart';
import 'package:lablinker/app/views/base_view.dart';
import 'package:lablinker/app/shared/widgets/adaptive_grid_menu.dart';
import 'package:lablinker/app/shared/widgets/item_page_widget.dart';

class GamepadMenuView extends BaseView {
  GamepadMenuView({super.key})
    : super(
        title: 'Gamepad Menu',
        rollback: true, // Permite voltar para rota anterior
        route: Routes.homeRoute.path, // Rota padrão
        floatingActionButtonIcon: Icons.add, // Ícone do FAB
        floatingActionButtonVisible: true, // Exibe FAB
        floatingActionButtonOnPressed: null, // Ação do FAB (ainda não definida)
      );

  @override
  BaseViewState<BaseView> createState() => GamepadMenuViewState();
}

class GamepadMenuViewState extends BaseViewState<GamepadMenuView> {
  @override
  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: AdaptiveGridMenu(
          items: [
            ItemPageWidget(
              title: 'Bluetooth',
              icon: Icons.bluetooth_outlined,
              route: Routes.bluetoohMenuRoute.path,
            ),
            ItemPageWidget(
              title: 'Http',
              icon: Icons.http_outlined,
              // Sem rota definida → apenas visual
            ),
            ItemPageWidget(title: 'Mqtt', icon: Icons.sensors_outlined),
          ],
          mode: AdaptiveGridMenuMode.grid,
        ),
      ),
    );
  }
}
