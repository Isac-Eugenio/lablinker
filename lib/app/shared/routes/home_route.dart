import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes_config.dart';
import 'package:lablinker/app/views/home/home_view.dart';
import 'package:page_transition/page_transition.dart';

class HomeRoute extends RouteConfig {
  static const String getPath = "/home";

  const HomeRoute() : super("Home", getPath, null);

  PageTransition<dynamic> get materialPage => PageTransition(
    settings: RouteSettings(name: path),
    type: PageTransitionType.rightToLeft,
    alignment: Alignment.center,
    duration: const Duration(milliseconds: 600),
    child: HomeView(title: super.alias),
  );
}
