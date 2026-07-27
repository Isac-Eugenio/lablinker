import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes_config.dart';

class ProtocolsMenuModelView extends ChangeNotifier {
  ModeTypeview? _typeview;

  ModeTypeview? get typeView => _typeview;

  void setTypeView(ModeTypeview view) {
    _typeview = view;
    notifyListeners();
  }
}
