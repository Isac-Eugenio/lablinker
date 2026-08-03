import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes_config.dart';
import 'package:signals/signals_flutter.dart';

class RouteContext {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState? get navigator => navigatorKey.currentState;

  static final currentRoute = signal<RouteConfig?>(null);

  static final previousRoute = signal<RouteConfig?>(null);

  static void updateRoute(RouteConfig? route) {
    previousRoute.value = currentRoute.value;
    currentRoute.value = route;
  }

  static Future<T?> pushNamed<T extends Object?>(
    String route, {
    Object? arguments,
  }) {
    return navigator!.pushNamed<T>(route, arguments: arguments);
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String route, {
    Object? arguments,
    TO? result,
  }) {
    return navigator!.pushReplacementNamed<T, TO>(
      route,
      arguments: arguments,
      result: result,
    );
  }

  static void pop<T extends Object?>([T? result]) {
    navigator?.pop(result);
  }
}
