import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/modelviews/bluetooth_modelview.dart';
import 'package:lablinker/app/views/form_add_scene_gamepad/form_add_scene_gamepad_view.dart';
import 'package:lablinker/app/views/form_new_network/form_new_network_view.dart';
import 'package:provider/provider.dart';
import '../../views/animations/lab_banner/lab_banner_view.dart';
import '../../views/animations/logo_banner/logo_banner_view.dart';
import '../../views/home/home_view.dart';
import '../../views/menu_gamepad/menu_gamepad_view.dart';
import '../../views/not_found/not_found_view.dart';

enum RoutesName {
  control('/control'),
  initial('/logo_cmi'),
  logo('/logo_app'),
  home('/home'),
  menuGamepad('/menu_gamepad'),
  formAddSceneGamepad('/form_add_scene_gamepad'),
  formNetworkView('/form_network_view');

  final String route;
  const RoutesName(this.route);
}

class Routes {
  static final String formNetworkView = RoutesName.formNetworkView.route;
  static final String menuGamepadRoute = RoutesName.menuGamepad.route;
  static final String controlRoute = RoutesName.control.route;
  static final String initialRoute = RoutesName.initial.route;
  static final String logoRoute = RoutesName.logo.route;
  static final String homeRoute = RoutesName.home.route;

  static final String formAddSceneGamepad =
      RoutesName.formAddSceneGamepad.route;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final name = settings.name;

    if (name == RoutesName.initial.route) {
      return MaterialPageRoute(
        builder: (_) => FormAddSceneGamepadView(
          rollbackRoute: RoutesName.menuGamepad,
          titleView: "Novo Gamepad",
        ),
      );
    } else if (name == RoutesName.logo.route) {
      return MaterialPageRoute(builder: (_) => LogoBannerView());
    } else if (name == RoutesName.home.route) {
      return MaterialPageRoute(builder: (_) => HomeView());
    } else if (name == RoutesName.menuGamepad.route) {
      return MaterialPageRoute(builder: (_) => MenuGamepadView());
    } else if (name == RoutesName.formNetworkView.route) {
      return MaterialPageRoute(
        builder: (context) => FormNewNetworkView(
          formModelNotifier: context.watch<BluetoothModelView>(),
        ),
      );
    } else if (name == RoutesName.formAddSceneGamepad.route) {
      return MaterialPageRoute(
        builder: (_) => FormAddSceneGamepadView(
          rollbackRoute: RoutesName.menuGamepad,
          titleView: 'Novo Gamepad',
        ),
      );
    } else {
      return MaterialPageRoute(builder: (_) => const NotFoundView());
    }
  }
}
