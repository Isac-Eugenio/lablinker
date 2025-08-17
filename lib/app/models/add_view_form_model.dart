import 'package:lablinker/app/models/protocol_model.dart';

import 'network_model.dart';


enum ViewsEnum {
  input("Cena"),
  consoles("Terminal"),
  gamepad("Gamepad"),
  pwm("Pwm");

  final String type;
  const ViewsEnum(this.type);
}

class AddViewFormModel<T extends NetworkModel> {
  final String? description;
  final ProtocolsEnum? protocol;
  late final List<T>? networks;
  final ViewsEnum typeView;

  String? _title;
  int _index = 0;

  AddViewFormModel(
      this.typeView, {
        required this.description,
        required this.protocol,
        required this.networks,
      });

  set setTitle(String value) => _title = value;
  String? get title => _title ?? "${typeView.type} $_index";

  set setIndex(int value) => _index = value;
  int get index => _index;
}

