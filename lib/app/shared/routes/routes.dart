import 'package:flutter/material.dart';
import 'package:lablinker/app/views/launch/launch_page.dart';

enum Path{

  launch('/start'),
  home('/home');

  final String path;
  const Path(this.path);
}
  
class Routes {
  static String initialRoute = Path.launch.path;

  static String get home => Path.home.path;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    if(settings.name == Path.launch.path){
      return MaterialPageRoute(builder: (_) => const LaunchPage());
    }
    else if(settings.name == Path.home.path){
      return MaterialPageRoute(builder: (_) => const Scaffold());
    }
    else{
      return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}