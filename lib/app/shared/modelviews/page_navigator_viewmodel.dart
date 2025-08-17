import 'package:flutter/material.dart';
import '../routes/routes.dart';

class PageNavigatorViewModel {
  void go(RoutesName route, BuildContext context) => Navigator.of(
    context,
  ).pushNamedAndRemoveUntil(route.route, (route) => false);

  void goRollBack(RoutesName route, BuildContext context) =>
      Navigator.of(context).pushReplacementNamed(route.route);
}

PageNavigatorViewModel pageNavigatorViewModel = PageNavigatorViewModel();
