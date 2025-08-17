import 'package:flutter/material.dart';
import 'package:lablinker/app/views/menu_gamepad/widgets/item_menu_gamepad_widget.dart';
import 'package:lablinker/app/views/menu_gamepad/widgets/listview_menu_gamepad.dart';

import '../../models/protocol_model.dart';
import '../../shared/routes/routes.dart';
import '../../shared/widgets/custom_app_bar_widget.dart';
import '../../shared/widgets/floating_add_button_widget.dart';

class MenuGamepadView extends StatelessWidget {
  MenuGamepadView({super.key});

  final List<ItemMenuGamepadWidget> lista = [
    ItemMenuGamepadWidget(
      subtitle: "Item teste",
      protocol: ProtocolsEnum.bluetooth,
      index: 0,
    ),
    ItemMenuGamepadWidget(
      subtitle: "Item teste",
      protocol: ProtocolsEnum.mqtt,
      index: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade400,
      appBar: CustomAppBarWidget(title: "Gamepads", route: RoutesName.home),
      body: ListviewMenuGamepad(lista: lista),
      floatingActionButton: FloatingAddButtonWidget(),
    );
  }
}
