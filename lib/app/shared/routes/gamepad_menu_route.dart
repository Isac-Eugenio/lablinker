import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes_config.dart';
import 'package:lablinker/app/views/gamepad/gamepad_menu_view.dart';
import 'package:page_transition/page_transition.dart';

class GamepadMenuRoute extends RouteConfig {
  static const String getPath = "/gamepad_bluetooth";

  const GamepadMenuRoute() : super("gamepad", getPath, ModeTypeview.gamepad);

  PageTransition<dynamic> get materialPage => PageTransition(
    settings: RouteSettings(name: path),
    type: PageTransitionType.rightToLeft,
    alignment: Alignment.center,
    duration: const Duration(milliseconds: 600),
    child: GamepadMenuView(),
  );
}
