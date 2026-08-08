import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/route_context.dart';
import 'package:lablinker/app/shared/routes/routes.dart';

class RouteObserverApp extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    RouteContext.previousRoute.set(RouteContext.currentRoute.get());

    RouteContext.currentRoute.set(Routes.fromPath(route.settings.name));

     debugPrint(
      "Routa mudou didpush: atual ${RouteContext.currentRoute.value} anterior ${RouteContext.previousRoute.value}",
    );
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    RouteContext.previousRoute.set(RouteContext.currentRoute.get());

    RouteContext.currentRoute.set(Routes.fromPath(route.settings.name));

    debugPrint(
      "Routa mudou didpop: atual ${RouteContext.currentRoute.value} anterior ${RouteContext.previousRoute.value}",
    );
  }
}
