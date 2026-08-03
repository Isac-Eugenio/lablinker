// ignore_for_file: public_member_api_docs, sort_constructors_first
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
import 'package:lablinker/app/shared/communication/bluetooth/bluetooth_case.dart';
import 'package:lablinker/app/shared/routes/routes.dart';
import 'package:lablinker/app/shared/routes/routes_config.dart';
import 'package:lablinker/app/shared/widgets/app_bar_widget.dart';
import 'package:lablinker/app/shared/widgets/adaptive_grid_menu.dart';
import 'package:lablinker/app/shared/widgets/item_page_widget.dart';
import 'package:provider/provider.dart';

class ProtocolsView extends StatelessWidget {
  final String title;
  const ProtocolsView(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra de navegação personalizada
      appBar: AppBarWidget(
        title: title,
        rollback: true,
        route: Routes.homeRoute.path,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: AdaptiveGridMenu(
            // Lista de itens do menu
            mode: AdaptiveGridMenuMode.grid,
            items: [
              ItemPageWidget(
                title: "Bluetooth",
                icon: Icons.bluetooth_outlined,
                route: switch (Routes.modeTypeview.get()) {
                  ModeTypeview.gamepad => Routes.gamepaMenuRoute.path,
                  ModeTypeview.console => Routes.consoleBluetoothRoute.path,
                  ModeTypeview.iot => Routes.homeRoute.path,
                },
              ),
              ItemPageWidget(
                title: "HTTP",
                icon: Icons.http_outlined,
                action: () => debugPrint("${Routes.modeTypeview.value}"),
              ),
              ItemPageWidget(
                title: "MQTT",
                icon: Icons.sensors_outlined,

                action: () {
                  BluetoothCase caset = context.read<BluetoothCase>();
                  debugPrint(caset.value.connectedDevice?.name ?? "vazio");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
