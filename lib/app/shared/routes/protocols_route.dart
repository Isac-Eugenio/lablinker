import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes_config.dart';
import 'package:lablinker/app/views/protocols_menu/protocols_menu_view.dart';
import 'package:page_transition/page_transition.dart';

class ProtocolsRoute extends RouteConfig {
  static const String getPath = "/protocols_menu";

  final ModeTypeview modeTypeview;

  const ProtocolsRoute(this.modeTypeview)
    : super("Meio de Comunicação", getPath, null);

  PageTransition<dynamic> get materialPage => PageTransition(
    settings: RouteSettings(name: path),
    type: PageTransitionType.rightToLeft,
    alignment: Alignment.center,
    duration: const Duration(milliseconds: 600),
    child: ProtocolsView(super.alias),
  );
}
