import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes_config.dart';
import 'package:lablinker/app/views/launch/launch_page.dart';

class LaunchRoute extends RouteConfig {
  static const String getPath = "/launch";

  const LaunchRoute() : super("Launch", getPath, null);

  MaterialPageRoute<dynamic> get materialPage => route(null, LaunchPage());
}
