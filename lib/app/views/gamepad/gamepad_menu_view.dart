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

class GamepadMenuView extends BaseView {
  GamepadMenuView({super.key})
      : super(
    title: 'Gamepad Menu',
    rollback: true, // Permite voltar para rota anterior
    route: Routes.home, // Rota padrão
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
    return Column(
      children: [
        const Expanded(
          child: Center(
            child: Text('Gamepad Menu Content Here'), // Conteúdo do menu
          ),
        ),
      ],
    );
  }
}
