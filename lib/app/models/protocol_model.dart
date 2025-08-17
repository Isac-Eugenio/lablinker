import 'package:flutter/material.dart';

enum ProtocolsEnum {
  bluetooth("Bluetooth", Icons.bluetooth_outlined),
  http("HTTP", Icons.http_outlined),
  mqtt("MQTT", Icons.wifi_tethering),
  protocolDefault("escolha um protocolo", null);

  final IconData? icon;
  final String label;
  const ProtocolsEnum(this.label, this.icon);

  static List<String> get labels => values.map((e) => e.label).toList();

  static List<IconData?> get icons => values.map((e) => e.icon).toList();
}

class ProtocolModel {
  final ProtocolsEnum type;
  List<Network>? networks;

  ProtocolModel(this.type, {this.networks});
}

class Network {
  String? name;
  String? address;
  int? port;
  String? username;
  String? password;
  Map<String, dynamic>? extra;

  Network({
    this.name,
    this.address,
    this.port,
    this.username,
    this.password,
    this.extra,
  });
}
