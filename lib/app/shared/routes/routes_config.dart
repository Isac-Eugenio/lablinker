import 'package:flutter/material.dart';

enum ModeTypeview {
  gamepad,
  console,
  iot
}

abstract class RouteConfig extends RouteSettings {
  final String alias;
  final String path;

  final ModeTypeview? typeview;

  const RouteConfig(this.alias, this.path, this.typeview) : super(name: path);

  MaterialPageRoute route(BuildContext? context, Widget page) {
    return MaterialPageRoute(builder: (context) => page);
  }
}