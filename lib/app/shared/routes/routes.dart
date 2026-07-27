/*
------------------------------------
Arquivo: routes.dart
Descrição: Define todas as rotas do app, incluindo navegação com transições e rotas iniciais
Autor: Isac Eugenio
------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/console_bluetooth_route.dart';
import 'package:lablinker/app/shared/routes/home_route.dart';
import 'package:lablinker/app/shared/routes/launch_route.dart';
import 'package:lablinker/app/shared/routes/not_found_route.dart';
import 'package:lablinker/app/shared/routes/protocols_route.dart';
import 'package:lablinker/app/shared/routes/routes_config.dart';
import 'package:signals/signals_flutter.dart';

class Routes {
  static Signal<ModeTypeview> modeTypeview = Signal(ModeTypeview.console);

  static HomeRoute get homeRoute => HomeRoute();
  static ConsoleBluetoothRoute get consoleBluetoothRoute => ConsoleBluetoothRoute();
  static LaunchRoute get launchRoute => LaunchRoute();
  static NotFoundRoute get notFoundRoute => NotFoundRoute();
  static ProtocolsRoute get protocolsRoute =>
      ProtocolsRoute(modeTypeview.value);
  static String get initialRoute => launchRoute.path;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return switch (settings.name) {
      HomeRoute.getPath => homeRoute.materialPage,
      LaunchRoute.getPath => launchRoute.materialPage,
      ProtocolsRoute.getPath => protocolsRoute.materialPage,
      ConsoleBluetoothRoute.getPath => consoleBluetoothRoute.materialPage,
      _ => notFoundRoute.materialPage,
    };
  }
}

/* // Enum que define caminhos do app
enum Path {
  launch('/start'),
  home('/home'),
  teste('/teste'),
  gamepad('/gamepad'),
  iot('/iot'),
  consoles('/consoles'),
  settings('/settings'),
  addNetwork('/add_network');

  final String path;
  const Path(this.path);
}

class Routes {
  // Rota inicial do app
  static String initialRoute = Path.launch.path;

  // Getters para acessar rotas facilmente
  static String get home => Path.home.path;
  static String get teste => Path.teste.path;
  static String get gamepad => Path.gamepad.path;
  static String get iot => Path.iot.path;
  static String get consoles => Path.consoles.path;
  static String get settings => Path.settings.path;
  static String get addNetwork => Path.addNetwork.path;

  // Gera rotas dinamicamente com base no nome
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == Path.launch.path) {
      return MaterialPageRoute(builder: (_) => const LaunchPage());
    } else if (settings.name == Path.home.path) {
      // Transição direita-esquerda para HomePage
      return PageTransition(
        type: PageTransitionType.rightToLeft,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 600),
        child: HomeView(),
      );
    } /* Rotas comentadas para testes
    else if (settings.name == Path.teste.path) {
      return MaterialPageRoute(builder: (_) => TesteView());
    } */
    else if (settings.name == Path.gamepad.path) {
      // Transição tipo "size" para GamepadMenuView
      return PageTransition(
        type: PageTransitionType.size,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 600),
        child: GamepadMenuView(),
      );
    } else if (settings.name == Path.iot.path) {
      // Rota simples para página IOT
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('IOT')),
          body: const Center(child: Text('Página de IOT')),
        ),
      );
    } else if (settings.name == Path.consoles.path) {
      // Transição tipo "size" para ConsoleView
      return PageTransition(
        type: PageTransitionType.size,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 600),
        child: ConsoleView(),
      );
    } else if (settings.name == Path.settings.path) {
      // Rota simples para Configurações
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('Configurações')),
          body: const Center(child: Text('Página de Configurações')),
        ),
      );
    } else if (settings.name == Path.addNetwork.path) {
      // Transição topo-baixo para NetworkMenu
      return PageTransition(
        type: PageTransitionType.topToBottom,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 600),
        child: NetworkMenu(),
      );
    } else {
      // Rota padrão caso não encontrada
      return MaterialPageRoute(
        builder: (_) =>
        const Scaffold(body: Center(child: Text('Página não encontrada'))),
      );
    }
  }
}
 */
