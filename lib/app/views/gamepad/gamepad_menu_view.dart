/*
-----------------------------------------------------------
Arquivo: gamepad_menu_view.dart
Descrição: Tela de menu para Gamepad. Permite futuras ações
           via botão flutuante e exibe conteúdo do menu.
Autor: Isac Eugenio
-----------------------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/communication/bluetooth/bluetooth_case.dart';
import 'package:lablinker/app/shared/routes/routes.dart';
import 'package:lablinker/app/shared/widgets/base_view.dart';
import 'package:lablinker/app/shared/widgets/adaptive_grid_menu.dart';
import 'package:lablinker/app/shared/widgets/item_page_widget.dart';
import 'package:lablinker/app/views/gamepad/gamepad_menu_model_view.dart';
import 'package:provider/provider.dart';

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
  late final GamepadMenuModelView model;

  @override
  void initState() {
    super.initState();

    model = GamepadMenuModelView(context.read<BluetoothCase>());

    model.addListener(_onModelChanged);

    debugPrint("${model.bluetoothCase.value.isAvailable}");

    Future.microtask(
      () => model.isInitialized ? () {} : model.init(),
    );
  }

  void _onModelChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    model.removeListener(_onModelChanged);
    model.dispose();
    super.dispose();
  }

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
              action: () {
                debugPrint(model.connectedDevice?.name ?? "sem nome");
              },
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
