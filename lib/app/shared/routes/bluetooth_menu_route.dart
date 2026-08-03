import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/communication/bluetooth/bluetooth_menu_view.dart';
import 'package:lablinker/app/shared/routes/routes_config.dart';
import 'package:page_transition/page_transition.dart';

class BluetoohMenuRoute extends RouteConfig {
  static const String getPath = "/bluetooth_menu";

  const BluetoohMenuRoute() : super("   Conectar Bluetooth", getPath, null);

  PageTransition<dynamic> get materialPage => PageTransition(
    settings: RouteSettings(name: path),
    type: PageTransitionType.rightToLeft,
    alignment: Alignment.center,
    duration: const Duration(milliseconds: 600),
    child: BluetoothMenuView(title: super.alias),
  );
}
