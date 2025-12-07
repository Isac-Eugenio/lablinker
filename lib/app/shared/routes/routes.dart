/*
------------------------------------
Arquivo: routes.dart
Descrição: Define todas as rotas do app, incluindo navegação com transições e rotas iniciais
Autor: Isac Eugenio
------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:lablinker/app/views/console/console_view.dart';
import 'package:lablinker/app/views/gamepad/gamepad_menu_view.dart';
import 'package:lablinker/app/views/home/home_view.dart';
import 'package:lablinker/app/views/launch/launch_page.dart';
import 'package:lablinker/app/views/network_menu/network_menu.dart';
import 'package:page_transition/page_transition.dart';

// Enum que define caminhos do app
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
