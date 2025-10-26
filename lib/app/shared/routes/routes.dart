import 'package:flutter/material.dart';
import 'package:lablinker/app/views/gamepad/gamepad_menu_view.dart';
import 'package:lablinker/app/views/home/home_page.dart';
import 'package:lablinker/app/views/launch/launch_page.dart';
import 'package:lablinker/app/views/teste_view/teste_view.dart';
import 'package:page_transition/page_transition.dart';

enum Path {
  launch('/start'),
  home('/home'),
  teste('/teste'),
  
  gamepad('/gamepad'),
  iot('/iot'),
  consoles('/consoles'),
  settings('/settings');

  final String path;
  const Path(this.path);
}

class Routes {
  static String initialRoute = Path.launch.path;

  static String get home => Path.home.path;
  static String get teste => Path.teste.path;
  static String get gamepad => Path.gamepad.path;
  static String get iot => Path.iot.path;
  static String get consoles => Path.consoles.path;
  static String get settings => Path.settings.path;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == Path.launch.path) {
      return MaterialPageRoute(builder: (_) => const LaunchPage());

    } else if (settings.name == Path.home.path) {
      return PageTransition(
        type: PageTransitionType.rightToLeft,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 600),
        child: HomePage(),
      );

    } else if (settings.name == Path.teste.path) {
      return MaterialPageRoute(builder: (_) => TesteView());
    } 
    
    else if (settings.name == Path.gamepad.path) {
      // Adicione a rota para Gamepad aqui
      return PageTransition(type: PageTransitionType.size,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 600),
        child: GamepadMenuView()
      );
    } 
    
    else if (settings.name == Path.iot.path) {
      // Adicione a rota para IOT aqui
      return MaterialPageRoute(builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('IOT')),
        body: const Center(child: Text('Página de IOT')),
      ));
    } 
    
    else if (settings.name == Path.consoles.path) {
      // Adicione a rota para Consoles aqui
      return MaterialPageRoute(builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Consoles')),
        body: const Center(child: Text('Página de Consoles')),
      ));
    } 
    
    else if (settings.name == Path.settings.path) {
      // Adicione a rota para Configurações aqui
      return MaterialPageRoute(builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Configurações')),
        body: const Center(child: Text('Página de Configurações')),
      ));
    }
    else {
      return MaterialPageRoute(
        builder: (_) =>
            const Scaffold(body: Center(child: Text('Página não encontrada'))),
      );
    }
  }
}