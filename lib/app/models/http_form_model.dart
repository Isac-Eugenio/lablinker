import 'package:flutter/material.dart';
import 'package:lablinker/app/models/add_view_form_model.dart';
import 'package:lablinker/app/models/network_model.dart';
import 'package:lablinker/app/models/protocol_model.dart';

class HttpFormModel extends AddViewFormModel<HttpNetworkModel> {
  HttpFormModel({required String? description})
    : super(
        ViewsEnum.gamepad,
        description: description,
        protocol: ProtocolsEnum.http,
        networks: [],
      );
}

class HttpNetworkModel extends NetworkModel {
  HttpNetworkModel({required super.name, required super.address})
    : super(icon: Icons.http_outlined);
}
