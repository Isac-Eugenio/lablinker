import 'package:flutter/material.dart';
import 'package:lablinker/app/models/network_model.dart';
import 'package:lablinker/app/models/protocol_model.dart';
import 'add_view_form_model.dart';

class BluetoothFormModel extends AddViewFormModel<BluetoothNetworkModel> {
  BluetoothFormModel({required String? description})
    : super(
        ViewsEnum.gamepad,
        description: description,
        protocol: ProtocolsEnum.bluetooth,
        networks: <BluetoothNetworkModel>[
          BluetoothNetworkModel(name: "Conexão 1", address: ""),
          BluetoothNetworkModel(name: "Conexão 2", address: "")
        ],
      );
}

class BluetoothNetworkModel extends NetworkModel {
  BluetoothNetworkModel({required super.name, required super.address})
    : super(icon: Icons.bluetooth_outlined);
}
