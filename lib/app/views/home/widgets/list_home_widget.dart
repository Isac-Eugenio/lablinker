import 'dart:math';
import 'package:flutter/material.dart';

import '../../../shared/modelviews/page_navigator_viewmodel.dart';
import '../../../shared/routes/routes.dart';
import '../../../shared/theme/theme_widgets.dart';
import '../../../shared/widgets/custom_gesture_widget.dart';
import 'item_home_widget.dart';

class ListHomeWidget {
  final BuildContext context;

  ListHomeWidget(this.context);

  List<Widget> list() => [
    item("Gamepads", Icons.gamepad_outlined, RoutesName.menuGamepad),
    item("Inputs Analogic", Icons.speed_outlined, RoutesName.control),
    item("Inputs", Icons.toggle_on_outlined, RoutesName.control),
    item("Terminal", Icons.chat_outlined, RoutesName.home),
  ];

  Widget item(String title, IconData icon, RoutesName route) =>
      CustomGestureWidget(
        child: ItemHomeWidget(
          icon: icon,
          title: title,
          color: Colors.transparent,
          length: 4,
        ),
        onTap: () => pageNavigatorViewModel.go(route, context),
      );

  Widget get wrapMenu => Wrap(
    spacing: 8,
    runSpacing: 8,
    direction: Axis.horizontal,
    alignment: WrapAlignment.center,
    children: list(),
  );

  Color randomColorItem() {
    final random = Random();
    return palette[random.nextInt(palette.length)];
  }
}
