import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes_config.dart';
import 'package:lablinker/app/views/home/home_view.dart';

class NotFoundRoute extends RouteConfig {
  static const String getPath = "/not_found";

  const NotFoundRoute() : super("NotFound", getPath, null);

  MaterialPageRoute<dynamic> get materialPage => route(null, HomeView(title: super.alias));
}
