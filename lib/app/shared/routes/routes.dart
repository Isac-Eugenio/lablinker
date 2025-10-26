import 'package:flutter/material.dart';
import 'package:lablinker/app/views/home/home_page.dart';
import 'package:lablinker/app/views/launch/launch_page.dart';
import 'package:lablinker/app/views/teste_view/teste_view.dart';

enum Path{

  launch('/start'),
  home('/home'),
  teste('/teste');

  final String path;
  const Path(this.path);
}
  
class Routes {
  static String initialRoute = Path.teste.path;

  static String get home => Path.home.path;
  static String get teste => Path.teste.path;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    if(settings.name == Path.launch.path){
      return MaterialPageRoute(builder: (_) => const LaunchPage());
    }
    else if(settings.name == Path.home.path){
      return MaterialPageRoute(builder: (_) => HomePage());
    }
    else if(settings.name == Path.teste.path){
      return MaterialPageRoute(builder: (_) => TesteView());
    }
    else{
      return MaterialPageRoute(builder: (_) => const Scaffold(
        body: Center(
          child: Text('Página não encontrada'),
        ),
      ));
    }
  }
}