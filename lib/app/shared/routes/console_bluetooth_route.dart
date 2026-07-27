import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes_config.dart';
import 'package:lablinker/app/views/console/bluetooth/console_bluetooth_view.dart';
import 'package:page_transition/page_transition.dart';

class ConsoleBluetoothRoute extends RouteConfig {
  static const String getPath = "/console_bluetooth";

  const ConsoleBluetoothRoute() : super("console", getPath, ModeTypeview.console);

  PageTransition<dynamic> get materialPage => PageTransition(
        type: PageTransitionType.rightToLeft,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 600),
        child: ConsoleBluetoothView(titleView: super.alias),
      );
}
