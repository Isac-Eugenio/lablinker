import 'package:flutter/material.dart';

import 'item_menu_gamepad_widget.dart';

class ListviewMenuGamepad extends StatelessWidget{
  final List<ItemMenuGamepadWidget> lista;
  const ListviewMenuGamepad({super.key,required this.lista});

  int get length => lista.length;

  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsetsGeometry.all(6), children: lista);
  }
}
