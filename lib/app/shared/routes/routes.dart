/*
------------------------------------
Arquivo: routes.dart
Descrição: Define todas as rotas do app, incluindo navegação com transições e rotas iniciais
Autor: Isac Eugenio
------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/bluetooth_menu_route.dart';
import 'package:lablinker/app/shared/routes/console_bluetooth_route.dart';
import 'package:lablinker/app/shared/routes/gamepad_menu_route.dart';
import 'package:lablinker/app/shared/routes/home_route.dart';
import 'package:lablinker/app/shared/routes/launch_route.dart';
import 'package:lablinker/app/shared/routes/not_found_route.dart';
import 'package:lablinker/app/shared/routes/protocols_route.dart';
import 'package:lablinker/app/shared/routes/routes_config.dart';
import 'package:signals/signals_flutter.dart';

class Routes {
  static Signal<ModeTypeview> modeTypeview = Signal(ModeTypeview.console);

  static HomeRoute get homeRoute => HomeRoute();
  static ConsoleBluetoothRoute get consoleBluetoothRoute =>
      ConsoleBluetoothRoute();
  static LaunchRoute get launchRoute => LaunchRoute();
  static NotFoundRoute get notFoundRoute => NotFoundRoute();
  static ProtocolsRoute get protocolsRoute =>
      ProtocolsRoute(modeTypeview.value);

  static BluetoohMenuRoute get bluetoohMenuRoute => BluetoohMenuRoute();
  static GamepadMenuRoute get gamepaMenuRoute => GamepadMenuRoute();

  static String get initialRoute => launchRoute.path;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return switch (settings.name) {
      HomeRoute.getPath => homeRoute.materialPage,
      LaunchRoute.getPath => launchRoute.materialPage,
      ProtocolsRoute.getPath => protocolsRoute.materialPage,
      GamepadMenuRoute.getPath => gamepaMenuRoute.materialPage,
      ConsoleBluetoothRoute.getPath => consoleBluetoothRoute.materialPage,
      BluetoohMenuRoute.getPath => bluetoohMenuRoute.materialPage,
      _ => notFoundRoute.materialPage,
    };
  }

  static RouteConfig? fromPath(String? path) {
    return switch (path) {
      HomeRoute.getPath => homeRoute,
      LaunchRoute.getPath => launchRoute,
      ProtocolsRoute.getPath => protocolsRoute,
      GamepadMenuRoute.getPath => gamepaMenuRoute,
      ConsoleBluetoothRoute.getPath => consoleBluetoothRoute,
      BluetoohMenuRoute.getPath => bluetoohMenuRoute,
      _ => null,
    };
  }
}
